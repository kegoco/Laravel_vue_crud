
/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

require('./bootstrap');

window.Vue = require('vue');
window.VueResource = require('vue-resource');

/**
 * The following block of code may be used to automatically register your
 * Vue components. It will recursively scan this directory for the Vue
 * components and automatically register them with their "basename".
 *
 * Eg. ./components/ExampleComponent.vue -> <example-component></example-component>
 */

Vue.component('products-component', require('./components/ProductsCompotent.vue'));

Vue.component('products-modals', require('./components/ProductsModals.vue'));
Vue.component('product-reader', require('./components/products_modals/ProductReader_Modal.vue'));
Vue.component('product-updater', require('./components/products_modals/ProductUpdater_Modal.vue'));
Vue.component('product-creator', require('./components/products_modals/ProductCreator_Modal.vue'));
Vue.component('product-deleter', require('./components/products_modals/ProductDeleter_Modal.vue'));

Vue.component('loading-screen-button', require('./components/LoadingScreenButton.vue'));

// const files = require.context('./', true, /\.vue$/i)

// files.keys().map(key => {
//     return Vue.component(_.last(key.split('/')).split('.')[0], files(key))
// })

/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */

export const app = new Vue({
    el: '#app',
    data: {
        isLoading: false,
        token: document.head.querySelector('meta[name="csrf-token"]').content
    },
    methods: {
        /* GET: Current path */
        getCurrentPath: function () {
            return window.location.pathname;
        }
    },
});