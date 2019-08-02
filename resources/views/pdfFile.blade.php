<!DOCTYPE html>

<html>

<head>

	<title>Load PDF</title>

	<style type="text/css">

		table{

			width: 100%;

			

		}

		
	</style>

</head>

<body>



<h2>Transaction History</h2>

<table>

	<tr>

		<th>Plan</th>
		<th>Total Unique Punches</th>
		<th>Cost Per Punch</th>
		<th>Amount</th>
		<th>Transaction Date</th>
		<th>Billing Cycle</th>

	</tr>
	@foreach ($txn_history as $key => $value)

	<tr>

		<td>{{ $value->version }}</td>

		<td>{{ $value->total_punch }}</td>
		<td>{{ $value->per_punch_cost }}</td>
		<td>{{ $value->txn_amount }}</td>
		<td>{{ $value->create_time_row }}</td>
		<td>{{ $value->billing_start_date }} through {{ $value->billing_end_date }}</td>

	</tr>

	@endforeach

</table>



</body>

</html>