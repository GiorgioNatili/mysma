<?php

class TB_Utils
{
    public static function detectBrowser()
    {
        $userAgent = '';
        if (isset($_SERVER['HTTP_USER_AGENT'])) {
            $userAgent = strtolower($_SERVER['HTTP_USER_AGENT']);
        }

        if (preg_match('/opera/', $userAgent)) {
            $name = 'opera';
        }
        elseif (preg_match('/webkit/', $userAgent)) {
            $name = 'safari';
        }
        elseif (preg_match('/msie/', $userAgent)) {
            $name = 'msie';
        }
        elseif (preg_match('/mozilla/', $userAgent) && !preg_match('/compatible/', $userAgent)) {
            $name = 'mozilla';
        }
        else {
            $name = 'unrecognized';
        }

        if (preg_match('/.+(?:rv|it|ra|ie)[\/: ]([\d.]+)/', $userAgent, $matches)) {
            $version = $matches[1];
        }
        else {
            $version = 'unknown';
        }

        if (preg_match('/linux/', $userAgent)) {
            $platform = 'linux';
        }
        elseif (preg_match('/macintosh|mac os x/', $userAgent)) {
            $platform = 'mac';
        }
        elseif (preg_match('/windows|win32/', $userAgent)) {
            $platform = 'windows';
        }
        else {
            $platform = 'unrecognized';
        }

        return array(
            'name'      => $name,
            'version'   => $version,
            'platform'  => $platform,
            'userAgent' => $userAgent
        );
    }

    public static function isRequestHTTPS()
    {
        return isset($_SERVER['HTTPS']) && (!strcasecmp($_SERVER['HTTPS'], 'on') || $_SERVER['HTTPS'] == 1);
    }

    public static function getHost()
    {
        if (isset($_SERVER['HTTP_X_FORWARDED_HOST']) && $host = $_SERVER['HTTP_X_FORWARDED_HOST']) {
            $elements = explode(',', $host);
            $host = trim(end($elements));
        } else
        if (!$host = $_SERVER['HTTP_HOST']) {
            if (!$host = $_SERVER['SERVER_NAME']) {
                $host = !empty($_SERVER['SERVER_ADDR']) ? $_SERVER['SERVER_ADDR'] : '';
            }
        }
        // Remove port number from host
        $host = preg_replace('/:\d+$/', '', $host);

        return trim($host);
    }

    public static function glueUrl($parsed)
    {
        if (!is_array($parsed)) {
            return false;
        }

        $uri = isset($parsed['scheme']) ? $parsed['scheme'].':'.((strtolower($parsed['scheme']) == 'mailto') ? '' : '//') : '';
        $uri .= isset($parsed['user']) ? $parsed['user'].(isset($parsed['pass']) ? ':'.$parsed['pass'] : '').'@' : '';
        $uri .= isset($parsed['host']) ? $parsed['host'] : '';
        $uri .= isset($parsed['port']) ? ':'.$parsed['port'] : '';

        if (isset($parsed['path'])) {
            $uri .= (substr($parsed['path'], 0, 1) == '/') ?
                $parsed['path'] : ((!empty($uri) ? '/' : '' ) . $parsed['path']);
        }

        $uri .= isset($parsed['query']) ? '?'.$parsed['query'] : '';
        $uri .= isset($parsed['fragment']) ? '#'.$parsed['fragment'] : '';

        return $uri;
    }

    public static function modifyBase($base, $url, $force_ssl = false)
    {
        $base_parsed = parse_url($base);
        $base_host = $base_parsed['host'];

        if ('http' == $base_parsed['scheme'] && $force_ssl) {
            $base_parsed['scheme'] = 'https';
        }
        if (empty($base_parsed['scheme']) || !in_array($base_parsed['scheme'], array('http', 'https'))) {
            $base_parsed['scheme'] = $force_ssl ? 'https' : 'http';
        }

        $url_parsed = parse_url($base_parsed['scheme'] . '://' . $url);
        $url_host = $url_parsed['host'];

        if (stripos($url_host, $base_host) !== 0) {
            if (substr($url_host, 0, 4) == 'www.') {
                $base_host = 'www.' . $base_host;
            } else
                if (substr($base_host, 0, 4) == 'www.') {
                    $base_host = substr($base_host, 4);
                }
        }
        $base_parsed['host'] = $base_host;

        return self::glueUrl($base_parsed);
    }

    public static function compareUrlHostsEqual($url1, $url2)
    {
        if (substr($url1, 0, 4) != 'http') {
            $url1 = 'http://' . $url1;
        }

        if (substr($url2, 0, 4) != 'http') {
            $url2 = 'http://' . $url2;
        }

        $url1_parsed = parse_url($url1);
        $url2_parsed = parse_url($url2);

        $host1 = substr($url1_parsed['host'], 0, 4) == 'www.' ? substr($url1_parsed['host'], 4) : $url1_parsed['host'];
        $host2 = substr($url2_parsed['host'], 0, 4) == 'www.' ? substr($url2_parsed['host'], 4) : $url2_parsed['host'];

        return $host1 == $host2;
    }

    public static function genRandomString($length = 5)
    {
        $aZ09 = array_merge(range('A', 'Z'), range('a', 'z'), range(0, 9));
        shuffle($aZ09);
        $result ='';
        for($i = 0; $i < $length; $i++) {
           $result .= $aZ09[mt_rand(0, count($aZ09)-1)];
        }

        return str_shuffle($result);
    }

    public static function genRandomFloat($min, $max)
    {
       return ($min + lcg_value() * (abs($max - $min)));
    }

    /**
     * Returns a camelized string from a lower case and underscored string by replaceing slash with
     * double-colon and upper-casing each letter preceded by an underscore.
     *
     * @param  string $lower_case_and_underscored_word  String to camelize.
     *
     * @return string Camelized string.
     */
    public static function camelize($lower_case_and_underscored_word)
    {
        $tmp = $lower_case_and_underscored_word;
        $tmp = self::pregtr($tmp, array('#/(.?)#e'       => "'::'.strtoupper('\\1')",
                                        '/(^|_|-)+(.)/e' => "strtoupper('\\2')"));

        return $tmp;
    }

    /**
     * Returns an underscore-syntaxed version or the CamelCased string.
     *
     * @param  string $camel_cased_word  String to underscore.
     *
     * @return string Underscored string.
     */
    public static function underscore($camel_cased_word)
    {
        $tmp = $camel_cased_word;
        $tmp = str_replace('::', '/', $tmp);
        $tmp = self::pregtr($tmp, array('/([A-Z]+)([A-Z][a-z])/' => '\\1_\\2',
                                        '/([a-z\d])([A-Z])/'     => '\\1_\\2'));

        return strtolower($tmp);
    }

    /**
     * Returns subject replaced with regular expression matches
     *
     * @param mixed $search        subject to search
     * @param array $replacePairs  array of search => replace pairs
     *
     * @return string
     */
    public static function pregtr($search, array $replacePairs)
    {
        return preg_replace(array_keys($replacePairs), array_values($replacePairs), $search);
    }

    public static function vqmodCheck($filename)
    {
        if (!array_key_exists('vqmod', $GLOBALS)) {
            return $filename;
        }

        global $vqmod;

        return $vqmod->modCheck($filename);
    }
}

if (!function_exists('array_replace'))
{
  function array_replace( array &$array, array &$array1 )
  {
    $args = func_get_args();
    $count = func_num_args();

    for ($i = 0; $i < $count; ++$i) {
      if (is_array($args[$i])) {
        foreach ($args[$i] as $key => $val) {
          $array[$key] = $val;
        }
      }
      else {
        trigger_error(
          __FUNCTION__ . '(): Argument #' . ($i+1) . ' is not an array',
          E_USER_WARNING
        );
        return NULL;
      }
    }

    return $array;
  }
}

if(!function_exists('lcfirst'))
{
    function lcfirst($str)
    {
        $str[0] = strtolower($str[0]);

        return $str;
    }
}

if(!function_exists("date_create_from_format"))
{
    function date_create_from_format($dformat, $dvalue)
    {
        $schedule = $dvalue;
        $schedule_format = str_replace(array('Y','m','d', 'H', 'i','a'),array('%Y','%m','%d', '%I', '%M', '%p' ) ,$dformat);
        // %Y, %m and %d correspond to date()'s Y m and d.
        // %I corresponds to H, %M to i and %p to a
        $ugly = strptime($schedule, $schedule_format);
        $ymd = sprintf(
        // This is a format string that takes six total decimal
        // arguments, then left-pads them with zeros to either
        // 4 or 2 characters, as needed
            '%04d-%02d-%02d %02d:%02d:%02d',
            $ugly['tm_year'] + 1900,  // This will be "111", so we need to add 1900.
            $ugly['tm_mon'] + 1,      // This will be the month minus one, so we add one.
            $ugly['tm_mday'],
            $ugly['tm_hour'],
            $ugly['tm_min'],
            $ugly['tm_sec']
        );

        return new DateTime($ymd);
    }
}


set_exception_handler('exceptionHandler');
function exceptionHandler(Exception $exception)
{
    $msg = "PHP Fatal error: '<strong>%s</strong>' \n in %s:%s\nStack trace:\n";
    $msg = sprintf(
        $msg,
        $exception->getMessage(),
        $exception->getFile(),
        $exception->getLine()
    );

    $rootDir = realpath(DIR_SYSTEM . '/../') . '/';
    echo nl2br($msg . str_replace($rootDir, '', $exception->getTraceAsString()));
}
