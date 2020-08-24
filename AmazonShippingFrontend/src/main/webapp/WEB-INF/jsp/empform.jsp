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

        <h1>Add New Order</h1>  
       <form:form method="post" action="save">    
        <table >    
         <tr>    
          <td>Order ID : </td>   
          <td><form:input path="order_id" class="form-control"/></td>  
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
          <td><input type="submit" class="btn btn-warning btn-sm" value="Save" /></td>    
         </tr>    
        </table>    
       </form:form>        
</body>
</html>