MySMA WEB API
================

This is a small module that adds the ability to remotely work with the OpenCart 1.5.3+ via the REST API.

 * Homepage: http://zenwalker.ru/lab/opencart-webapi/
 * Sources: https://github.com/ethernet1/opencart-webapi
 * Ddocumentation in Russian: http://zenwalker.ru/lab/opencart-webapi/documentation.html

Features:

 * [Get Categories](#get-categories)
 * [Get Category](#get-category-info)
 * [Get Products](#get-products)
 * [Get Product](#get-product)


Examples
--------

### Get categories

Request:

  http://example.com/?route=feed/web_api/categories&parent=0&level=2


Params:

 * $_GET['parent']: parent category id
 * $_GET['level']:  depth level

### Get category

Request:

  http://example.com/?route=feed/web_api/category&id=1


Params:

 * $_GET['id']: category id


### Get products

Request:

  http://example.com/?route=feed/web_api/products&category=1


Params:

 * $_GET['category']: parent category id
 * $_GET['sort']: name, model, quantity, price, sort_order
 * $_GET['order']: ASC, DESC
 * $_GET['limit']: Total # of results.
 * $_GET['start']: Offset Start from. (Default 0)


### Get product

Request:

  http://example.com/?route=feed/web_api/product&id=1

Params:

 * $_GET['id']: product id
