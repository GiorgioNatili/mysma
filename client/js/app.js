require.config({

    paths: {
        zepto: 'libs/zepto/zepto',
        text: 'libs/require/plugins/text',
        domReady: 'libs/require/plugins/domReady',
        async: 'libs/require/plugins/async'

    },

    shim: {
        'zepto': {
            exports: '$'
        }
    },

    waitSeconds: 10

});

require([
    // Load our app module and pass it to our definition function
    'main'
], function(app){

    var config = {

        categories: 'http://mysma.gnstudio.biz/index.php?route=feed/web_api/categories',
        category: 'http://mysma.gnstudio.biz/index.php?route=feed/web_api/category',
        products: 'http://mysma.gnstudio.biz/index.php?route=feed/web_api/products',
        product: 'http://mysma.gnstudio.biz/index.php?route=feed/web_api/product'

    };

    // The "app" dependency is passed in as "App"
    app.init(config);

});
