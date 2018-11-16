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
        $offset = $request["offset"];
        $limit = $request["limit"];
        $filter = $request["filter"];

        return Product::leftjoin("COMPANIES as cmp","cmp.company_id", "=", "PRODUCTS.company_id")
            ->where("product_name", "LIKE", "%$filter%")
            ->orderBy("product_name", "asc")
            //->take(5)
            ->offset($offset)->limit($limit)
            ->get([
                "product_id",
                "product_name",
                "product_description",
                "product_price",
                "cmp.company_name"
            ]);
    }

    public function countAllProducts(Request $request) {
        $filter = $request["filter"];
        return Product::where("product_name", "LIKE", "%$filter%")
            ->get()->count();
    }

    public function getAllProducts(Request $request) {
        $filter = $request["filter"];

        return Product::leftjoin("COMPANIES as cmp","cmp.company_id", "=", "PRODUCTS.company_id")
            ->where("product_name", "LIKE", "%$filter%")
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
