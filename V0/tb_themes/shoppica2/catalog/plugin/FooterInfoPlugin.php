<?php

class Theme_Catalog_FooterInfoPlugin extends TB_ExtensionPlugin
{
    public function execute(TB_DataBag $tbData)
    {
        if (isset($this->extension_settings['footerInfo'][$this->language_id])) {
            $footerInfo = $this->extension_settings['footerInfo'][$this->language_id];

            $event = new sfEvent($this, 'theme:catalog_footerInfo_plugin.filter_footerInfo', array('tbData' => $tbData));
            $footerInfo = $this->eventDispatcher->filter($event, $footerInfo)->getReturnValue();

            $footerInfo['columns_cnt'] =
                (int) $footerInfo['info_enabled']     +
                (int) $footerInfo['contacts_enabled'] +
                (int) $footerInfo['twitter_enabled']  +
                (int) $footerInfo['facebook_enabled'];
        } else {
            $footerInfo['columns_cnt']      = 0;
            $footerInfo['info_enabled']     = 0;
            $footerInfo['contacts_enabled'] = 0;
            $footerInfo['twitter_enabled']  = 0;
            $footerInfo['facebook_enabled'] = 0;
        }

        $tweets = array();
        if ($footerInfo['twitter_enabled'] && $footerInfo['twitter_integration'] == 'custom' && function_exists('curl_init')) {
            if  (!($tweets = $this->registry->get('cache')->get('twitter_latest_tweets_' . $this->language_id))) {
                $tweets = $this->getTweets($footerInfo);
                if (!isset($tweets['error'])) {
                    $this->registry->get('cache')->set('twitter_latest_tweets_' . $this->language_id, $tweets);
                } else {
                    $tweets = $tweets['error'];
                    $tweets[]  = array('text' => 'Please, check your twitter settings in the admin panel');
                }
            }
        }
        $footerInfo['twitter_tweets'] = $tweets;

        $tbData->footerInfo = $footerInfo;
    }

    protected function getTweets($footerInfo)
    {
        $url = "https://api.twitter.com/1.1/statuses/user_timeline.json";

        $default_timezone = date_default_timezone_get();
        date_default_timezone_set('Pacific/Easter');
        $utc_time = strtotime(gmdate("M d Y H:i:s", time()));
        date_default_timezone_set($default_timezone);

        $oauth = array(
            'oauth_consumer_key'     => $footerInfo['twitter_consumer_key'],
            'oauth_nonce'            => $utc_time,
            'oauth_signature_method' => 'HMAC-SHA1',
            'oauth_token'            => $footerInfo['twitter_access_token'],
            'oauth_timestamp'        => $utc_time,
            'oauth_version'          => '1.0',
            'screen_name'            => $footerInfo['twitter_username']);

        $base_info = $this->buildBaseString($url, 'GET', $oauth);
        $composite_key = rawurlencode($footerInfo['twitter_consumer_secret']) . '&' . rawurlencode($footerInfo['twitter_access_secret']);
        $oauth_signature = base64_encode(hash_hmac('sha1', $base_info, $composite_key, true));
        $oauth['oauth_signature'] = $oauth_signature;

        $header = array($this->buildAuthorizationHeader($oauth), 'Content-Type: application/json', 'Expect:');
        $options = array(
            CURLOPT_HTTPHEADER     => $header,
            CURLOPT_HEADER         => false,
            CURLOPT_URL            => $url . '?screen_name=' . $footerInfo['twitter_username'],
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_SSL_VERIFYPEER => false
        );
        $feed = curl_init();
        curl_setopt_array($feed, $options);
        $json = curl_exec($feed);
        curl_close($feed);

        $tweets = array();

        $result = json_decode($json);
        if (isset($result->errors)) {
            foreach ($result->errors as $error) {
                $tweets[] = array('text' => $error->message);
            }

            return array ('error' => $tweets);
        }

        foreach ($result as $key => $tweet) {

            if ($footerInfo['twitter_hide_replies'] && '@' == substr(trim($tweet->text), 0, 1)) {
                continue;
            }

            if (count($tweets) == $footerInfo['twitter_max_tweets']) {
                break;
            }

            $tweets[$key]['time_ago'] = $this->timeElapsedString(strtotime($tweet->created_at));
            $tweets[$key]['text']     = $this->linkify($tweet->text);
            $tweets[$key]['id_str']   = $tweet->id_str;
        }

        return $tweets;
    }

    protected function linkify($string)
    {
        // linkify URLs
        $string = preg_replace(
            '/(https?:\/\/\S+)/',
            '<a href="\1">\1</a>',
            $string
        );

        // linkify twitter users
        $string = preg_replace(
            '/(^|\s)@(\w+)/',
            '\1<a href="http://twitter.com/\2">@\2</a>',
            $string
        );

        // linkify tags
        $string = preg_replace(
            '/(^|\s)#(\w+)/',
            '\1#<a href="http://search.twitter.com/search?q=%23\2">\2</a>',
            $string
        );

        return $string;
    }

    function timeElapsedString($timestamp){
        //type cast, current time, difference in timestamps
        $timestamp      = (int) $timestamp;
        $current_time   = time();
        $diff           = $current_time - $timestamp;

        //intervals in seconds
        $intervals = array (
            'year' => 31556926, 'month' => 2629744, 'week' => 604800, 'day' => 86400, 'hour' => 3600, 'minute'=> 60
        );

        $tbLang = $this->tbExtension->getTbLang();

        //now we just find the difference
        if ($diff == 0) {
            return $tbLang->get('text_just_now');
        }

        if ($diff < 60) {
            return $diff == 1 ? $tbLang->get('text_second_ago') : sprintf($tbLang->get('text_seconds_ago'), $diff);
        }

        if ($diff >= 60 && $diff < $intervals['hour']) {
            $diff = floor($diff/$intervals['minute']);

            return $diff == 1 ? $tbLang->get('text_minute_ago') : sprintf($tbLang->get('text_minutes_ago'), $diff);
        }

        if ($diff >= $intervals['hour'] && $diff < $intervals['day']) {
            $diff = floor($diff/$intervals['hour']);

            return $diff == 1 ? $tbLang->get('text_hour_ago') : sprintf($tbLang->get('text_hours_ago'), $diff);
        }

        if ($diff >= $intervals['day'] && $diff < $intervals['week']) {
            $diff = floor($diff/$intervals['day']);

            return $diff == 1 ? $tbLang->get('text_day_ago') : sprintf($tbLang->get('text_days_ago'), $diff);
        }

        if ($diff >= $intervals['week'] && $diff < $intervals['month']) {
            $diff = floor($diff/$intervals['week']);

            return $diff == 1 ? $tbLang->get('text_week_ago') : sprintf($tbLang->get('text_weeks_ago'), $diff);
        }

        if ($diff >= $intervals['month'] && $diff < $intervals['year']) {
            $diff = floor($diff/$intervals['month']);

            return $diff == 1 ? $tbLang->get('text_month_ago') : sprintf($tbLang->get('text_months_ago'), $diff);
        }

        if ($diff >= $intervals['year']) {
            $diff = floor($diff/$intervals['year']);

            return $diff == 1 ? $tbLang->get('text_year_ago') : sprintf($tbLang->get('text_years_ago'), $diff);
        }
    }

    protected function buildBaseString($baseURI, $method, $params) {
        $r = array();
        ksort($params);

        foreach($params as $key => $value){
            $r[] = "$key=" . rawurlencode($value);
        }

        return $method."&" . rawurlencode($baseURI) . '&' . rawurlencode(implode('&', $r));
    }

    protected function buildAuthorizationHeader($oauth) {
        $r = 'Authorization: OAuth ';
        $values = array();

        foreach($oauth as $key => $value)
            $values[] = "$key=\"" . rawurlencode($value) . "\"";
        $r .= implode(', ', $values);

        return $r;
    }
}