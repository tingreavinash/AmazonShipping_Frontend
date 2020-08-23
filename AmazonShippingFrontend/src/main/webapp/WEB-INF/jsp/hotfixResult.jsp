<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    

<%@page import="com.avinash.amazonshipping.model.Order"%>
<%@page import="java.net.ConnectException"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.Base64"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Date"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.Reader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">


<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Search Result</title>
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" type="text/css" href="css/index.css">
<link rel="stylesheet" href="fontawesome-free-5.13.0-web/css/all.css">

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
	<div class="alert Box-header--blue  text-center" role="alert">
		Results found:
			<span class="badge badge-pill badge-secondary"></span>
	
	</div>
	<div class="alert Box-header text-center">
	<span style="font-size: 13px;color:white" class="badge badge-warning badge-mb">Search Query: </span>
	</div>
	<div class="list-group " id="hflist" style="margin-top:10px;">
		<div class="row Box-hotfix-title">
		<div class="col col-sm-3 text-center "><b>HOTFIX NUMBER</b></div>
		<div class="col col-sm-9 text-center"><b>DESCRIPTION</b></div>
		</div>
		
		<!-- For loop started -->
		<c:forEach var="emp" items="${list}">
		
		<div id="ecp_image_${emp.id}">
		<a class="list-group-item list-group-item-action hf-details-parent"
			data-toggle="collapse" href="#hfCollapse${emp.id}"
			aria-expanded="false" aria-controls="hfCollapse${emp.id}">
			<div class="row hf-list-top">
				<div class="col col-sm-4 ">
					
					<div class="row">
					<div class="col col-sm-10">
					<div id="ecpno_${emp.id}">${emp.id}
						</div>
					
					</div>
					<div class="col col-sm-2">
					<span class="copy_icon" 
					onclick="copyToClipboard('ecpno_${emp.id}', 'description_${emp.id}')"><i class="fas fa-copy"></i></span>
					
					</div>
					</div>




				</div>
				<div class="col col-sm-8 hf-list-description">
					<div id="description_${emp.id}">${emp.name}</div>
				</div>
			</div>

		</a>


		<div class="collapse multi-collapse hf-details-child" style="background-color: white"
			data-parent="#hflist" id="hfCollapse${emp.id}">
				<div class="bd-callout bd-callout-warning">
					
					<div class="row justify-content-end">
					
					<button class="btn btn-warning btn-sm" style="margin-left: 10px;" onclick="saveImage('ecp_image_${emp.id}', '${emp.id}')">
					Save <i class="fas fa-download"></i>
					</button>
					</div>
					
					<!-- Row 1 -->
					<div class="row">
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Buyer Email</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="${emp.name}"
								style="margin-top: 3px" disabled>
							</div>

						</div>
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Buyer Name</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="${emp.salary}"
								style="margin-top: 3px" disabled>
								
							</div>
						</div>
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Buyer Phone</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="${emp.designation}"
								style="margin-top: 3px" disabled>
								
							</div>

						</div>
					</div>
					<!-- Row 2 -->
					<%-- <div class="row">
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Order ID</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=ecp.getOrder_id()%>"
								style="margin-top: 3px" disabled>
							</div>

						</div>
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Order Item ID</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=ecp.getOrder_item_id()%>"
								style="margin-top: 3px" disabled>
								
							</div>
						</div>
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Purchase Date</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=ecp.getPurchase_date()%>"
								style="margin-top: 3px" disabled>
								
							</div>

						</div>
					</div>

					<!-- Row 3 -->
					<div class="row">
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Payment Date</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=ecp.getPayments_date()%>"
								style="margin-top: 3px" disabled>
							</div>

						</div>
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Reporting Date</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=ecp.getReporting_date()%>"
								style="margin-top: 3px" disabled>
								
							</div>
						</div>
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Promise Date</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=ecp.getPromise_date()%>"
								style="margin-top: 3px" disabled>
								
							</div>

						</div>
					</div>

					<!-- Row 4 -->
					<div class="row">
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Days Past Promise</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=ecp.getDays_past_promise()%>"
								style="margin-top: 3px" disabled>
							</div>

						</div>
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">SKU</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=ecp.getSku()%>"
								style="margin-top: 3px" disabled>
								
							</div>
						</div>
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Product Name</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=ecp.getProduct_name()%>"
								style="margin-top: 3px" disabled>
								
							</div>

						</div>
					</div>
					
					<!-- Row 5 -->
					<div class="row">
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Qty Purchased</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=ecp.getQuantity_purchased()%>"
								style="margin-top: 3px" disabled>
							</div>

						</div>
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Qty Shipped</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=ecp.getQuantity_shipped() %>"
								style="margin-top: 3px" disabled>
								
							</div>
						</div>
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Qty to Ship</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=ecp.getQuantity_to_ship()%>"
								style="margin-top: 3px" disabled>
								
							</div>

						</div>
					</div>
					
					<!-- Row 6 -->
					<div class="row">
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Ship service level</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=ecp.getShip_service_level()%>"
								style="margin-top: 3px" disabled>
							</div>

						</div>
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Ship Service Name</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=ecp.getShip_service_name()%>"
								style="margin-top: 3px" disabled>
								
							</div>
						</div>
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Recipient Name</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=ecp.getRecipient_name()%>"
								style="margin-top: 3px" disabled>
								
							</div>

						</div>
					</div>
					
					<!-- Row 7 -->
					<div class="row">
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Ship Address</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" 
								value="<%=ecp.getShip_address_1()%><%=ecp.getShip_address_2() %><%=ecp.getShip_address_3() %>"
								style="margin-top: 3px" disabled>
							</div>

						</div>
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Ship City</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=ecp.getShip_city()%>"
								style="margin-top: 3px" disabled>
								
							</div>
						</div>
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Ship State</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=ecp.getShip_state()%>"
								style="margin-top: 3px" disabled>
								
							</div>

						</div>
					</div>
					
					<!-- Row 8 -->
					<div class="row">
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Ship Postal Code</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" 
								value="<%=ecp.getShip_postal_code()%>"
								style="margin-top: 3px" disabled>
							</div>

						</div>
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Ship Country</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=ecp.getShip_country()%>"
								style="margin-top: 3px" disabled>
								
							</div>
						</div>
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Payment Method</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=ecp.getPayment_method()%>"
								style="margin-top: 3px" disabled>
								
							</div>

						</div>
					</div>
					
					<!-- Row 9 -->
					<div class="row">
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Cod collective amount</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" 
								value="<%=ecp.getCod_collectible_amount()%>"
								style="margin-top: 3px" disabled>
							</div>

						</div>
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Already Paid</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=ecp.getAlready_paid()%>"
								style="margin-top: 3px" disabled>
								
							</div>
						</div>
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Payment Method Fee</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=ecp.getPayment_method_fee()%>"
								style="margin-top: 3px" disabled>
								
							</div>

						</div>
					</div>
					
					<!-- Row 10 -->
					<div class="row">
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Is business order</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" 
								value="<%=ecp.getIs_business_order()%>"
								style="margin-top: 3px" disabled>
							</div>

						</div>
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Purchase Order Number</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=ecp.getPurchase_order_number()%>"
								style="margin-top: 3px" disabled>
								
							</div>
						</div>
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Price Designation</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=ecp.getPrice_designation()%>"
								style="margin-top: 3px" disabled>
								
							</div>

						</div>
					</div>
					
					<!-- Row 11 -->
					<div class="row">
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Is Prime</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" 
								value="<%=ecp.getIs_prime()%>"
								style="margin-top: 3px" disabled>
							</div>

						</div>
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Fulfilled by</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=ecp.getFulfilled_by()%>"
								style="margin-top: 3px" disabled>
								
							</div>
						</div>
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Shipment Status</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=ecp.getShipment_status()%>"
								style="margin-top: 3px" disabled>
								
							</div>

						</div>
					</div>
					
					<!-- Row 12 -->
					<div class="row">
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Is sold by AB</span><br>
								<input type="text" class="form-control" id="exampleFormControlInput1" 
								value="<%=ecp.getIs_sold_by_ab()%>"
								style="margin-top: 3px" disabled>
							</div>

						</div>
						
					</div> --%>

					<a href="editemp/${emp.id}" class="btn btn-success btn-sm" id="updateBtn_${emp.id}">
					Update
					</a>
					
					
					
				</div></div>


			</div>
			</c:forEach>  
			
		</div>
		<!-- <div class="alert alert-warning" role="alert">
			<h4 class="alert-heading">Oops !</h4>
			<p>No matching records found.</p>
			<hr>
			<p class="mb-0">Try again with improved criteria.</p>
		</div> -->
		<!-- <div class="alert alert-warning" role="alert">
			<h4 class="alert-heading">Oops !</h4>
			<p>
				Operation failed due to any of below reasons:<br> 
				1. Server is down.<br>
				2. Connection timed out. <br>
			</p>
			<hr>
			<p class="mb-0">Try again with improved criteria.</p>
		</div> -->
				<!-- <div class="alert alert-warning" role="alert">
					<h4 class="alert-heading">Oops !</h4>
					<p>
						Operation failed due to any of below reasons:<br> 
						1. Server is down.<br>
						2. Connection timed out. <br>
					</p>
					<hr>
					<p class="mb-0">Try again with improved criteria.</p>
				</div> -->
		<!-- <div class="alert alert-warning" role="alert">
			<h4 class="alert-heading">Oops !</h4>
			<p>
				Operation failed due to any of below reasons:<br> 1. No input
				is provided.<br>
			</p>
			<hr>
			<p class="mb-0">Try again with improved criteria.</p>
		</div> -->
	
			<script type="text/javascript" src="js/jquery-3.5.1.slim.min.js"></script>
	<script type="text/javascript" src="js/popper.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script src="js/dom-to-image.js"></script>
	<script src="js/Filesaver.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$('#copyToast').toast('hide');
		});
	</script>
	<script type="text/javascript">
		$(function() {
			$('[data-toggle="tooltip"]').tooltip()
		})
	</script>
	
	<script type="text/javascript">
		function copyToClipboard(ecpNo, description) {

			const myTextarea = document.createElement('textarea');

			var copyString = 'HF Number:\t\t'
					+ document.getElementById(ecpNo).innerHTML
					+ '\r\nDescription:\t'
					+ document.getElementById(description).innerHTML;

			myTextarea.innerHTML = copyString;

			document.body.appendChild(myTextarea);

			myTextarea.select();

			document.execCommand('copy');

			document.body.removeChild(myTextarea);
			document.getElementById('copyToastWrapper').style.display="block";
			document.getElementById('copyToastBody').innerHTML =document.getElementById(ecpNo).innerHTML+'<br>(Hotfix number and description)';
			
			$('#copyToast').toast('show');


		}
		function saveImage(elementId,ecpNumber) {

			domtoimage.toBlob(document.getElementById(elementId))
		    .then(function (blob) {
		        window.saveAs(blob, 'HF_Details_'+ecpNumber+'.png');
		    });

		}
		function emailHotfix(EcpNo, Description, CaseOrCrNo, CramerVersion, EcpFaulty, FileLocationInPerforce, 
				FilesModifiedInPerforce, FilesReleasedToCustomer, FixedBy, LatestEcp,
				Module, Notes, PrereqForLatestEcp, releasedDate, requestDate,
				Requestor, RolledIntoVersion){
			console.log(EcpNo+'\r\n'+Description+'\r\n'+ CaseOrCrNo+'\r\n'+ CramerVersion+'\r\n'+ EcpFaulty+'\r\n'+ FileLocationInPerforce+'\r\n'+ 
					FilesModifiedInPerforce+'\r\n'+FilesReleasedToCustomer+'\r\n'+FixedBy+'\r\n'+ LatestEcp+'\r\n'+
					Module+'\r\n'+ Notes+'\r\n'+ PrereqForLatestEcp+'\r\n'+ releasedDate+'\r\n'+ requestDate+'\r\n'+
					Requestor+'\r\n'+ RolledIntoVersion);

			var subject='Hotfix Details - '+EcpNo.replace("<br>",", ");
			
			var body='Hotfix Number:\t\t'+EcpNo.replace("<br>",", ");
			body+='\r\nDescription:\t\t'+Description.replace("<br>",", ");
			body+='\r\nLatest Hotfix:\t\t'+LatestEcp.replace("<br>",", ");
			body+='\r\nPrereq\'s for latest HF:\t'+PrereqForLatestEcp.replace("<br>",", ");
			body+='\r\nModule:\t\t'+Module.replace("<br>",", ");
			body+='\r\nCase or CR No:\t\t'+CaseOrCrNo.replace("<br>",", ");
			body+='\r\nVersion:\t\t'+CramerVersion.replace("<br>",", ");
			body+='\r\nRolled into:\t\t'+RolledIntoVersion.replace("<br>",", ");
			body+='\r\nIs HF faulty?:\t\t'+EcpFaulty.replace("<br>",", ");
			body+='\r\nFixed By:\t\t'+FixedBy.replace("<br>",", ");
			body+='\r\nRequested By:\t\t'+Requestor.replace("<br>",", ");
			body+='\r\nReleased Date:\t\t'+releasedDate.replace("<br>",", ");
			body+='\r\nRequested Date:\t'+requestDate.replace("<br>",", ");
			body+='\r\nNotes:\t\t\t'+Notes.replace("<br>",", ");
			body+='\r\nFiles Location:\t\t'+FileLocationInPerforce.replace("<br>",", ")	
			body+='\r\nFiles Modified:\t\t'+FilesModifiedInPerforce.replace("<br>",", ");
			body+='\r\nFiles Released:\t\t'+FilesReleasedToCustomer.replace("<br>",", ");
			body+='\r\n\r\n====================================';
			body+='\r\nReference: http://avinasht01/';

			
			window.location.assign('mailto:?subject='+subject+'&body='+encodeURIComponent(body));
			}
		
	</script>
	
</body>
</html>