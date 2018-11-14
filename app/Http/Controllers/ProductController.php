<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;

class ProductController extends Controller
{
    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view("products")->with("title_page", "Products");
    }

    public function getProducts(Request $request) {
        return Product::leftjoin("COMPANIES as cmp","cmp.company_id", "=", "PRODUCTS.company_id")
            ->orderBy("product_name", "asc")
            //->take(5)
            ->offset($request["offset"])->limit($request["limit"])
            ->get([
                "product_id",
                "product_name",
                "product_description",
                "product_price",
                "cmp.company_name"
            ]);
    }

    public function countAllProducts() {
        return Product::get()->count();
    }

    public function getAllProducts() {
        return Product::leftjoin("COMPANIES as cmp","cmp.company_id", "=", "PRODUCTS.company_id")
            ->orderBy("product_name", "asc")
            ->get([
                "product_id",
                "product_name",
                "product_description",
                "product_price",
                "cmp.company_name"
            ]);
    }
}
