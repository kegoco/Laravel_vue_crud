<template>
    <transition name="modal" v-if="opened_modal" @close="opened_modal = false">
        <div class="modal-mask">
            <div class="modal-wrapper">
                <form class="modal-container">

                    <!-- HEADER -->
                    <div class="modal-header">
                        <h3>Update a product</h3>
                    </div>

                    <!-- BODY -->
                    <div class="modal-body">
                        <table class="table">
                            <tbody>
                                <tr>
                                    <td class="font-weight-bold">Name</td>
                                    <td>
                                        <input v-model="product.product_name" type="text" class="form-control" placeholder="Enter a product name..." required>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font-weight-bold">Description</td>
                                    <td>
                                        <textarea v-model="product.product_description" class="form-control no-resize" rows="5" placeholder="Enter a product description..." required></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font-weight-bold">Price</td>
                                    <td>
                                        <input v-model="product.product_price" type="number" class="form-control" step="0.01" placeholder="Enter a product price..." required>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font-weight-bold">Company</td>
                                    <td>
                                        <select v-model="product.company_id" v-on:change="selectCompany(product.company_id)" class="form-control">
                                            <option v-for="company in companies" :key="company.company_id" v-bind:value="company.company_id">{{ company.company_name }}</option>
                                        </select>
                                    </td>
                                </tr>
                            </tbody>
                        </table>

                        <!-- OPERATION MESSAGE -->
                        <div v-if="message_object != undefined">
                            <span v-bind:class="message_object.color"><b>{{ message_object.type }}:</b> {{ message_object.message }}</span>
                        </div>
                    </div>

                    <!-- FOOTER -->
                    <div class="modal-footer">
                        <button v-on:click.prevent="updateProduct" :disabled="!wasProductChanged()" type="submit" class="modal-default-button btn btn-success">
                            Save
                        </button>
                        <button v-on:click.prevent="opened_modal = false" class="modal-default-button btn btn-danger">
                            Close
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </transition>
</template>

<script>
import { EventBus } from "../../event-bus.js";

//   https://vuejs.org/v2/examples/modal.html
//   https://vuejsexamples.com/tag/modal/

export default {
  created: function() {  // INIT
    EventBus.$on("productModal_updater", product => {
        this.message_object = undefined;
        this.opened_modal = true;
        this.getAllCompanies();
        this.original_product = product;
        this.product = {
            product_id: product.product_id,
            product_name: product.product_name,
            product_description: product.product_description,
            product_price: product.product_price,
            company_id: product.company_id,
            company_name: product.company_name
        };
    });
  },
  data() {  // VARS
    return {
        original_product: {},
        product: {},
        companies: [],

        message_object: undefined,

        opened_modal: false
    };
  },
  methods: {  // METHODS
    /* GET: All companies */
    getAllCompanies: function () {
        this.$http.get(this.$root.getCurrentPath() + "/getAllCompanies").then(
            function(response) {  // Success
                this.companies = response.data;
            },
            function(response) {  // Error
                console.error(response);
            }
        );
    },

    /* SET: The company name to the product */
    selectCompany: function (company_id) {
        this.companies.forEach((company) => {
            if (company.company_id == company_id) {
                this.product.company_name = company.company_name;
            }
            
        });
    },

    /* UPDATE: The current product */
    updateProduct: function () {
        var headers = {
            "X-CSRF-TOKEN": this.$root.token
        };

        this.$http.post(this.$root.getCurrentPath() + "/updateProduct", this.product, {headers: headers}).then(
            function(response) {  // Success
                if (response.data.error == undefined) {
                    // Update the product on the product view
                    EventBus.$emit("productUpdated", this.product);

                    // Show success message
                    this.message_object = {
                        type: "Success",
                        message: "The product was updated successfully!",
                        color: "text-success"
                    };
                }
                else {
                    // Show error message
                    this.message_object = {
                        type: "Warning",
                        message: response.data.error,
                        color: "text-danger"
                    };
                }
            },
            function(response) {  // Error
                console.error(response);
            }
        );
    },

    /* CHECK: If product was modified */
    wasProductChanged: function () {
        if (this.original_product.product_name != this.product.product_name
            || this.original_product.product_description != this.product.product_description
            || this.original_product.product_price != this.product.product_price
            || this.original_product.company_id != this.product.company_id) {

            return true;
        }
        else {
            return false;
        }
    }
  }
};
</script>