<template>
    <div>
        <div class="input-group col-md-5">
          <input type="text" class="form-control" placeholder="Search..." v-model="filter">
          <div class="input-group-append">
            <button class="btn btn-primary" type="button" v-on:click="searchProducts">
              <!-- <span class="glyphicon glyphicon-search"></span> -->
              <i class="fas fa-search"></i>
            </button>
          </div>
        </div>

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

        <button class="btn btn-success" v-on:click="downloadProducts">
          <span v-if="!this.$root.isLoading">Download products</span>
          <span v-if="this.$root.isLoading">Downloading products</span>
          <loading-screen-button class="d-inline" v-if="this.$root.isLoading"></loading-screen-button>
        </button>
        
        <product-modals></product-modals>
    </div>
</template>

<script>
import {EventBus} from "../event-bus.js";

export default {
  created: function () {  // INIT
    this.countAllProducts();
    console.log("Product Component started");
  },
  data() {  // VARS
    return {
      // Products vars
      products: [],

      // Pagination vars
      pages: [],
      product_by_page: 5,
      range_page: 3,
      current_page: 1,
      total_pages: 0,
      filter: ""
    }
  },
  methods: {  // METHODS

    /* GET: The total of products */
    countAllProducts: function () {
      var data = {
        filter: this.filter
      };
      var headers = {
        "X-CSRF-TOKEN": this.$root.token
      }

      this.$http.post(this.$root.getCurrentPath() + "/countAllProducts", data, {headers: headers}).then(  // "this.$root.getCurrentPath()" calls to "app" Vue.
        function(response) {  // Success
          var count_products = response.data;
          this.total_pages = Math.ceil(count_products / this.product_by_page);
          this.loadProducts();  // Load the products by first time
        },
        function(response) {  // Error
          console.error(response);
        }
      );
    },

    /* GET: A specify range of products */
    loadProducts: function (page) {
      if (page != undefined) this.current_page = page;

      var data = {
        offset: (this.product_by_page * page) - this.product_by_page,
        limit: this.product_by_page,
        filter: this.filter
      };
      var headers = {
        "X-CSRF-TOKEN": this.$root.token
      }

      this.$http.post(this.$root.getCurrentPath() + "/getProducts", data, {headers: headers}).then(
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
    refreshPaging: function () {
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
    isCurrentPage: function (page) {
      return (page == this.current_page);
    },

    /* SET: Product to read to the modal */
    selectProduct: function (product) {
      EventBus.$emit('select_product', product);
    },

    /* DOWNLOAD: All products in a .csv file */
    downloadProducts: function () {
      this.$root.isLoading = true;

      var data = {
        filter: this.filter
      };
      var headers = {
        "X-CSRF-TOKEN": this.$root.token
      }

      this.$http.post(this.$root.getCurrentPath() + "/getAllProducts", data, {headers: headers}).then(
        function(response) {  // Success
          this.generateCsvFile(response.data);
        },
        function(response) {  // Error
          console.error(response);
        }
      );
    },

    /* GENERATE: Csv file */
    generateCsvFile: function (data) {
      // Generate csv content data:
      var csvData = "data:text/csv;charset=utf-8,";
      csvData += "Product name,Product description,Product price,Company name\n";
      data.forEach(element => {
        csvData += element.product_name + "," + element.product_description 
            + "," + element.product_price + "," + element.company_name + "\n";
      });

      // Generate the link to download the csv file:
      var encodedURI = encodeURI(csvData);
      var downloadLink = document.createElement("a");
      var date = new Date();
      var fileName = "products_" + date.toLocaleDateString() + "_" + date.toLocaleTimeString() + ".csv";
      downloadLink.setAttribute("href", encodedURI);
      downloadLink.setAttribute("download", fileName);  // Set the name of file
      document.body.appendChild(downloadLink);
      downloadLink.click();  // It will download the generated file
      downloadLink.remove();  // Remove the link from the body

      this.$root.isLoading = false;
    },

    /* GET: All products finding by the filter */
    searchProducts: function () {
      this.current_page = 1;
      this.countAllProducts();
    }
  }
};
</script>
