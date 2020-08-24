<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Amazon Parcel Delivery</title>
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
<body class="custom-body" style="margin: 0;">
	<div class="se-pre-con" id="se-pre-con"></div>


	<div class="container-fluid h-100" id="container-fluid">

		<div class="row h-100">

			<div class="col-md-12 search-panel">
				<div class="row justify-content-center"
					style="background-color: #7952b3">
					<h2 class="text-white"
						style="margin: 5px; font-family: 'Noto Serif', serif;"
						align="center">Hotfix Log Viewer</h2>
				</div>
				<div class="row justify-content-center">
				<form autocomplete="off" action="/SearchResult" method="post"
					style="margin-top: 10px; max-width: 700px;">

					<div class="form-row" style="margin-bottom: 5px; max-height: 300px">
					</div>

					<div class="form-row">
						<div class="col">
							<input type="text" class="form-control form-control-sm"
								name="ecpNo" placeholder="Hotfix Number"
								style="margin-bottom: 5px;">
						</div>
						<div class="col">
							<input type="text" class="form-control form-control-sm"
								name="caseOrCrNo" placeholder="Case/CR Number"
								style="margin-bottom: 5px;">

						</div>
					</div>
					<div class="form-row">
						<div class="col">
							<input type="text" class="form-control form-control-sm"
								name="latestHotfix" placeholder="Latest Hotfix Number"
								data-toggle="tooltip" data-placement="bottom"
								title="All the HF's contained by this HF will be displayed."
								style="margin-bottom: 5px;">
						</div>
						<div class="col">
							<input type="text" class="form-control form-control-sm"
								name="specificFunc" placeholder="Specific Function"
								style="margin-bottom: 5px;">
						</div>
					</div>


					<input type="text" placeholder="Description"
						class="form-control form-control-sm" name="description"
						style="margin-bottom: 5px;">

					<div class="form-row">
						<div class="col">
							<input type="text" class="form-control form-control-sm"
								name="requestor" placeholder="Requested By"
								style="margin-bottom: 5px;">
						</div>


						<div class="col">
							<input type="text" class="form-control form-control-sm"
								name="fixedBy" placeholder="Fixed By"
								style="margin-bottom: 5px;">
						</div>
					</div>

					<input type="text" class="form-control form-control-sm"
						name="filesModifiedInPerforce" placeholder="Files Modified"
						style="margin-bottom: 5px;"> <input type="text"
						class="form-control form-control-sm"
						name="filesReleasedToCustomer" placeholder="Files Released"
						style="margin-bottom: 5px;">





					<div class="row justify-content-center">
						<button type="submit" id="searchBtn" name="searchBtn"
							value="searchClicked" class="btn btn-outline-danger">
							<i class="fas fa-search"></i>
						</button>
					</div>
				</form>
				</div>



			</div>
		</div>


	</div>
	<div class="row">
		<div id="browserWarningWrapper" aria-live="polite" aria-atomic="true"
			style="position: relative; z-index: 9"
			class="d-flex justify-content-center align-items-center">
			<div id="browserWarning" class="toast" data-autohide="false"
				style="min-width: 300px; position: fixed; top: 50px; left: 50%; margin-left: -150px;"
				role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header">
					<strong class="mr-auto text-danger">Warning !</strong>
					<!-- <button type="button" class="ml-2 mb-1 close"
								data-dismiss="toast" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button> -->
				</div>

				<div id="browserWarningBody"
					class="toast-body bg-secondary text-white">
					Currently not supported in <em><b>Internet Explorer.</b></em><br>
					Try with <b>Google Chrome.</b>
				</div>
			</div>
		</div>
	</div>


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
		function checkFields(form) {
			var checks_radios = form.find(':checkbox, :radio'), inputs = form
					.find(':input').not(checks_radios).not(
							'[type="submit"],[type="button"],[type="reset"]');

			var checked = checks_radios.filter(':checked');
			var filled = inputs.filter(function() {
				return $.trim($(this).val()).length > 0;
			});

			if (checked.length + filled.length === 0) {
				return false;
			}

			return true;
		}

		$(function() {
			$('#searchForm1')
					.on(
							'submit',
							function(e) {
								e.preventDefault();
								var oneFilled = checkFields($(this));
								if (oneFilled) {
									document.getElementById("searchBtn").value = "searchClicked";
									document.getElementById("searchBtn")
											.submit();
								} else {
									alert('At least one field is required !');
								}
							});
		});

		function filterModules() {
			var input, filter, ul, li, a, i;
			input = document.getElementById("inputModule");
			filter = input.value.toUpperCase();
			div = document.getElementById("moduleList");
			a = div.getElementsByTagName("div");
			for (i = 0; i < a.length; i++) {
				txtValue = a[i].textContent || a[i].innerText;
				if (txtValue.toUpperCase().indexOf(filter) > -1) {
					a[i].style.display = "";
				} else {
					a[i].style.display = "none";
				}
			}
		}

		function filterVersions() {
			var input, filter, ul, li, a, i;
			input = document.getElementById("inputVersion");
			filter = input.value.toUpperCase();
			div = document.getElementById("versionList");
			a = div.getElementsByTagName("div");
			for (i = 0; i < a.length; i++) {
				txtValue = a[i].textContent || a[i].innerText;
				if (txtValue.toUpperCase().indexOf(filter) > -1) {
					a[i].style.display = "";
				} else {
					a[i].style.display = "none";
				}
			}
		}

		document.onreadystatechange = function() {
			if (document.readyState !== "complete") {
				document.querySelector("body").style.visibility = "hidden";
				document.querySelector("#se-pre-con").style.visibility = "visible";
			} else {
				document.querySelector("#se-pre-con").style.display = "none";
				document.querySelector("body").style.visibility = "visible";
			}
		};

		(function() {
			var googleChrome = {
				string : navigator.userAgent.match(/Chrome\/(\d+)/)

			};

			googleChrome.version = googleChrome.string ? parseInt(
					googleChrome.string[1], 10) : null;

			if (!googleChrome.string) {
				document.getElementById("container-fluid").style.display = "none";
				document.getElementById('browserWarningWrapper').style.display = "block";
				$('#browserWarning').toast('show');

			} else {
				document.getElementById('browserWarning').style.display = "none";
				$('#browserWarning').toast('hide');

			}
		})();

		function sortListDir(elementId) {
			var list, i, switching, b, shouldSwitch, dir, switchcount = 0;
			switching = true;
			div = document.getElementById(elementId);

			// Set the sorting direction to ascending:
			dir = "asc";
			// Make a loop that will continue until no switching has been done:
			while (switching) {
				// Start by saying: no switching is done:
				switching = false;
				b = div.getElementsByTagName("div")
				// Loop through all list-items:
				for (i = 0; i < (b.length - 1); i++) {
					// Start by saying there should be no switching:
					shouldSwitch = false;
					/* Check if the next item should switch place with the current item,
					based on the sorting direction (asc or desc): */
					if (dir == "asc") {
						if (b[i].innerHTML.toLowerCase() > b[i + 1].innerHTML
								.toLowerCase()) {
							/* If next item is alphabetically lower than current item,
							mark as a switch and break the loop: */
							shouldSwitch = true;
							break;
						}
					} else if (dir == "desc") {
						if (b[i].innerHTML.toLowerCase() < b[i + 1].innerHTML
								.toLowerCase()) {
							/* If next item is alphabetically higher than current item,
							mark as a switch and break the loop: */
							shouldSwitch = true;
							break;
						}
					}
				}
				if (shouldSwitch) {
					/* If a switch has been marked, make the switch
					and mark that a switch has been done: */
					b[i].parentNode.insertBefore(b[i + 1], b[i]);
					switching = true;
					// Each time a switch is done, increase switchcount by 1:
					switchcount++;
				} else {
					/* If no switching has been done AND the direction is "asc",
					set the direction to "desc" and run the while loop again. */
					if (switchcount == 0 && dir == "asc") {
						dir = "desc";
						switching = true;
					}
				}
			}
		}
	</script>
</body>
</html>
