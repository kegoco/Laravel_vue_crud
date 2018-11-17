<template>
    <transition name="modal" v-if="read_product_modal" @close="read_product_modal = false">
        <div class="modal-mask">
            <div class="modal-wrapper">
                <div class="modal-container">

                <div class="modal-header">
                    <slot name="header">
                        default header
                    </slot>
                </div>

                <div class="modal-body">
                    <slot name="body">
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
                    </slot>
                </div>

                <div class="modal-footer">
                    <slot name="footer">
                        <button class="modal-default-button btn btn-success" @click="read_product_modal = false">
                            Close
                        </button>
                    </slot>
                </div>
                </div>
            </div>
        </div>
    </transition>
</template>

<script>
import { EventBus } from "../event-bus.js";

//   https://vuejs.org/v2/examples/modal.html
//   https://vuejsexamples.com/tag/modal/

export default {
  created: function() {  // INIT
    EventBus.$on("select_product", product => {
      this.read_product_modal = true;
      this.product = product;
    });
  },
  data() {  // VARS
    return {
      product: {},
      read_product_modal: false
    };
  },
  methods: {  // METHODS
  }
};
</script>
