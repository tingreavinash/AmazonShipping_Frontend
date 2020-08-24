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
<title>Edit Employee</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/index.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/fontawesome-free-5.13.0-web/css/all.css">

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

  
        <h1>Edit Employee</h1>  
       <form:form method="post" action="/editsave">    
        <table >    
        <tr>  
          <td>Id : </td>   
         <td><form:input path="id" class="form-control"/></td>  
         </tr>   
         <tr>    
          <td>Name : </td>   
          <td><form:input path="name" class="form-control" />
          </td>  
         </tr>    
         <tr>    
          <td>Salary :</td>    
          <td><form:input path="salary" class="form-control"/></td>  
         </tr>   
         <tr>    
          <td>Designation :</td>    
          <td><form:input path="designation" class="form-control"/></td>  
         </tr>   
           
         <tr>    
          <td> </td>    
          <td><input type="submit" class="btn btn-warning btn-sm" value="Edit Save" /></td>    
         </tr>    
        </table>    
       </form:form>    
</body>
</html>