<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\CheckStatsData;
use App\CheckStats;
use DB;
use PDF;
class PlansController extends ApiController
{
     public $timestamps = true;
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('plans.showPlans');
    }

    public function weatherApi(){

        // DB::table('users')->update(['jdoc'=>'{"trade": "", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "", "department": "", "homeNumber": "", "middleName": "", "scheduling": {"payPeriod": "", "paySchedule": "", "dailyEndTime": "", "workWeekStart": "", "dailyStartTime": "", "lunchTimeAmount": ""}, "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "demographics": {"sex": "", "ethnicity": "", "drugTestDate": "", "drugTestResult": "", "backgroundCheckDate": "", "backgroundCheckResult": ""}, "payroll_data": {"estimatedHoursMonth":"", "rate": "", "state": "", "pay_rate": "", "expModifier": "", "wcGocClassCode": "", "estimatedPremium": ""}, "primaryAddress": {"zip": "34113", "city": "", "state": "Idaho", "address1": "", "address2": ""}, "secondaryAddress": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}}']);die;

        $projects = DB::table('projects')->where('deleted_at', NULL)->get();

        foreach ($projects as $project) {
            $zip = $project->zip;
            $project_id = $project->id;
            $ch = curl_init();

        curl_setopt($ch, CURLOPT_URL,"http://api.openweathermap.org/data/2.5/weather?zip=".$zip.",us&appid=48b09e21f714aee870f82036bdcffb28&units=imperial");
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS,
                    "");

        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        $server_output = curl_exec ($ch);
        $server_output = json_decode($server_output);

        if($server_output->cod == 200){
            
                $date = date('m-d-Y', $server_output->dt);
    
                DB::table('weather_store')->insertGetId(
                    ['day' => $date,'temp_max'=>$server_output->main->temp_max,'temp_min'=>$server_output->main->temp_min,'humidity'=>$server_output->main->humidity,'project_id'=>$project_id, 'description'=> $server_output->weather[0]->description, 'wind'=> $server_output->wind->speed
                ]
                );            
        }
        

        curl_close ($ch);
        }
        
        
    }

    public function downloadPDF(Request $request){

        $client_id = $request->input('client_id');
        $user_id  = $request->input('user_id');
        $validationError = array();
        if(empty($client_id)){
         $validationError['client_id'] = 'required';
        }
        if(empty($user_id)){
         $validationError['user_id'] = 'required';
        }
        if(count($validationError) > 0){
         return $this->failureResponse('Failed', $validationError,200);
         die;
        }
        $txn_history = DB::table('payment_txn')->where('state','=','approved')->where('client_id','=',$client_id)->get();

        $pdf = PDF::loadView('pdfFile', compact('txn_history'));


        return $pdf->download('txnHistory.pdf');

    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function checkTrial(){

        /* CRON FILE URL:- http://punchcard.com/crons/checkTrialExpire          */
        $date = \Carbon\Carbon::now()->subDays(31);
        $projects = DB::table('clients')->where('created_at','<=', $date)->where('child_of_id','0')->where('id', '<>', 1)->where('plan_test','trial')->get();    

        if(count($projects) > 0){
          foreach ($projects as $project) {
            $id = $project->id;
            DB::table('clients')->where('id', $id)->update(['plan_test' => 'trialExpired']);
            DB::table('clients')->where('child_of_id', $id)->update(['plan_test' => 'trialExpired']);           
          }
        }      
    }

    /**
     * Upgrade or downgrade request
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function PunchUpDown(Request $request)
    {
      // var_dump($request->input());die;
      $client_id = $request->input('client_id');
      $user_id   = $request->input('user_id');
      $version   = $request->input('version');
      $validationError = array();
        if(empty($client_id)){
         $validationError['client_id'] = 'required';
        }
        if(empty($user_id)){
         $validationError['user_id'] = 'required';
        }
        if(empty($version)){
         $validationError['version'] = 'required';
        }

        if(count($validationError) > 0){
         return $this->failureResponse('Failed', $validationError,200);
         die;
        }

      $todayTime = \Carbon\Carbon::now();  
      $paymentDone = $this->takePaymentBeforeCycle($client_id,$user_id,'Upgrade');
      $todayDate = \Carbon\Carbon::now();  
      $nextMonth = \Carbon\Carbon::now()->addMonth(); 


      if($paymentDone['success']){
        /*Updating version in a  cc_users table */
        DB::table('cc_users')->where('IsDeleted','=',FALSE)->where('client_id',$client_id)->update(['version'=>$version,'upgradedBy'=>$user_id,'updatedDate'=>$todayTime,'last_billing_date'=>$todayDate,'next_billing_date'=>$nextMonth]);
        $this->updatePlanAndPermission($client_id,$version);

        $clientadminDatas = DB::table('users')->where('client_id','=',$client_id)->where('role','=','clientadmin')->get();
        

        foreach ($clientadminDatas as $clientadminData) {

                 $CaEmail = $clientadminData->email;
                 if(!empty($paymentDone['response'])){
                  $ccNumber = $paymentDone['response']['payer']['funding_instruments'][0]['credit_card_token']['last4'];
                 }else{
                  $ccNumber = 'NA';
                 }

        \Mail::send('email_tem.successfulSubscriptionChange', ['clientAdminFirstName'=>$clientadminData->first_name, 'version'=>$version, 'ccNumber' => $ccNumber, 'next_billing_date'=>$nextMonth], function($message)use ($CaEmail) {

                    $message->to($CaEmail);
                    $message->bcc('admin@punchcardllc.com');
                    $message->subject('Punchcard Account Administration - Subscription Change');
                 });

          }
         return $this->jsonSuccess('Success', []);die;
        }else{ 

         return $this->failureResponse('Failed', 'Oops!  Something went wrong! Your Credit Card information needs to be updated for Punchcard. Please update your billing information at your earliest convenience here. ',200);die;
        }


    }

    /**
     * Access token generation
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function accessToken()
    {
        $ch = curl_init();

        curl_setopt($ch, CURLOPT_URL, "https://api.sandbox.paypal.com/v1/oauth2/token");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, "grant_type=client_credentials");
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_USERPWD, "AakaY2FvGBHcNTNjfdOneGD8zMo9_fY2k7LQjY0OLTRduVmfD9tDmAxDooZMjIaVwazIQGe8Vyg5NwVx" . ":" . "EIN9qKRT7UP4mL44G3UJKq4j8gO-xYKQt6elRe_2IybV2NwHj0XeI1uncGeiS74rpsr9Gn3J4c5yiPGP");//old details
        // curl_setopt($ch, CURLOPT_USERPWD, "AZKmAru1uTWBaPMVohyYKwOhGOZV-hpwewy9UeoBVURDELq0G4npBCg3vmJl44F83_6ylDvZgpTn81IK" . ":" . "EO-SU_PP9KYHzEW08iEfMsC7tuafFYvdV3YUDDD5OPPxoq_jHW6GYky45QYiTctWdOqCH1wrIKLLE0oS"); //new details

        $headers = array();
        $headers[] = "Accept: application/json";
        $headers[] = "Accept-Language: en_US";
        $headers[] = "Content-Type: application/x-www-form-urlencoded";
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

        $result = curl_exec($ch);
        if (curl_errno($ch)) {
            echo 'Error:' . curl_error($ch);
        }
        curl_close ($ch);
        $result = json_decode($result);
        $token = $result->access_token;
        return $token;
    }

    /**
     * Unsubscribe Company 
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function unsubscribe(Request $request)
    {  
        $client_id = $request->input('client_id');
        $user_id  = $request->input('user_id');
        $validationError = array();
        if(empty($client_id)){
         $validationError['client_id'] = 'required';
        }
        if(empty($user_id)){
         $validationError['user_id'] = 'required';
        }
        if(count($validationError) > 0){
         return $this->failureResponse('Failed', $validationError,200);
         die;
        }

        $paymentDone = $this->takePaymentBeforeCycle($client_id,$user_id,'unsubscribe');
       
       if($paymentDone['success']){

         $removecard_response = $this->removeCardFromPaypal($paymentDone['cc_id']);

        if(empty($removecard_response)){ //success
          $this->updatePlanAndPermission($client_id,'unsubscribe');
          DB::table('cc_users')->where('client_id', '=', $client_id)->update(['IsDeleted'=>true]);

            $clientadminDatas = DB::table('users')->where('client_id','=',$client_id)->where('role','=','clientadmin')->get();
            $companyName = DB::table('clients')->where('id', '<>', 1)->where('id','=',$client_id)->first();
        

        foreach ($clientadminDatas as $clientadminData) {

          $CaEmail = $clientadminData->email;
          $todayTime = \Carbon\Carbon::now();

        \Mail::send('email_tem.unsubscribeNoticeEmail', ['clientAdminFirstName'=>$clientadminData->first_name, 'deactivatedDate'=>$todayTime, 'companyName'=>$companyName->subdomain], function($message)use ($CaEmail) {

                    $message->to($CaEmail);
                    $message->bcc('admin@punchcardllc.com');
                    $message->subject('Punchcard Account Administration - Unsubscribe Notice');
                 });

      }
         return $this->jsonSuccess('Success',[]);die;
        }else{ 
         return $this->failureResponse('Failed', 'Something went wrong, Please try again',200);die;
        }
       }else{
        return $this->failureResponse('Failed', 'Oops!  Something went wrong! Your Credit Card information needs to be updated for Punchcard. Please update your billing information at your earliest convenience here. ',200);die;
       }
        
    }

    public function detailsEnter(Request $request)
    {       
        $card_number = $request->input('number');
        $client_id = $request->input('client_id');
        $user_id  = $request->input('user_id');
        $version  = $request->input('version');
        $card_type   = $request->input('type');
        $expire_month = $request->input('expire_month');
        $expire_year = $request->input('expire_year');
        $cvv2 = $request->input('cvv2');
        $first_name = $request->input('first_name');
        $last_name = $request->input('last_name');
        $billing_address = $request->input('billing_address');
        $line1 = $billing_address['line1'];
        $city = $billing_address['city'];
        $country_code = $billing_address['country_code'];
        $postal_code = $billing_address['postal_code'];
        $state = $billing_address['state'];
        $phone = $billing_address['phone'];
        

        
        $external_customer_id = $first_name.'_'.$last_name.$phone;

        $validationError = array();
        if(empty($card_number)){
         $validationError['number'] = 'required';
        }
        if(empty($client_id)){
         $validationError['client_id'] = 'required';
        }
        if(empty($user_id)){
         $validationError['user_id'] = 'required';
        }
        if(empty($version)){
         $validationError['version'] = 'required';
        }
        if(empty($card_type)){
         $validationError['card_type'] = 'required';
        }
        if(empty($expire_month)){
         $validationError['expire_month'] = 'required';
        }
        if(empty($cvv2)){
         $validationError['cvv2'] = 'required';
        }
        if(empty($first_name)){
         $validationError['first_name'] = 'required';
        }
        if(empty($last_name)){
         $validationError['last_name'] = 'required';
        }
        if(empty($billing_address)){
         $validationError['billing_address'] = 'required';
        }
        if(empty($line1)){
         $validationError['line1'] = 'required';
        }
        if(empty($city)){
         $validationError['city'] = 'required';
        }
        if(empty($state)){
         $validationError['state'] = 'required';
        }
        if(empty($postal_code)){
         $validationError['postal_code'] = 'required';
        }
        if(empty($phone)){
         $validationError['phone'] = 'required';
        }
        if(count($validationError) > 0){
         return $this->failureResponse('Failed', $validationError,200);
        }

        $access_token = $this->accessToken();
      
        $ch = curl_init();

        curl_setopt($ch, CURLOPT_URL, "https://api.sandbox.paypal.com/v1/vault/credit-cards/");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, "{\n  \"number\":\"$card_number\",\n  \"type\":\"$card_type\",\n  \"expire_month\":$expire_month,\n  \"expire_year\":$expire_year,\n  \"cvv2\":\"$cvv2\",\n  \"first_name\":\"$first_name\",\n  \"last_name\":\"$last_name\",\n  \"billing_address\":{\n    \"line1\":\"$line1\",\n    \"city\":\"$city\",\n    \"country_code\":\"$country_code\",\n    \"postal_code\":\"$postal_code\",\n    \"state\":\"$state\",\n    \"phone\":\"$phone\"\n  },\n  \"external_customer_id\":\"$external_customer_id\"\n}");
        curl_setopt($ch, CURLOPT_POST, 1);

        $headers = array();
        $headers[] = "Content-Type: application/json";
        $headers[] = "Authorization: Bearer ".$access_token;
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

        $result = curl_exec($ch);
        if (curl_errno($ch)) {
            echo 'Error:' . curl_error($ch);
        }
        curl_close ($ch);
        $result_d=json_decode($result,true);
        if(!empty($result_d['id'])){
          
            $currentrMonth = \Carbon\Carbon::now()->subDay();
            $nextMonth  = \Carbon\Carbon::now()->addMonths(1)->subDay();
            /*Inserting a info into db*/
            $insertID = DB::table('cc_users')->insertGetId(
                    ['first_name' => $first_name, 'last_name' => $last_name,'phone'=>$phone,'address'=>$line1,'city'=>$city,'state'=>$state,'country'=>$country_code,'postal_code'=>$postal_code,'client_id'=>$client_id,'version'=>$version,'user_id'=>$user_id,'cc_id'=>$result_d['id'],'cc_state'=>$result_d['state'],'cc_external_customer_id'=>$result_d['external_customer_id'],'cc_type'=>$result_d['type'],'cc_number'=>$result_d['number'],'cc_expire_month'=>$result_d['expire_month'],'cc_expire_year'=>$result_d['expire_year'],'cc_valid_until'=>$result_d['valid_until'],'cc_create_time'=>$result_d['create_time'],'cc_update_time'=>$result_d['update_time'],'last_billing_date'=>$currentrMonth,'next_billing_date'=>$nextMonth

                ]
                );

        $todayDate = \Carbon\Carbon::now();
        DB::table('clients')->where('id', $client_id)->update(['plan_test' => $version,'status' => 'active','suscribedDate' => $todayDate]);
        DB::table('clients')->where('child_of_id', $client_id)->update(['plan_test' => $version,'status' => 'active']); 

        $users = DB::table('users')->whereIn('client_id', function($query) use ($client_id){
            $query->select('id')->from('clients')->where('id','=',$client_id)->orWhere('child_of_id','=',$client_id);
        })->get();
        if(count($users) > 0){
            foreach($users as $user){
              $id = $user->id;
              $permission = $user->permissions;
              $permissionArr = json_decode($permission,true);
              if(strtolower($version)=='base'){
                $permissionArr['reports'] = array(9, 4, 5, 6, 7, 8);
              }else{
                $permissionArr['reports'] = array();
              }

              $permission = json_encode($permissionArr);
              DB::table('users')->where('id', $id)->update(['permissions'=>$permission]);
            }
         
        }
        $clientadminDatas = DB::table('users')->where('client_id','=',$client_id)->where('role','=','clientadmin')->get();
        $companyName = DB::table('clients')->where('id', '<>', 1)->where('id','=',$client_id)->first();

        foreach ($clientadminDatas as $clientadminData) {

                 $CaEmail = $clientadminData->email;
                 $nextMonth = \Carbon\Carbon::today()->addMonths(1)->subDay();

            \Mail::send('email_tem.successfulSubscriptionNotice', ['clientAdminFirstName'=>$clientadminData->first_name, 'version'=>$version, 'ccNumber' => $result_d['number'], 'billing_date'=>$nextMonth, 'companyName'=>$companyName->subdomain], function($message)use ($CaEmail) {

                    $message->to($CaEmail);
                    $message->bcc('admin@punchcardllc.com');
                    $message->subject('Punchcard Account Administration - Punchcard Subscription');
                 }); 
          }


            return $this->jsonSuccess('Success', []);die;
        }
       return $this->failureResponse('Failed', $result,200);
        
    
                
    }

    public function billing_cycle($value=''){ 

        $access_token = $this->accessToken();
        $currentrMonth = \Carbon\Carbon::today()->subDay()->toDateString();    
        $currentrMonth = $currentrMonth.' 23:59:59'; 
        
        $nextMonth  = \Carbon\Carbon::now()->addMonths(1)->subDay();

        $cc_users = DB::table('cc_users')->where('IsDeleted','=',FALSE)->where('next_billing_date','<=', $currentrMonth)->get();     
       
        if(count($cc_users) > 0 ){
          foreach ($cc_users as $user) {
            $id = $user->id;
            $client_id = $user->client_id;
            $version = $user->version;
            $user_id = $user->user_id;
            $previousBillingDate = $user->last_billing_date;
            $punchs = DB::table('checks') 
            ->select('checks.user_id as uid')            
            ->whereIn('user_id',function($query) use ($client_id){               
               $query->select('id')->from('users')->whereIn('client_id',function($query2) use ($client_id){               
                  $query2->select('id')->from('clients')->where('id','=',$client_id)->orWhere('child_of_id','=',$client_id);
                });
             })
            ->where('created_at','>',$previousBillingDate)
            ->where('created_at','<=',$currentrMonth)
            ->groupBy('uid')
            ->get(); 
            
            $totalPunchs = count($punchs);
            if($totalPunchs==0){continue;}
            if($version=='standard'){
               $perPunch = 2.0;
            }else{
                $perPunch = 1.0;
            }
            $total = $totalPunchs*$perPunch;
            $data = array();
            $data['cc_id'] = $user->cc_id;
            $data['cc_external_customer_id'] =$user->cc_external_customer_id;
            $data['total'] =$total;
            $data['access_token'] = $access_token;
            $response = $this->createPayment($data);            
            if(!empty($response['state']) && $response['state']=='approved'){
                        
               DB::table('cc_users')->where('IsDeleted','=',FALSE)->where('id','=', $id)->update(['last_billing_date'=>$currentrMonth,'next_billing_date'=>$nextMonth]);

               $insertID = DB::table('payment_txn')->insertGetId(
                    [ 
                        'txn_id'=>$response['id'],
                        'state'=>$response['state'],
                        'intent'=>$response['intent'],
                        'payment_method'=>$response['payer']['payment_method'],
                        'txn_amount'=>$total,
                        'currency'=>'USD',
                        'per_punch_cost'=>$perPunch,
                        'client_id'=>$client_id,
                        'user_id'=>$user_id,
                        'create_time'=>$response['create_time'],
                        'update_time'=>$response['update_time'],
                        'total_punch'=>$totalPunchs,
                        'version'=>$version,
                        'billing_start_date'=> $previousBillingDate,
                        'billing_end_date'=> $currentrMonth

                    ]
                );

       
        $companyName = DB::table('clients')->where('id', '<>', 1)->where('id','=',$client_id)->first();
        $companyName = $companyName->subdomain;
            DB::table('clients')->where('id', '=',$client_id)->where('creditCardDeactivateDate','!=',NULL)->update([ 'creditCardDeactivateDate' => NULL]);
            DB::table('clients')->where('child_of_id','=', $client_id)->where('creditCardDeactivateDate','!=',NULL)->update([ 'creditCardDeactivateDate' => NULL]);

        $this->sendMailToClientAdmin($client_id,$previousBillingDate,$currentrMonth,0,$companyName, $total,$perPunch,'payment');

            }else{
        
            $accDeactivatedate = \Carbon\Carbon::today()->addDays(1);

            DB::table('clients')->where('id', '=',$client_id)->where('creditCardDeactivateDate','=',NULL)->update([ 'creditCardDeactivateDate' => $accDeactivatedate]);

            DB::table('clients')->where('child_of_id','=', $client_id)->where('creditCardDeactivateDate','=',NULL)->update([ 'creditCardDeactivateDate' => $accDeactivatedate]);

        $clientadminDatas = DB::table('users')->where('client_id','=',$client_id)->where('role','=','clientadmin')->get();
        $companyName = DB::table('clients')->where('id', '<>', 1)->where('id','=',$client_id)->first();
        

        foreach ($clientadminDatas as $clientadminData) {

          $CaEmail = $clientadminData->email;
          

        \Mail::send('email_tem.CCExpiredDeclined', ['clientAdminFirstName'=>$clientadminData->first_name, 'deactivatedDate'=>$accDeactivatedate, 'companyName'=>$companyName->subdomain, 'subscriptionTier'=>$version, 'subscriptionDate' => $companyName->suscribedDate], function($message)use ($CaEmail) {

                    $message->to($CaEmail);
                    $message->bcc('admin@punchcardllc.com');
                    $message->subject('Punchcard Account Administration - Credit Card Update Required');
                 });

      }


            }

          }
        }
        else{
          DB::table('cc_users')->where('IsDeleted','=',FALSE)->where('id','=', $id)->update(['last_billing_date'=>$currentrMonth,'next_billing_date'=>$nextMonth]);

               $insertID = DB::table('payment_txn')->insertGetId(
                    [ 
                        'txn_id'=>'NA',
                        'state'=>'approved',
                        'intent'=>'NA',
                        'payment_method'=>'NA',
                        'txn_amount'=>0,
                        'currency'=>'NA',
                        'per_punch_cost'=>0,
                        'client_id'=>$client_id,
                        'user_id'=>$user_id,
                        'create_time'=>NULL,
                        'update_time'=>NULL,
                        'total_punch'=>0,
                        'version'=>$version,
                        'billing_start_date'=> $previousBillingDate,
                        'billing_end_date'=> $currentrMonth

                    ]
                );
        } 
    }

    public function createPayment($data=null){            
      
        $cc_id = $data['cc_id'];
        $cc_external_customer_id = $data['cc_external_customer_id'];
        $total = $data['total'];
        // echo "{\n  \"id\":\"CPPAY-13U467758H032001PKPIFQZI\",\n  \"intent\":\"sale\",\n  \"payer\":{\n    \"payment_method\":\"credit_card\",\n    \"funding_instruments\":[\n      {\n        \"credit_card_token\":{\n          \"credit_card_id\":\"".$cc_id ."\",\n          \"external_customer_id\":\"".$cc_external_customer_id."\"\n        }\n      }\n    ]\n  },\n  \"transactions\":[\n    {\n      \"amount\":{\n        \"total\":\"".$total."\",\n        \"currency\":\"USD\"\n      },\n      \"description\":\"Payment by vaulted credit card.\"\n    }\n  ]\n}";die;
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, "https://api.sandbox.paypal.com/v1/payments/payment");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, "{\n  \"id\":\"CPPAY-13U467758H032001PKPIFQZI\",\n  \"intent\":\"sale\",\n  \"payer\":{\n    \"payment_method\":\"credit_card\",\n    \"funding_instruments\":[\n      {\n        \"credit_card_token\":{\n          \"credit_card_id\":\"".$cc_id ."\",\n          \"external_customer_id\":\"".$cc_external_customer_id."\"\n        }\n      }\n    ]\n  },\n  \"transactions\":[\n    {\n      \"amount\":{\n        \"total\":\"".$total."\",\n        \"currency\":\"USD\"\n      },\n      \"description\":\"Payment by vaulted credit card.\"\n    }\n  ]\n}");
        curl_setopt($ch, CURLOPT_POST, 1);

        $headers = array();
        $headers[] = "Content-Type: application/json";
        $headers[] = "Authorization: Bearer ".$data['access_token'];
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

        $result = curl_exec($ch);
        if (curl_errno($ch)) {
            return array('error'=>curl_error($ch));           
        }
        curl_close ($ch);
        return json_decode($result,true);
    }
    
    public function removeCardFromPaypal($cc_id){
        $access_token = $this->accessToken();
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, "https://api.sandbox.paypal.com/v1/vault/credit-cards/$cc_id");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "DELETE");


        $headers = array();
        $headers[] = "Content-Type: application/json";
        $headers[] = "Authorization: Bearer ".$access_token;
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

        $result = curl_exec($ch);
        if (curl_errno($ch)) {
           return array('error'=>curl_error($ch));
        }
      return json_decode($result,true);
       
    }

  public function takePaymentBeforeCycle($client_id,$user_id, $paramCheck){
        //Bill first after payment success run below code

        $user = DB::table('cc_users')->where('IsDeleted',FALSE)->where('client_id', $client_id)->first();

        // $currentrMonth = \Carbon\Carbon::now();
        $currentrMonth = \Carbon\Carbon::today()->toDateString();    
        $currentrMonth = $currentrMonth.' 23:59:59'; 
        $access_token = $this->accessToken();     
        
        $id = $user->id;
        $client_id = $user->client_id;
        $version = $user->version;
        $nextMonth = \Carbon\Carbon::now()->addMonth();
        
        $cc_id = $user->cc_id;
        $cc_external_customer_id = $user->cc_external_customer_id;        
        $previousBillingDate = $user->last_billing_date;
        $punchs = DB::table('checks') 
        ->select('checks.user_id as uid')            
        ->whereIn('user_id',function($query) use ($client_id){               
           $query->select('id')->from('users')->whereIn('client_id',function($query2) use ($client_id){               
              $query2->select('id')->from('clients')->where('id','=',$client_id)->orWhere('child_of_id','=',$client_id);
            });
         })
        ->where('created_at','>',$previousBillingDate)
        ->where('created_at','<=',$currentrMonth)
        ->groupBy('uid')
        ->get(); 
        
        $totalPunchs = count($punchs);
        // $totalPunchs = 10;
        $paymentDone = true;
        $response = array();
        if($totalPunchs > 0){
            $paymentDone = false;

            if($version=='standard'){
               $perPunch = 2.0;
            }else{
                $perPunch = 1.0;
            }
            $total = $totalPunchs*$perPunch;
            $data = array();
            $data['cc_id'] = $cc_id;
            $data['cc_external_customer_id'] = $cc_external_customer_id;
            $data['total'] =$total;
            $data['access_token'] = $access_token;
            $response = $this->createPayment($data);
                 
            if(!empty($response['state']) && $response['state']=='approved'){
               $paymentDone = true;

               DB::table('cc_users')->where('IsDeleted','=',FALSE)->where('id','=', $id)->update(['last_billing_date'=>$currentrMonth,'next_billing_date'=>$nextMonth]);

               $insertID = DB::table('payment_txn')->insertGetId(
                    [ 
                        'txn_id'=>$response['id'],
                        'state'=>$response['state'],
                        'intent'=>$response['intent'],
                        'payment_method'=>$response['payer']['payment_method'],
                        'txn_amount'=>$total,
                        'currency'=>'USD',
                        'per_punch_cost'=>$perPunch,
                        'client_id'=>$client_id,
                        'user_id'=>$user_id,
                        'create_time'=>$response['create_time'],
                        'update_time'=>$response['update_time'],
                        'total_punch'=>$totalPunchs,
                        'version'=>$version,
                        'billing_start_date'=> $previousBillingDate,
                        'billing_end_date'=> $currentrMonth


                    ]
                );  

               $companyName = DB::table('clients')->where('id', '<>', 1)->where('id','=',$client_id)->first();
               $companyName = $companyName->subdomain;
               $this->sendMailToClientAdmin($client_id,$previousBillingDate,$currentrMonth,0,$companyName, $total,$perPunch,'payment');
           }else{

            if($paramCheck == 'cardRenew'){
                $getDeactivateDate = DB::table('clients')->select('creditCardDeactivateDate')->where('id', '<>', 1)->where('id', '=', $client_id)->where('creditCardDeactivateDate','!=',NULL)->first();
                
                $accDeactivatedate = $getDeactivateDate->creditCardDeactivateDate;

            }else{
                $accDeactivatedate = \Carbon\Carbon::today()->addDays(1);
            }
            DB::table('clients')->where('id', '=',$client_id)->where('creditCardDeactivateDate','=',NULL)->update([ 'creditCardDeactivateDate' => $accDeactivatedate]);

            DB::table('clients')->where('child_of_id','=', $client_id)->where('creditCardDeactivateDate','=',NULL)->update([ 'creditCardDeactivateDate' => $accDeactivatedate]);

            $clientadminDatas = DB::table('users')->where('client_id','=',$client_id)->where('role','=','clientadmin')->get();
            $companyName = DB::table('clients')->where('id','=',$client_id)->first();
        

        foreach ($clientadminDatas as $clientadminData) {
                
            $CaEmail = $clientadminData->email;
    
            \Mail::send('email_tem.CCExpiredDeclined', ['clientAdminFirstName'=>$clientadminData->first_name, 'deactivatedDate'=>$accDeactivatedate, 'companyName'=>$companyName->subdomain, 'subscriptionTier'=>$version, 'subscriptionDate' => $user->last_billing_date], function($message)use ($CaEmail){

                        $message->to($CaEmail);
                        $message->bcc('admin@punchcardllc.com');
                        $message->subject('Punchcard Account Administration - Credit Card Update Required');
                    });
        }
    }  
}
        else{
          DB::table('cc_users')->where('IsDeleted','=',FALSE)->where('id','=', $id)->update(['last_billing_date'=>$currentrMonth,'next_billing_date'=>$nextMonth]);

               $insertID = DB::table('payment_txn')->insertGetId(
                    [ 
                        'txn_id'=>'NA',
                        'state'=>'approved',
                        'intent'=>'NA',
                        'payment_method'=>'NA',
                        'txn_amount'=>0,
                        'currency'=>'NA',
                        'per_punch_cost'=>0,
                        'client_id'=>$client_id,
                        'user_id'=>$user_id,
                        'create_time'=>NULL,
                        'update_time'=>NULL,
                        'total_punch'=>0,
                        'version'=>$version,
                        'billing_start_date'=> $previousBillingDate,
                        'billing_end_date'=> $currentrMonth

                    ]
                );
        }


      return array('success'=>$paymentDone,'cc_id'=>$cc_id,'response'=>$response);
  }

  public function updatePlanAndPermission($client_id,$version){
    
    if($version == 'unsubscribe'){
        $todayDate = \Carbon\Carbon::now();
        DB::table('clients')->where('id', $client_id)->update(['plan_test' => $version, 'unsubscribedDate' => $todayDate]);
        DB::table('clients')->where('child_of_id', $client_id)->update(['plan_test' => $version]); 
    }else{
        DB::table('clients')->where('id', $client_id)->update(['plan_test' => $version]);
        DB::table('clients')->where('child_of_id', $client_id)->update(['plan_test' => $version]); 
      }   
          
          $users = DB::table('users')->whereIn('client_id', function($query) use ($client_id){
            $query->select('id')->from('clients')->where('id','=',$client_id)->orWhere('child_of_id','=',$client_id);
        })->get();
        if(count($users) > 0){
            foreach($users as $user){
              $id = $user->id;
              $permission = $user->permissions;
              $permissionArr = json_decode($permission,true);             
              if(strtolower($version)=='base'){
                $permissionArr['reports'] = array(9, 4, 5, 6, 7, 8);
              }else{
                $permissionArr['reports'] = array();
              }   

              $permission = json_encode($permissionArr);
              DB::table('users')->where('id', $id)->update(['permissions'=>$permission]);
            }         
        }
    
  }

  public function emailtrial(){

        $date = \Carbon\Carbon::now();
        $clients  = DB::table('clients')->where('id', '<>', 1)->where('child_of_id','0')->where('plan_test','=','trial')->get();
        $totalDayInMonth = 30;       

        if(count($clients) > 0){
          foreach ($clients as $client) {
            $client_id = $client->id;
            $created_at = $client->created_at;
            $created_at = \Carbon\Carbon::parse($created_at);        
            $length = $date->diffInDays($created_at);          
            $trial_expire_date =  $created_at->addDays($totalDayInMonth)->format('Y-m-d') ;
            
            $emailsendDay = $totalDayInMonth-$length;
           
            $companyName = $client->subdomain;
 
            if($emailsendDay == 1 || $emailsendDay == 3 || $emailsendDay == 5 || $emailsendDay == 0){
                      
              $this->sendMailToClientAdmin($client_id,$created_at,$trial_expire_date, $emailsendDay,$companyName,0,0,'trial');
            }                      
          }
        } 

  }
  
  public function sendMailToClientAdmin($client_id,$billing_start_date,$billing_end_date,$emailsendDay, $companyName,$totalAmount, $costperuser, $type){
      $clientadminDatas = DB::table('users')->where('client_id','=',$client_id)->where('role','=','clientadmin')->get();

       $totalUsers = DB::table('users') 
                      ->select('id')  
                      ->whereIn('client_id',function($query) use ($client_id){ 
                            $query->select('id')->from('clients')->where('id','=',$client_id)->orWhere('child_of_id','=',$client_id);            
                       })        
                      ->count();

        $totalActiveUsers = DB::table('users') 
                      ->select('id') 
                      ->where('status','=','active')            
                      ->whereIn('client_id',function($query) use ($client_id){ 
                            $query->select('id')->from('clients')->where('id','=',$client_id)->orWhere('child_of_id','=',$client_id);            
                       })        
                      ->count();

        $totalPunchs =  DB::table('checks') 
                        ->select('checks.user_id as uid')            
                        ->whereIn('user_id',function($query) use ($client_id){               
                           $query->select('id')->from('users')->whereIn('client_id',function($query2) use ($client_id){               
                              $query2->select('id')->from('clients')->where('id','=',$client_id)->orWhere('child_of_id','=',$client_id);
                            });
                         })
                         ->where('created_at','>',$billing_start_date)
                         ->where('created_at','<=',$billing_end_date)
                        ->groupBy('uid')
                        ->get(); 
        $totalPunchs = count($totalPunchs);

        $totalChildCompanies = DB::table('clients')
                                  ->select('id')
                                  ->where('child_of_id','=',$client_id)
                                  ->where('id', '<>', 1)
                                  ->count();
        $totalChildCompaniesUsers = DB::table('users') 
                                    ->select('id')  
                                    ->whereIn('client_id',function($query) use ($client_id){ 
                                          $query->select('id')->from('clients')->where('child_of_id','=',$client_id);            
                                     })        
                                    ->count();
        $checkData    = new CheckStatsData;
        $totalHours   = $checkData->totalHoursByClientId($client_id, $billing_start_date, $billing_end_date);                        
        foreach ($clientadminDatas as $clientadminData) {

                 $CaEmail = $clientadminData->email;

                 if($type == 'trial'){
                        
                \Mail::send('email_tem.trialExpiringEmail', ['clientAdminFirstName'=>$clientadminData->first_name, 'dayRemain'=>$emailsendDay, 'trial_expire_date' => $billing_end_date, 'companyName'=>$companyName, 'totalChildCompaniesUsers' => $totalChildCompaniesUsers, 'totalChildCompanies' => $totalChildCompanies, 'totalPunchs' => $totalPunchs, 'totalActiveUsers' => $totalActiveUsers, 'totalUsers' => $totalUsers, 'totalHours' => $totalHours], function($message)use ($CaEmail,$billing_end_date) {

                    $message->to($CaEmail);
                    $message->bcc('admin@punchcardllc.com');
                    $message->subject('Punchcard Account Administration - Trial Expiring On '.$billing_end_date);
                 });   

                 }else{
                  
                    \Mail::send('email_tem.paymentTransactionReceipt', ['clientAdminFirstName'=>$clientadminData->first_name, 'Billing_Cycle_Date' => $billing_end_date, 'companyName'=>$companyName, 'totalChildCompaniesUsers' => $totalChildCompaniesUsers, 'totalChildCompanies' => $totalChildCompanies, 'totalPunchs' => $totalPunchs, 'totalActiveUsers' => $totalActiveUsers, 'totalUsers' => $totalUsers, 'costperuser'=> $costperuser, 'totalAmount'=> $totalAmount, 'totalHours' => $totalHours], function($message)use ($CaEmail) {

                    $message->to($CaEmail);
                    $message->bcc('admin@punchcardllc.com');
                    $message->subject('Punchcard Account Administration - Payment Receipt and Activity Summary');
                 }); 
                 }
        }            

            
  }
  public function punchHistory(Request $request){

        $client_id = $request->input('client_id');
        $user_id  = $request->input('user_id');
        $validationError = array();
        if(empty($client_id)){
         $validationError['client_id'] = 'required';
        }
        if(empty($user_id)){
         $validationError['user_id'] = 'required';
        }
        if(count($validationError) > 0){
         return $this->failureResponse('Failed', $validationError,200);
         die;
        }
        $txn_history = DB::table('payment_txn')->where('state','=','approved')->where('client_id','=',$client_id)->get();
        
        return $this->jsonSuccess('Success', $txn_history);die;
        
  }


  public function currentMonthPunch(Request $request){

        $client_id = $request->input('client_id');
        $user_id  = $request->input('user_id');
        $validationError = array();

        if(empty($client_id)){
         $validationError['client_id'] = 'required';
        }
        if(empty($user_id)){
         $validationError['user_id'] = 'required';
        }
        if(count($validationError) > 0){
         return $this->failureResponse('Failed', $validationError,200);
         die;
        }


        $user = DB::table('cc_users')->where('IsDeleted',FALSE)->where('client_id', $client_id)->first();
        if(count($user) <= 0){
          
          $projects = DB::table('clients')->where('id', '<>', 1)->where('id','=', $client_id)->where('child_of_id','=', 0)->where('plan_test','trial')->first();
          
          $previousBillingDate = $projects->created_at;
          $nextMonth = \Carbon\Carbon::parse($projects->created_at)->addMonths(1)->toDateTimeString();           
        }else{
          $previousBillingDate = $user->last_billing_date;
          $nextMonth = $user->next_billing_date;
          
        }
        $currentrMonth = \Carbon\Carbon::today()->toDateString();    
        $currentrMonth = $currentrMonth.' 23:59:59';                     
        $punchs = DB::table('checks') 
        ->select('checks.user_id as uid')            
        ->whereIn('user_id',function($query) use ($client_id){               
           $query->select('id')->from('users')->whereIn('client_id',function($query2) use ($client_id){               
              $query2->select('id')->from('clients')->where('id','=',$client_id)->orWhere('child_of_id','=',$client_id);
            });
         })
        ->where('created_at','>',$previousBillingDate)
        ->where('created_at','<=',$currentrMonth)
        ->groupBy('uid')
        ->get(); 
        
        $totalPunchs = count($punchs);
        return $this->jsonSuccess('Success', ['punches'=> $totalPunchs,'next_billing_date'=>$nextMonth]);die;
        
  }

  public function updateCard(Request $request){
        
        $card_number = $request->input('number');
        $client_id = $request->input('client_id');
        $user_id  = $request->input('user_id');
        $card_type   = $request->input('type');
        $expire_month = $request->input('expire_month');
        $expire_year = $request->input('expire_year');
        $cvv2 = $request->input('cvv2');
        $first_name = $request->input('first_name');
        $last_name = $request->input('last_name');
        $cardRenew = $request->input('cardRenew');
        $billing_address = $request->input('billing_address');
        $line1 = $billing_address['line1'];
        $city = $billing_address['city'];
        $country_code = $billing_address['country_code'];
        $postal_code = $billing_address['postal_code'];
        $state = $billing_address['state'];
        $phone = $billing_address['phone'];
        $external_customer_id = $first_name.'_'.$last_name.$phone;
        
        $validationError = array();
        if(empty($card_number)){
         $validationError['number'] = 'required';
        }
        // if(empty($cardRenew)){
        //  $validationError['cardRenew'] = 'required';
        // }
        if(empty($client_id)){
         $validationError['client_id'] = 'required';
        }
        if(empty($user_id)){
         $validationError['user_id'] = 'required';
        }
        if(empty($card_type)){
         $validationError['card_type'] = 'required';
        }
        if(empty($expire_month)){
         $validationError['expire_month'] = 'required';
        }
        if(empty($cvv2)){
         $validationError['cvv2'] = 'required';
        }
        if(empty($first_name)){
         $validationError['first_name'] = 'required';
        }
        if(empty($last_name)){
         $validationError['last_name'] = 'required';
        }
        if(empty($billing_address)){
         $validationError['billing_address'] = 'required';
        }
        if(empty($line1)){
         $validationError['line1'] = 'required';
        }
        if(empty($city)){
         $validationError['city'] = 'required';
        }
        if(empty($state)){
         $validationError['state'] = 'required';
        }
        if(empty($postal_code)){
         $validationError['postal_code'] = 'required';
        }
        if(empty($phone)){
         $validationError['phone'] = 'required';
        }
        if(count($validationError) > 0){
         return $this->failureResponse('Failed', $validationError,200);
        }

        $access_token = $this->accessToken();
      
        $ch = curl_init();

        curl_setopt($ch, CURLOPT_URL, "https://api.sandbox.paypal.com/v1/vault/credit-cards/");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, "{\n  \"number\":\"$card_number\",\n  \"type\":\"$card_type\",\n  \"expire_month\":$expire_month,\n  \"expire_year\":$expire_year,\n  \"cvv2\":\"$cvv2\",\n  \"first_name\":\"$first_name\",\n  \"last_name\":\"$last_name\",\n  \"billing_address\":{\n    \"line1\":\"$line1\",\n    \"city\":\"$city\",\n    \"country_code\":\"$country_code\",\n    \"postal_code\":\"$postal_code\",\n    \"state\":\"$state\",\n    \"phone\":\"$phone\"\n  },\n  \"external_customer_id\":\"$external_customer_id\"\n}");
        curl_setopt($ch, CURLOPT_POST, 1);

        $headers = array();
        $headers[] = "Content-Type: application/json";
        $headers[] = "Authorization: Bearer ".$access_token;
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

        $result = curl_exec($ch);
        if (curl_errno($ch)) {
            echo 'Error:' . curl_error($ch);
        }
        curl_close ($ch);
        
        $result_d=json_decode($result,true);
        if(!empty($result_d['id'])){
            $currentrMonth = \Carbon\Carbon::now()->subDay();
            $nextMonth  = \Carbon\Carbon::now()->addMonths(1)->subDay();
            /*Inserting a info into db*/

            $ccData = DB::table('cc_users')->select('last_billing_date', 'next_billing_date', 'version','upgradedBy','updatedDate','cc_id')->where('client_id','=',$client_id)->where('IsDeleted','=',FALSE)->first();

            $removecard_response = $this->removeCardFromPaypal($ccData->cc_id);

        // if(empty($removecard_response)){ //success
          
          DB::table('cc_users')->where('IsDeleted','=',FALSE)->where('client_id', '=', $client_id)->update(['IsDeleted'=>TRUE,'comments'=>'CC details updated by '. $user_id]);
            
            $insertID = DB::table('cc_users')->insertGetId(
                    ['first_name' => $first_name, 'last_name' => $last_name,'phone'=>$phone,'address'=>$line1,'city'=>$city,'state'=>$state,'country'=>$country_code,'postal_code'=>$postal_code,'client_id'=>$client_id,'version'=>$ccData->version,'user_id'=>$user_id,'cc_id'=>$result_d['id'],'cc_state'=>$result_d['state'],'cc_external_customer_id'=>$result_d['external_customer_id'],'cc_type'=>$result_d['type'],'cc_number'=>$result_d['number'],'cc_expire_month'=>$result_d['expire_month'],'cc_expire_year'=>$result_d['expire_year'],'cc_valid_until'=>$result_d['valid_until'],'cc_create_time'=>$result_d['create_time'],'cc_update_time'=>$result_d['update_time'],'last_billing_date'=>$ccData->last_billing_date,'next_billing_date'=>$ccData->next_billing_date,'upgradedBy'=>$ccData->upgradedBy,'updatedDate'=>$ccData->updatedDate, 'comments'=>'CC details updated by '. $user_id

                ]
                );
        // }
        
        if($cardRenew){
          $paymentDone = $this->takePaymentBeforeCycle($client_id, $user_id, 'cardRenew');
    
          if($paymentDone['success']){ 
      
            DB::table('clients')->where('id', '=',$client_id)->where('creditCardDeactivateDate','!=',NULL)->update([ 'creditCardDeactivateDate' => NULL]);

            DB::table('clients')->where('child_of_id','=', $client_id)->where('creditCardDeactivateDate','!=',NULL)->update([ 'creditCardDeactivateDate' => NULL]);
          }else{

            return $this->failureResponse('Failed', json_encode($paymentDone['response']),200);die;
          }

        }
        
        return $this->jsonSuccess('Success', []);die;
        }
       return $this->failureResponse('Failed', $result,200);
  }

  public function ccExpiredMail($value='')
  {

    $date = \Carbon\Carbon::today();
    $InactiveCompanies = DB::table('clients')->where('creditCardDeactivateDate','!=',NULL)->where('child_of_id','0')->where('id', '<>', 1)->get();
    $totalDayInMonth = 2;

    if(count($InactiveCompanies) > 0){

      foreach ($InactiveCompanies as $InactiveCompany) {

        $creditCardDeactivateDate = $InactiveCompany->creditCardDeactivateDate;
        $creditCardDeactivateDate = \Carbon\Carbon::parse($creditCardDeactivateDate);            
        $length = $date->diffInDays($creditCardDeactivateDate);          
        $emailsendDay = $totalDayInMonth-$length;
        $client_id = $InactiveCompany->id;

        if($emailsendDay == 1){

            $clientadminDatas = DB::table('users')->where('client_id','=',$client_id)->where('role','=','clientadmin')->get();
            $companyName = DB::table('clients')->where('id', '<>', 1)->where('id','=',$client_id)->first();
        

            foreach ($clientadminDatas as $clientadminData) {

             $CaEmail = $clientadminData->email;
              

            \Mail::send('email_tem.accountDeactivatedNotice', ['clientAdminFirstName'=>$clientadminData->first_name, 'deactivatedDate'=>$creditCardDeactivateDate, 'companyName'=>$companyName->subdomain], function($message)use ($CaEmail) {

                        $message->to($CaEmail);
                        $message->bcc('admin@punchcardllc.com');
                        $message->subject('Punchcard Account Administration - Credit Card Update Required');
                     });
            }
        }   
      }
    }          
  }

  public function employeesCurrentlyOnSite(Request $request){
        $project_id = $request->input('project_id');
        $client_id = $request->input('client_id');
        
        $validationError = array();

        if(empty($project_id)){
         $validationError['project_id'] = 'required';
        }
        if(empty($client_id)){
         $validationError['client_id'] = 'required';
        }
        if(count($validationError) > 0){
         return $this->failureResponse('Failed', $validationError,200);
        }

      $punchs = DB::table('checks') 
        ->join('users', 'users.id', '=', 'checks.user_id')
        ->join('clients', 'clients.id', '=', 'users.client_id')
        ->select('checks.*','users.first_name','users.last_name', 'users.uniq_id as userUniq', 'clients.name', 'clients.uniq_id as clientsUniq')
        ->where('checkOutDateTime','=',NULL)
        // ->where('clients.id','=',$client_id)
        ->where('users.deleted_at','=',NULL)
        ->where('project_id','=',$project_id)
        ->get();

        
        return $this->jsonSuccess('Success', $punchs);

    }

    public function companiesCurrentlyOnSite(Request $request){
        $project_id = $request->input('project_id');
        $client_id = $request->input('client_id');
        
        $validationError = array();

        if(empty($project_id)){
         $validationError['project_id'] = 'required';
        }
        if(empty($client_id)){
         $validationError['client_id'] = 'required';
        }
        if(count($validationError) > 0){
         return $this->failureResponse('Failed', $validationError,200);
        }

      $punchs = DB::table('clients') 
        ->join('users', 'clients.id', '=', 'users.client_id')
        ->join('checks', 'users.id', '=', 'checks.user_id')
        ->select(DB::raw('count(*) as user_count, clients.name'),'clients.uniq_id')
        ->where('checks.checkOutDateTime','=',NULL)
        ->where('checks.project_id','=',$project_id)
        // ->where('clients.id','=',$client_id)
        ->where('users.deleted_at','=',NULL)
        ->groupBy('clients.name','clients.uniq_id')
        ->get();

        return $this->jsonSuccess('Success', $punchs);
    }

}