<?php

header('Content-type: text/css; charset=utf-8');

function sanitize($string)
{
    return preg_replace('/[^-a-zA-Z0-9_ ]/', '', strip_tags((string) $string));
}

$body        = isset($_GET['body'])        ? sanitize($_GET['body'])     : 'default';
$nav         = isset($_GET['nav'])         ? sanitize($_GET['nav'])      : 'default';
$nav_size    = isset($_GET['nav_size'])    ? (int) $_GET['nav_size']     : '16';
$intro       = isset($_GET['intro'])       ? sanitize($_GET['intro'])    : 'default';
$intro_size  = isset($_GET['intro_size'])  ? (int) $_GET['intro_size']   : '32';
$title       = isset($_GET['title'])       ? sanitize($_GET['title'])    : 'default';
$price       = isset($_GET['price'])       ? sanitize($_GET['price'])    : 'default';
$button      = isset($_GET['button'])      ? sanitize($_GET['button'])   : 'default';
$button_size = isset($_GET['button_size']) ? (int) $_GET['button_size']  : '16';
$changing    = isset($_GET['changing'])    ? sanitize($_GET['changing']) : '';

?>

<?php if ($changing == 'body'): ?>
body,
.s_item h3
{
  <?php if ($body == 'default'): ?>
  font-family: "Lucida Sans Unicode", "Lucida Grande", Arial, sans-serif;
  <?php else: ?>
  font-family: <?php echo $body; ?>;
  <?php endif; ?>
}
<?php endif; ?>

<?php if ($changing == 'title'): ?>
h1,
h2,
#product_info h3,
#product_buy_col h3,
.box .box-heading,
.s_order .s_id,
.s_order .s_status,
.s_product_row .s_row_number
{
  <?php if ($title == 'default'): ?>
  font-family: Arial, sans-serif;
  <?php else: ?>
  font-family: <?php echo $title; ?>;
  <?php endif; ?>
}
<?php endif; ?>

<?php if ($changing == 'navigation'): ?>
#categories > ul > li > a,
#cart_menu small.s_text,
#product .s_tabs_nav li a
{
  <?php if ($nav == 'default'): ?>
  font-family: Arial, sans-serif;
  <?php else: ?>
  font-family: <?php echo $nav; ?>;
  <?php endif; ?>
}
#categories > ul > li > a,
#cart_menu small.s_text
{
  font-size: <?php echo $nav_size; ?>px;
}
<?php endif; ?>

<?php if ($changing == 'intro'): ?>
#intro h1,
#intro h2
{
  <?php if ($intro == 'default'): ?>
  font-family: Arial, sans-serif;
  <?php else: ?>
  font-family: <?php echo $intro; ?>;
  <?php endif; ?>
  font-size: <?php echo $intro_size; ?>px;
}
<?php endif; ?>

<?php if ($changing == 'price'): ?>
.s_plain .s_price,
.s_old_price
{
  <?php if ($price == 'default'): ?>
  font-family: "Lucida Sans Unicode", "Lucida Grande", Arial, sans-serif;
  <?php else: ?>
  font-family: <?php echo $price; ?>;
  <?php endif; ?>
}
.s_label .s_price,
.s_order .s_total,
#cart_menu .s_grand_total,
#order_details .s_table tr.last td,
#shopping_cart .s_total.last,
#shopping_cart_confirm .s_total.last
{
  <?php if ($price == 'default'): ?>
  font-family: "Babel Sans", sans-serif;
  <?php else: ?>
  font-family: <?php echo $price; ?>;
  <?php endif; ?>
}
<?php endif; ?>

<?php if ($changing == 'button'): ?>
.s_button_1 .s_text,
.buttons .button span,
#add_to_cart .s_text
{
  <?php if ($button == 'default'): ?>
  font-family: Arial, sans-serif;
  <?php else: ?>
  font-family: <?php echo $button; ?>;
  <?php endif; ?>
  font-size: <?php echo $button_size; ?>px;
}
<?php endif; ?>