<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;
use App\Models\Company;

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

    /* : Products applying filters */
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
                "cmp.company_id",
                "cmp.company_name"
            ]);
    }

    /* : The count of all products */
    public function countAllProducts(Request $request) {
        $filter = $request["filter"];
        return Product::where("product_name", "LIKE", "%$filter%")
            ->get()->count();
    }

    /* : All products that will be downloaded */
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

    /* : All companies */
    public function getAllCompanies() {
        return Company::get([
            "company_id",
            "company_name"
        ]);
    }

    /* MODIFY: A product */
    public function updateProduct(Request $request) {
        $product_id = $this->checkIsset($request, "product_id");
        $product_name = $this->checkIsset($request, "product_name");
        $product_description = $this->checkIsset($request, "product_description");
        $product_price = $this->checkIsset($request, "product_price");
        $company_id = $this->checkIsset($request, "company_id");

        if ($this->hasNulls([$product_id, $product_name, $product_description, $product_price, $company_id])) {
            return [
                "error" => "The product is not valid!"
            ];
        }
        else {
            return Product::where("product_id", "=", $product_id)
                ->update([
                    "product_name" => $product_name,
                    "product_description" => $product_description,
                    "product_price" => $product_price,
                    "company_id" => $company_id
                ]);
        }
    }

    /* CHECK: Return the value of request if it has value */
    private function checkIsset($request, $id) {
        return (isset($request[$id])) ? $request[$id] : null;  // TODO: Pass this function to a new controller
    }

    /* CHECK: If request has value */
    private function hasNulls($request) {
        return in_array(null, $request) || in_array("", $request);  // TODO: Pass this function to a new controller
    }
}
