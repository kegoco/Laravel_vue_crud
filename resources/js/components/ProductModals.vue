<template>
    <div class="container-fluid">
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
                        
                    </div>
                    <div class="modal-footer">
                        <input type="submit" class="btn btn-primary" value="Guardar">
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import {EventBus} from "../event-bus.js";

export default {
  created: function () {  // INIT
    EventBus.$on('select_product', (product) => {
        this.product = product;
    });
  },
  data() {  // VARS
    return {
        product: {}
    }
  },
  methods: {  // METHODS
    
  }
};
</script>
