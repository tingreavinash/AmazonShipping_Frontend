<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Edit Order</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/index.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/fontawesome-free-5.13.0-web/css/all.css">

<link
	href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@700&display=swap"
	rel="stylesheet">
<link rel="icon" href="../image/favicon3.png" type="image/gif"
	sizes="64x64">

<style>
html, body {
	height: 100%;
}
</style>



</head>
<body>

	<div class="container-fluid h-100" id="container-fluid">

		<div class="row h-100">

			<div class="col-md-12 search-panel">
				<div class="row justify-content-center"
					style="background-color: #7952b3">
					<h3 class="text-white"
						style="margin: 5px; font-family: 'Noto Serif', serif;"
						align="center">Edit Order Details</h3>
				</div>
				<div class="row justify-content-center">

					<form:form method="post" action="/editsave">

<form:hidden path="order_id" />                               
<form:hidden path="purchase_date" />
<form:hidden path="payments_date" />
<form:hidden path="reporting_date" />
<form:hidden path="promise_date" />
<form:hidden path="days_past_promise" />
<form:hidden path="sku" />
<form:hidden path="product_name" />
<form:hidden path="quantity_purchased" />
<form:hidden path="quantity_shipped" />
<form:hidden path="quantity_to_ship" />
<form:hidden path="ship_service_level" />
<form:hidden path="ship_service_name" />
<form:hidden path="ship_address_1" />
<form:hidden path="ship_address_2" />
<form:hidden path="ship_address_3" />
<form:hidden path="ship_city" />
<form:hidden path="ship_state" />
<form:hidden path="ship_postal_code" />
<form:hidden path="ship_country" />
<form:hidden path="already_paid" />
<form:hidden path="payment_method_fee" />
<form:hidden path="is_business_order" />
<form:hidden path="purchase_order_number" />
<form:hidden path="price_designation" />
<form:hidden path="is_prime" />
<form:hidden path="fulfilled_by" />
<form:hidden path="shipment_status" />
<form:hidden path="is_sold_by_ab" />
<form:hidden path="record_created_by" />
<form:hidden path="record_last_modified" />


						<div class="form-row">
							<div class="col">
								<span class="badge badge-pill badge-success">${order_id}</span>
							</div>

						</div>
						<div class="form-row">
							
						</div>
						<div class="form-row">
							<div class="col">
								<form:input path="tracking_id" placeholder="Tracking ID"
									cssStyle="margin-bottom: 5px;"
									cssClass="form-control form-control-sm" />

							</div>
						</div>
						<div class="form-row">
							<label for="order_cancelled">Mark as cancelled</label>
							<form:checkbox path="order_cancelled" class="form-control"
								value="true" />

						</div>
						<div class="form-row">
							<div class="col">
								<form:input path="buyer_email" placeholder="Buyer Email"
									cssStyle="margin-bottom: 5px;"
									cssClass="form-control form-control-sm" readonly="true" />

							</div>
							<div class="col">
								<form:input path="buyer_name" placeholder="Buyer Name"
									cssStyle="margin-bottom: 5px;"
									cssClass="form-control form-control-sm" />
							</div>
						</div>


						<form:input path="buyer_phone_number" placeholder="Buyer Phone"
							cssStyle="margin-bottom: 5px;"
							cssClass="form-control form-control-sm" />

						<div class="form-row">
							<div class="col">
								<form:input path="recipient_name" placeholder="Recipient Name"
									cssStyle="margin-bottom: 5px;"
									cssClass="form-control form-control-sm" />
							</div>


						</div>


						<div class="row justify-content-center">
							<input type="submit" class="btn btn-outline-danger"
								value="Edit Save" />
						</div>
					</form:form>
				</div>



			</div>
		</div>


	</div>

	<!--  -->
	<%--         <h1>Edit Order</h1>  
       <form:form method="post" action="/editsave">    
        <table >    
         <tr>    
          <td>Order ID : </td>   
          <td><form:input path="order_id" class="form-control" /></td>  
         </tr>    
         
         <tr>    
          <td>Buyer Email : </td>   
          <td><form:input path="buyer_email" class="form-control" /></td>  
         </tr>    
         <tr>    
          <td>Buyer Name :</td>    
          <td><form:input path="buyer_name" class="form-control" /></td>  
         </tr>   
         <tr>    
          <td>Buyer Phone :</td>    
          <td><form:input path="buyer_phone_number" class="form-control" /></td>  
         </tr>   
         <tr>    
          <td> </td>    
          <td><input type="submit" class="btn btn-warning btn-sm" value="Edit Save" /></td>    
         </tr>    
        </table>    
       </form:form> --%>
</body>
</html>