<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    //protected $table = "PRODUCTS";
                // This model is called "Product" then Eloquent will make the queries to the "products" table, because
                // it will take the model name and will put a "s" on the final of the word.
                // We should put the "$table" variable with our table name if it wouldn't be called like the model (in singular).
    protected $primaryKey = "product_id";
    public $timestamps = false;
}
