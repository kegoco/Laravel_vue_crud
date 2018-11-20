<template>
    <transition name="modal" v-if="opened_modal" v-on:close="opened_modal = false">
        <div class="modal-mask">
            <div class="modal-wrapper">
                <form class="modal-container">

                    <!-- HEADER -->
                    <div class="modal-header">
                        <h3>Delete a product</h3>
                    </div>

                    <!-- BODY -->
                    <div class="modal-body">
                        <div v-if="product != undefined">
                            <span>Do you want to delete "{{ product.product_name }}"?</span>
                        </div>

                        <!-- OPERATION MESSAGE -->
                        <div v-if="message_object != undefined">
                            <span v-bind:class="message_object.color"><b>{{ message_object.type }}:</b> {{ message_object.message }}</span>
                        </div>
                    </div>

                    <!-- FOOTER -->
                    <div class="modal-footer">
                        <button v-on:click.prevent="deleteProduct" v-if="product != undefined" type="submit" class="modal-default-button btn btn-success">
                            Delete
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
    EventBus.$on("productModal_deleter", (product) => {
        this.message_object = undefined;
        this.opened_modal = true;
        this.product = {
            product_id: product.product_id,
            product_name: product.product_name
        };
    });
  },
  data() {  // VARS
    return {
        product: {
            product_id: 0,
            product_name: ""
        },

        message_object: undefined,

        opened_modal: false
    };
  },
  methods: {  // METHODS
    deleteProduct: function () {
        var data = {
            product_id: this.product.product_id
        };
        var headers = {
            "X-CSRF-TOKEN": this.$root.token
        };

        this.$http.post(this.$root.getCurrentPath() + "/deleteProduct", data, {headers: headers}).then(
            function(response) {  // Success
                if (response.data.error == undefined) {
                    // Update the product view
                    EventBus.$emit("refreshProductTable");
                    this.product = undefined;

                    // Show success message
                    this.message_object = {
                        type: "Success",
                        message: "The product was deleted successfully!",
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
    }
  }
};
</script>