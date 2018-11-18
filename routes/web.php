<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get("/", function () {
    return redirect("/products");
});

Route::get("/products", "ProductController@index")->name("products");
Route::post("/products/getProducts", "ProductController@getProducts");
Route::post("/products/countAllProducts", "ProductController@countAllProducts");
Route::post("/products/getAllProducts", "ProductController@getAllProducts");
Route::get("/products/getAllCompanies", "ProductController@getAllCompanies");
Route::post("/products/updateProduct", "ProductController@updateProduct");
