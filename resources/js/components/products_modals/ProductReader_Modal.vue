<template>
    <transition name="modal" v-if="opened_modal" @close="opened_modal = false">
        <div class="modal-mask">
            <div class="modal-wrapper">
                <div class="modal-container">

                    <!-- HEADER -->
                    <div class="modal-header">
                        <h3>Read a product</h3>
                    </div>

                    <!-- BODY -->
                    <div class="modal-body">
                        <table class="table">
                            <tbody>
                                <tr>
                                    <td class="font-weight-bold">Name</td>
                                    <td>{{ product.product_name }}</td>
                                </tr>
                                <tr>
                                    <td class="font-weight-bold">Description</td>
                                        <td>{{ product.product_description }}</td>
                                </tr>
                                <tr>
                                    <td class="font-weight-bold">Price</td>
                                    <td>{{ product.product_price }}</td>
                                </tr>
                                <tr>
                                    <td class="font-weight-bold">Company</td>
                                    <td>{{ product.company_name }}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <!-- FOOTER -->
                    <div class="modal-footer">
                        <button v-on:click="opened_modal = false" class="modal-default-button btn btn-success">
                            Close
                        </button>
                    </div>
                </div>
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
    EventBus.$on("productModal_reader", product => {
      this.opened_modal = true;
      this.product = product;
    });
  },
  data() {  // VARS
    return {
      product: {},
      opened_modal: false
    };
  },
  methods: {  // METHODS
  }
};
</script>