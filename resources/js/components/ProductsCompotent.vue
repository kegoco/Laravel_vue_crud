<template>
    <div>
        <table class="table">
          <thead>
            <tr>
              <th>Name</th>
              <th>Description</th>
              <th>Price</th>
              <th>Company</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="product of products" :key="product.product_id">
              <td>{{product.product_name}}</td>
              <td>{{product.product_description}}</td>
              <td>{{product.product_price}}</td>
              <td>{{product.company_name}}</td>
              <td>
                <a v-on:click="selectProduct(product)" class="btn btn-info text-light" data-toggle="modal" data-target="#read_product">Read</a>
                <a class="btn btn-primary text-light">Update</a>
                <a class="btn btn-danger text-light">Delete</a>
              </td>
            </tr>
          </tbody>
        </table>

        <ul class="pagination">
          <li v-if="current_page > 1" class="page-item">
            <a v-on:click="loadProducts(1)" class="page-link">First</a>
          </li>
          <li v-for="page of pages" :key="page" class="page-item">
            <a v-on:click="loadProducts(page)" v-bind:class="{ 'text-primary': isCurrentPage(page) }" class="page-link">{{ page }}</a>
          </li>
          <li v-if="current_page < total_pages" class="page-item">
            <a v-on:click="loadProducts(total_pages)" class="page-link">Last</a>
          </li>
        </ul>

        <product-modals></product-modals>
    </div>
</template>

<script>
import {EventBus} from "../event-bus.js";

export default {
  created: function () {  // INIT
    this.path = window.location.pathname;
    this.countAllProducts();
    console.log("Product Component started");
  },
  data() {  // VARS
    return {
      // Current path
      path: "",

      // Products vars
      products: [],

      // Pagination vars
      pages: [],
      product_by_page: 5,
      range_page: 3,
      current_page: 1,
      total_pages: 0
    }
  },
  methods: {  // METHODS

    /* GET: The total of products */
    countAllProducts() {
      this.$http.get(this.path + "/countAllProducts").then(
        function(response) {  // Success
          var count_products = response.data;
          this.total_pages = Math.ceil(count_products / this.product_by_page);
          this.loadProducts(this.current_page);  // Load the products by first time
        },
        function(response) {  // Error
          console.error(response);
        }
      );
    },

    /* GET: A specify range of products */
    loadProducts(page) {
      this.current_page = page;

      var data = {
        offset: (this.product_by_page * page) - this.product_by_page,
        limit: this.product_by_page
      };
      var headers = {
        "X-CSRF-TOKEN": document.head.querySelector('meta[name="csrf-token"]').content
      }

      this.$http.post(this.path + "/getProducts", data, {headers: headers}).then(
        function(response) {  // Success
          this.products = response.data;
          console.log(this.products);
          this.refreshPaging();
        },
        function(response) {  // Error
          console.error(response);
        }
      );
    },

    /* UPDATE: The current page */
    refreshPaging() {
      this.pages = [];

      var initial_num = this.current_page - this.range_page;
      var condition_limit_num = (this.current_page + this.range_page);

      for (var i = initial_num; i < condition_limit_num; i++) {
        if (i > 0 && i <= this.total_pages) {
          this.pages.push(i);
        }
      }
    },

    /* CHECK: If is the current page */
    isCurrentPage(page) {
      return (page == this.current_page);
    },

    /* SET: Product to read to the modal */
    selectProduct(product) {
      EventBus.$emit('select_product', product);
    }
  }
};
</script>
