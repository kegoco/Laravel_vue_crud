<template>
    <!-- <div class="container-fluid">
        <div class="modal right fade" id="read_product" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2>{{ product.product_name }}</h2>
                        <button type="button" class="close" data-dismiss="modal">
                            <span>×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <table class="table">
                            <tbody>
                                <tr>
                                    <td>Description</td>
                                    <td>{{ product.product_description }}</td>
                                </tr>
                                <tr>
                                    <td>Price</td>
                                    <td>{{ product.product_price }}</td>
                                </tr>
                                <tr>
                                    <td>Company</td>
                                    <td>{{ product.company_name }}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <input type="submit" class="btn btn-primary close" data-dismiss="modal" value="Close">
                    </div>
                </div>
            </div>
        </div>
    </div> -->
    <div>
        <script type="text/x-template" id="modal-template">
            <transition name="modal">
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
                            <button class="modal-default-button btn btn-success" @click="$emit('close')">
                                Close
                            </button>
                        </slot>
                    </div>
                    </div>
                </div>
                </div>
            </transition>
        </script>

        <modal v-if="read_product_modal" @close="read_product_modal = false">
            <!--
            you can use custom content here to overwrite
            default content
            -->
            <h3 slot="header">Read a product</h3>
        </modal>
    </div>
    
</template>

<script>
import {EventBus} from "../event-bus.js";

Vue.component('modal', {
    template: '#modal-template'
  });
//   https://vuejs.org/v2/examples/modal.html
//   https://vuejsexamples.com/tag/modal/

export default {
  created: function () {  // INIT
    EventBus.$on('select_product', (product) => {
        console.log("HOLA ====================");
        console.log(product);
        this.read_product_modal = true;
        this.product = product;
    });
  },
  data() {  // VARS
    return {
        product: {},
        read_product_modal: false
    }
  },
  methods: {  // METHODS
    
  }
};
</script>
