;define('main', [
        'zepto'], (function(){

    var $categoriesLevel, $categoriesNesting, $categoriesData;
    var $categoryId, $categoryData;
    var $productsCategoryId, $productsCategoryData;
    var $categoriesResult, $subcategoriesResult, $productsResult;
    var roots;

    var init = function(config){

        roots = config;

        // Input
        $categoriesLevel = $('#categories-level');
        $categoriesNesting = $('#categories-nesting');
        // Control
        $categoriesData = $('#categories-data');

        // Input
        $categoryId = $('#category-id');
        // Control
        $categoryData = $('#category-data');


        // Input
        $productsCategoryId = $('#products-category-id');
        // Control
        $productsCategoryData = $('#products-category-data');

        $categoriesResult = $('#categories-result ul');
        $subcategoriesResult = $('#category-result ul');
        $productsResult = $('#category-products ul');

        $categoriesData.on('click', onCategoriesData);
        $categoryData.on('click', onCategoryData);
        $productsCategoryData.on('click', onCategoryProducts);

    };

    var onCategoriesData = function(e){

        var categories = $categoriesLevel.val();
        var nesting = $categoriesNesting.val();

        getCategoriesData(categories, nesting);

    };

    function renderCategories(data, target) {

        var value = '';

        for (var i = 0, category; category = data[i]; i++) {

            value += '<li data-category-id="' + category.category_id + '" >' + category.name + ' (' + category.total_products + ',' + category.category_id + ')</li>';

        }

        target.html(value);
    }

    var getCategoriesData = function(categories, nesting) {

        $.ajax({
            type: 'GET',
            url: roots.categories,
            // data to be added to query string:
            data: { parent: categories,  level: nesting},
            // type of data we are expecting in return:
            dataType: 'json',
            timeout: 3000,
            context: $('body'),
            success: function(data){

                console.log(data);

                if(data.success){

                    renderCategories(data.categories, $categoriesResult);

                }

            },
            error: function(xhr, type){

                alert('Ajax error!')
                console.log(xhr, type)

            }
        })

    };

    var onCategoryData = function(e){

        var categoryID = $categoryId.val();

        getCategoryData(categoryID);

    };

    //  http://example.com/?route=feed/web_api/products&category=1
//    http://example.com/?route=feed/web_api/product&id=1
 //   http://example.com/?route=feed/web_api/category&id=1

    var getCategoryData = function(id){

        $.ajax({
            type: 'GET',
            url: roots.category,
            // data to be added to query string:
            data: { id: id},
            // type of data we are expecting in return:
            dataType: 'json',
            timeout: 3000,
            context: $('body'),
            success: function(data){

                console.log(data.category);

                if(data.success){

                    renderCategories(data.category.categories, $subcategoriesResult);

                }

            },
            error: function(xhr, type){

                alert('Ajax error!')
                console.log(xhr, type)
            }
        });

    };

    var onCategoryProducts = function(e){

        var categoryID = $productsCategoryId.val();

        getCategoryProducts(categoryID);

    };

    var getCategoryProducts = function(id){

        $.ajax({
            type: 'GET',
            url: roots.products,
            // data to be added to query string:
            data: { category: id},
            // type of data we are expecting in return:
            dataType: 'json',
            timeout: 3000,
            context: $('body'),
            success: function(data){

                if(data.success){

                    renderCategories(data.products, $productsResult);

                }

            },
            error: function(xhr, type){
                alert('Ajax error!')
                console.log(xhr, type)
            }
        })


    };

    // Public API

    return{

        init: init

    };

}));