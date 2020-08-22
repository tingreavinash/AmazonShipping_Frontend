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

</head>
<body>

	<%
	request.getSession(false);
		String show_input = "";
		if ("searchClicked".equals(request.getParameter("searchBtn"))) {
	


			String ecpNo = request.getParameter("ecpNo").trim();

			
			if (!"".equals(ecpNo)) {


				String paramString = "?orderid=" + URLEncoder.encode(ecpNo, "UTF-8");

				String plainInput = "?ecpNo=" + ecpNo ;
		
				if(ecpNo!="") show_input=show_input.concat("<b><em>Hotfix No:</em></b> "+ecpNo+", ");

				ObjectMapper objectMapper = new ObjectMapper();
				HttpURLConnection con = null;
				try {
					
					URL url = new URL("http://localhost:7777/ShippingApplication/getOrderDetails" + paramString);
					con = (HttpURLConnection) url.openConnection();
					con.setRequestMethod("GET");
					con.setRequestProperty("Content-Type", "application/json");
					
					con.setConnectTimeout(5000);
					con.setReadTimeout(5000);

					int status = con.getResponseCode();
					if (status > 299) {
						Reader streamReader = null;

						BufferedReader in = new BufferedReader(streamReader);
						String inputLine;
						StringBuffer content = new StringBuffer();
						while ((inputLine = in.readLine()) != null) {
							content.append(inputLine);
						}
						in.close();
						System.out.println("Below error occured: \n" + content.toString());

					} else {
						BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
						String inputLine;
						StringBuffer content = new StringBuffer();
						while ((inputLine = in.readLine()) != null) {
							content.append(inputLine);
						}
						in.close();
						String response1 = content.toString();

						Order respObject = objectMapper.readValue(response1,
								Order.class);
						if (respObject != null) {
	%>
	<div class="alert Box-header--blue  text-center" role="alert">
		Results found:
			<span class="badge badge-pill badge-secondary"><%=%></span>
	
	</div>
	<div class="alert Box-header text-center">
	<span style="font-size: 13px;color:white" class="badge badge-warning badge-mb">Search Query: </span> <%=show_input %>
	</div>
	<div class="list-group " id="hflist" style="margin-top:10px;">
		<div class="row Box-hotfix-title">
		<div class="col col-sm-3 text-center "><b>HOTFIX NUMBER</b></div>
		<div class="col col-sm-9 text-center"><b>DESCRIPTION</b></div>
		</div>
		<%
			for (int count = 0; count < 1; count++) {
				Order ecp = new Order();
				ecp = respObject;
		%>
		<div id="ecp_image_<%=ecp.getOrder_id()%>">
		<a class="list-group-item list-group-item-action hf-details-parent"
			data-toggle="collapse" href="#hfCollapse<%=ecp.getOrder_id()%>"
			aria-expanded="false" aria-controls="hfCollapse<%=ecp.getOrder_id()%>">
			<div class="row hf-list-top">
				<div class="col col-sm-3 ">
					
					<div class="row">
					<div class="col col-sm-10">
					<div id="ecpno_<%=ecp.getOrder_id()%>"><%=ecp.getOrder_id()%>
						</div>
					
					</div>
					<div class="col col-sm-2">
					<span class="copy_icon" 
					onclick="copyToClipboard('ecpno_<%=ecp.getOrder_id()%>', 'description_<%=ecp.getOrder_id()%>')"><i class="fas fa-copy"></i></span>
					
					</div>
					</div>




				</div>
				<div class="col col-sm-9 hf-list-description">
					<div id="description_<%=ecp.getOrder_id()%>"><%=ecp.getOrder_item_id()%></div>
				</div>
			</div>

		</a>


		<div class="collapse multi-collapse hf-details-child" style="background-color: white"
			data-parent="#hflist" id="hfCollapse<%=ecp.getOrder_id()%>">
				<div class="bd-callout bd-callout-warning">
					
					<div class="row justify-content-end">
					
					<button class="btn btn-warning btn-sm" style="margin-left: 10px;" onclick="saveImage('ecp_image_<%=ecp.getOrder_id()%>', '<%=ecp.getOrder_id()%>')">
					Save <i class="fas fa-download"></i>
					</button>
					</div>
					
					<!-- Row 1 -->
					<div class="row">
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Buyer Email</span><br>
								<textarea class="form-control" aria-label="With textarea"
									disabled><%=ecp.getBuyer_email()%>
                        </textarea>
							</div>

						</div>
						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Buyer Email</span><br>
								<%=ecp.getBuyer_name()%>
							</div>
						</div>



						<div class="col">
							<div>
								<span class="badge badge-pill badge-secondary hf-detail-tag">Buyer Phone</span><br>
								<%=ecp.getBuyer_phone_number()%>
							</div>

						</div>
					</div>


					<!-- Row 7 -->
				</div></div>


			</div>

			<%
				}
			%>
		</div>

		<%
			} else {
								System.out.println("No records found!");
		%>
		<div class="alert alert-warning" role="alert">
			<h4 class="alert-heading">Oops !</h4>
			<p>No matching records found.</p>
			<hr>
			<p class="mb-0">Try again with improved criteria.</p>
		</div>
		<%
			}

						}

					} catch (ConnectException ex) {
						System.out.println("Server Down.\n" + ex.getMessage());
						
		%>
		<div class="alert alert-warning" role="alert">
			<h4 class="alert-heading">Oops !</h4>
			<p>
				Operation failed due to any of below reasons:<br> 
				1. Server is down.<br>
				2. Connection timed out. <br>
			</p>
			<hr>
			<p class="mb-0">Try again with improved criteria.</p>
		</div>
		<%
			}catch(Exception ex){
				System.out.println("Exception: "+ex.getMessage());
				%>
				<div class="alert alert-warning" role="alert">
					<h4 class="alert-heading">Oops !</h4>
					<p>
						Operation failed due to any of below reasons:<br> 
						1. Server is down.<br>
						2. Connection timed out. <br>
					</p>
					<hr>
					<p class="mb-0">Try again with improved criteria.</p>
				</div>
				<%

			}finally {
						con.disconnect();
						System.out.println("Connection closed.");
					}
				} else {
		%>
		<div class="alert alert-warning" role="alert">
			<h4 class="alert-heading">Oops !</h4>
			<p>
				Operation failed due to any of below reasons:<br> 1. No input
				is provided.<br>
			</p>
			<hr>
			<p class="mb-0">Try again with improved criteria.</p>
		</div>
		<%
			System.out.println("All fields are empty.");
				}

			}
		%>
	</div>
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