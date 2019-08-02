<?php namespace App\Webapp\Reports;

use App\Report;

class ReportWebApp extends Report
{
    protected $table = 'reports';

    protected $dates = ['deleted_at'];
    protected $hidden = ['created_at', 'updated_at', 'deleted_at', 'jdoc'];

    public function __construct()
    {
        parent::__construct();
    }
}
