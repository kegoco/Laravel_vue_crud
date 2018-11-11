<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Company extends Model
{
    protected $table = "COMPANIES";
    protected $primaryKey = "company_id";
    public $timestamps = false;
}
