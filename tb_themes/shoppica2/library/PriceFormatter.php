<?php

class TB_PriceFormatter
{
    /**
     * @var Currency
     */
    protected $currency;

    public function __construct(Currency $currency)
    {
        $this->currency = $currency;
    }

    public function format($price)
    {
        $symbol_left = trim($this->currency->getSymbolLeft());
        $symbol_right = trim($this->currency->getSymbolRight());

        if(function_exists('mb_substr') && function_exists('mb_strrpos')) {
            if (!empty($symbol_left)) {
                $price = mb_substr($price, 0, mb_strpos($price, $symbol_left, null, 'UTF-8'), 'UTF-8') . '<span class="s_currency s_before">' . $symbol_left . '</span>' . mb_substr($price, mb_strpos($price, $symbol_left, null, 'UTF-8') + mb_strlen($symbol_left, 'UTF-8'), mb_strlen($price, 'UTF-8'), 'UTF-8');
            }

            if (!empty($symbol_right)) {
                $price = mb_substr($price, 0, mb_strrpos($price, $symbol_right, null, 'UTF-8'), 'UTF-8') . '<span class="s_currency s_after">' . $symbol_right . '</span>' . mb_substr($price, mb_strrpos($price, $symbol_right, null, 'UTF-8') + mb_strlen($symbol_right, 'UTF-8'), mb_strlen($price, 'UTF-8'), 'UTF-8');
            }
        } else
        if (function_exists('utf8_substr')) {
            if (!empty($symbol_left)) {
                $price = utf8_substr($price, 0, utf8_strpos($price, $symbol_left)) . '<span class="s_currency s_before">' . $symbol_left . '</span>' . utf8_substr($price, utf8_strpos($price, $symbol_left) + utf8_strlen($symbol_left), utf8_strlen($price));
            }

            if (!empty($symbol_right)) {
                $price = utf8_substr($price, 0, utf8_strrpos($price, $symbol_right)) . '<span class="s_currency s_after">' . $symbol_right . '</span>' . utf8_substr($price, utf8_strrpos($price, $symbol_right) + utf8_strlen($symbol_right), utf8_strlen($price));
            }
        } else {
            if (!empty($symbol_left)) {
                $price = substr_replace($price, '<span class="s_currency s_before">' . $symbol_left . '</span>', strpos($price, $symbol_left), strlen($symbol_left));
            }

            if (!empty($symbol_right)) {
                $price = substr_replace($price, '<span class="s_currency s_after">' . $symbol_right . '</span>', strrpos($price, $symbol_right), strlen($symbol_right));
            }
        }

        return $price;
    }
}