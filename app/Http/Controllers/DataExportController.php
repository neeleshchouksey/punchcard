<?php namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Webapp\DataExport\DataExportBulk;
use Excel;
use Auth;
use PDF;

class DataExportController extends ApiController
{
    public function excel(Request $request)
    {
        //dd($request->all()); 
	//echo '<pre>';       
	$data = $request->all();	
	//print_r($data['rows'][0][4]);die;

	
        $document = $this->createDocument($data);
        $document->download('xlsx');
    }

    public function csv(Request $request)
    {
        $data = $request->all();
        $document = $this->createDocument($data);
        $document->download('csv');
    }

    public function pdf(Request $request)
    {
        $pdf = PDF::loadView('reports.pdf', $request->all());
        $data = $request->all();
        $pdf->setPaper('a4', 'landscape');
        return $pdf->download($data['report_number'].' '.$data['name'].'.pdf');
    }

    public function bulk(Request $request)
    {
        $data = $request->all();
        return (new DataExportBulk($data))->handleFor(Auth::User());
    }

    protected function createDocument($data)
    {
        return Excel::create($data['name'], function ($excel) use ($data) {
	
            $excel->setTitle($data['name'])
                  ->setCreator(Auth::user()->name)
                  ->setCompany(Auth::user()->client->name)
                  ->setDescription('A Punchcard Report');

            $excel->sheet('Report Data', function ($sheet) use ($data) {
		
		if ($data['report_number'] == 'RPT-500') {
                    $sheet->loadView('reports.500xlsx', $data);
                } else {
                    $sheet->loadView('reports.excel', $data);
                }
            });	

        });
    }
}
