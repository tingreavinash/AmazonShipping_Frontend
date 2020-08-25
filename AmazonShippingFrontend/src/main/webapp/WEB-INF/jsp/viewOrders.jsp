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
<title>Orders Page</title>
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
<body style="margin: 10px">
	<div class="alert Box-header--blue  text-center" role="alert">
		Results found: <span class="badge badge-pill badge-secondary"></span>

	</div>
	<div class="alert Box-header text-center">
		<span style="font-size: 13px; color: white"
			class="badge badge-warning badge-mb">Search Query: </span><br>
			<a href="logout" class="btn btn-success btn-sm" style="margin-top:10px;">Logout</a>
			
	</div>
	<div class="list-group " id="hflist" style="margin-top: 10px;">
		<div class="row Box-hotfix-title">
			<div class="col col-sm-4 text-center ">
				<b>Order Number</b>
			</div>
			<div class="col col-sm-4 text-center">
				<b>Buyer Name</b>
			</div>
			<div class="col col-sm-4 text-center">
				<b>Tracking ID</b>
			</div>
		</div>

		<!-- For loop started -->
		<c:forEach var="order" items="${list}">

			<div id="ecp_image_${order.order_id}">
				<a class="list-group-item list-group-item-action hf-details-parent"
					data-toggle="collapse" href="#hfCollapse${order.order_id}"
					aria-expanded="false" aria-controls="hfCollapse${order.order_id}">
					<div class="row hf-list-top">
						<div class="col col-sm-4 ">

							<div class="row">
								<div class="col col-sm-10">
									<div id="ecpno_${order.order_id}">${order.order_id}</div>

								</div>
								<div class="col col-sm-2">
									<span class="copy_icon"
										onclick="copyToClipboard('ecpno_${order.order_id}', 'description_${order.order_id}')"><i
										class="fas fa-copy"></i></span>

								</div>
							</div>

						</div>
						<div class="col col-sm-4 hf-list-description">
							<div id="description_${order.order_id}">${order.buyer_name}</div>
						</div>

						<div class="col col-sm-4 hf-list-description">
							<div id="trackingid_${order.order_id}">${order.tracking_id}</div>
						</div>

					</div>

				</a>


				<div class="collapse multi-collapse hf-details-child"
					style="background-color: white" data-parent="#hflist"
					id="hfCollapse${order.order_id}">
					<div class="bd-callout bd-callout-warning">

						<div class="row justify-content-end">

							<button class="btn btn-warning btn-sm" style="margin-left: 10px;"
								onclick="saveImage('ecp_image_${order.order_id}', '${order.order_id}')">
								Save <i class="fas fa-download"></i>
							</button>
						</div>

						<!-- Row 1 -->
						<div class="row">
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Buyer
										Name</span><br> ${order.buyer_name}
								</div>

							</div>
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Buyer
										Email</span><br> ${order.buyer_email}

								</div>
							</div>
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Buyer
										Phone</span><br> ${order.buyer_phone_number}

								</div>

							</div>
						</div>
						<!-- Row 2 -->
						<div class="row">
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Order
										ID</span><br> ${order.order_id}
								</div>

							</div>
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Order
										Item ID</span><br> ${order.order_item_id}

								</div>
							</div>
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Purchase
										Date</span><br> ${order.purchase_date}

								</div>

							</div>
						</div>

						<!-- Row 3 -->
						<div class="row">
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Payment
										Date</span><br> ${order.payments_date}
								</div>

							</div>
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Reporting
										Date</span><br> ${order.reporting_date}

								</div>
							</div>
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Promise
										Date</span><br> ${order.promise_date}

								</div>

							</div>
						</div>

						<!-- Row 4 -->
						<div class="row">
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Days
										Past Promise</span><br> ${order.days_past_promise}
								</div>

							</div>
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">SKU</span><br>
									${order.sku}

								</div>
							</div>
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Product
										Name</span><br> ${order.product_name}

								</div>

							</div>
						</div>

						<!-- Row 5 -->
						<div class="row">
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Qty
										Purchased</span><br> ${order.quantity_purchased}
								</div>

							</div>
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Qty
										Shipped</span><br> ${order.quantity_shipped}

								</div>
							</div>
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Qty
										to Ship</span><br> ${order.quantity_to_ship}

								</div>

							</div>
						</div>

						<!-- Row 6 -->
						<div class="row">
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Ship
										service level</span><br> ${order.ship_service_level}
								</div>

							</div>
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Ship
										Service Name</span><br> ${order.ship_service_name}

								</div>
							</div>
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Recipient
										Name</span><br> ${order.recipient_name}

								</div>

							</div>
						</div>

						<!-- Row 7 -->
						<div class="row">
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Ship
										Address</span><br> ${order.ship_address_1}<br>${order.ship_address_2}<br>${order.ship_address_3}
								</div>

							</div>
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Ship
										City</span><br> ${order.ship_city}

								</div>
							</div>
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Ship
										State</span><br> ${order.ship_state}

								</div>

							</div>
						</div>

						<!-- Row 8 -->
						<div class="row">
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Ship
										Postal Code</span><br> ${order.ship_postal_code}
								</div>

							</div>
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Ship
										Country</span><br> ${order.ship_country}

								</div>
							</div>
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Payment
										Method</span><br> ${order.payment_method}

								</div>

							</div>
						</div>

						<!-- Row 9 -->
						<div class="row">
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Cod
										collective amount</span><br> ${order.cod_collectible_amount}
								</div>

							</div>
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Already
										Paid</span><br> ${order.already_paid}

								</div>
							</div>
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Payment
										Method Fee</span><br> ${order.payment_method_fee}

								</div>

							</div>
						</div>

						<!-- Row 10 -->
						<div class="row">
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Is
										business order</span><br> ${order.is_business_order}
								</div>

							</div>
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Purchase
										Order Number</span><br> ${order.purchase_order_number}

								</div>
							</div>
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Price
										Designation</span><br> ${order.price_designation}

								</div>

							</div>
						</div>

						<!-- Row 11 -->
						<div class="row">
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Is
										Prime</span><br> ${order.is_prime}
								</div>

							</div>
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Fulfilled
										by</span><br> ${order.fulfilled_by}

								</div>
							</div>
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Shipment
										Status</span><br> ${order.shipment_status}

								</div>

							</div>
						</div>

						<!-- Row 12 -->
						<div class="row">
							<div class="col">
								<div>
									<span class="badge badge-pill badge-secondary hf-detail-tag">Is
										sold by AB</span><br> ${order.is_sold_by_ab}
								</div>

							</div>

						</div>

						<!-- Row 13 -->
						<div class="row">

							<div class="col">
								<div>
									<span class="badge badge-pill badge-info hf-detail-tag">Tracking
										ID</span><br> ${order.tracking_id}
								</div>

							</div>

							<div class="col">
								<div>
									<span class="badge badge-pill badge-info hf-detail-tag">Courier
										Code</span><br> ${order.courier_code}
								</div>
							</div>
						</div>
						<!-- Row 14 -->
						<div class="row">

							<div class="col">
								<div>
									<span class="badge badge-pill badge-info hf-detail-tag">Last
										Modified By</span><br> ${order.record_created_by}
								</div>

							</div>

							<div class="col">
								<div>
									<span class="badge badge-pill badge-info hf-detail-tag">Last
										Modified On</span><br> ${order.record_last_modified}
								</div>
							</div>
						</div>


						<a href="editemp/${order.order_id}" class="btn btn-success btn-sm"
							id="updateBtn_${order.order_id}"> Update </a>



					</div>
				</div>


			</div>
		</c:forEach>


	</div>
	<br>
	<a href="empform" class="btn btn-success btn-sm"
		id="addEmpBtn_${order.order_id}"> Add Employee </a>
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
			document.getElementById('copyToastWrapper').style.display = "block";
			document.getElementById('copyToastBody').innerHTML = document
					.getElementById(ecpNo).innerHTML
					+ '<br>(Hotfix number and description)';

			$('#copyToast').toast('show');

		}
		function saveImage(elementId, ecpNumber) {

			domtoimage.toBlob(document.getElementById(elementId))
					.then(
							function(blob) {
								window.saveAs(blob, 'HF_Details_' + ecpNumber
										+ '.png');
							});

		}
		function emailHotfix(EcpNo, Description, CaseOrCrNo, CramerVersion,
				EcpFaulty, FileLocationInPerforce, FilesModifiedInPerforce,
				FilesReleasedToCustomer, FixedBy, LatestEcp, Module, Notes,
				PrereqForLatestEcp, releasedDate, requestDate, Requestor,
				RolledIntoVersion) {
			console.log(EcpNo + '\r\n' + Description + '\r\n' + CaseOrCrNo
					+ '\r\n' + CramerVersion + '\r\n' + EcpFaulty + '\r\n'
					+ FileLocationInPerforce + '\r\n' + FilesModifiedInPerforce
					+ '\r\n' + FilesReleasedToCustomer + '\r\n' + FixedBy
					+ '\r\n' + LatestEcp + '\r\n' + Module + '\r\n' + Notes
					+ '\r\n' + PrereqForLatestEcp + '\r\n' + releasedDate
					+ '\r\n' + requestDate + '\r\n' + Requestor + '\r\n'
					+ RolledIntoVersion);

			var subject = 'Hotfix Details - ' + EcpNo.replace("<br>", ", ");

			var body = 'Hotfix Number:\t\t' + EcpNo.replace("<br>", ", ");
			body += '\r\nDescription:\t\t' + Description.replace("<br>", ", ");
			body += '\r\nLatest Hotfix:\t\t' + LatestEcp.replace("<br>", ", ");
			body += '\r\nPrereq\'s for latest HF:\t'
					+ PrereqForLatestEcp.replace("<br>", ", ");
			body += '\r\nModule:\t\t' + Module.replace("<br>", ", ");
			body += '\r\nCase or CR No:\t\t' + CaseOrCrNo.replace("<br>", ", ");
			body += '\r\nVersion:\t\t' + CramerVersion.replace("<br>", ", ");
			body += '\r\nRolled into:\t\t'
					+ RolledIntoVersion.replace("<br>", ", ");
			body += '\r\nIs HF faulty?:\t\t' + EcpFaulty.replace("<br>", ", ");
			body += '\r\nFixed By:\t\t' + FixedBy.replace("<br>", ", ");
			body += '\r\nRequested By:\t\t' + Requestor.replace("<br>", ", ");
			body += '\r\nReleased Date:\t\t'
					+ releasedDate.replace("<br>", ", ");
			body += '\r\nRequested Date:\t' + requestDate.replace("<br>", ", ");
			body += '\r\nNotes:\t\t\t' + Notes.replace("<br>", ", ");
			body += '\r\nFiles Location:\t\t'
					+ FileLocationInPerforce.replace("<br>", ", ")
			body += '\r\nFiles Modified:\t\t'
					+ FilesModifiedInPerforce.replace("<br>", ", ");
			body += '\r\nFiles Released:\t\t'
					+ FilesReleasedToCustomer.replace("<br>", ", ");
			body += '\r\n\r\n====================================';
			body += '\r\nReference: http://avinasht01/';

			window.location.assign('mailto:?subject=' + subject + '&body='
					+ encodeURIComponent(body));
		}
	</script>

</body>
</html>