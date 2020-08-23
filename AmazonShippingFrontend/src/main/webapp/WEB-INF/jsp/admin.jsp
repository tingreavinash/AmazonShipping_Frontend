<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<html>    
<head>    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">   
<title>Home Page</title>    
</head>    
<body>    
Welcome to admin page!  
<a href="logout">logout</a> <br><br>  
<security:authorize access="hasAuthority('ADMIN')">  
<p>Hello ADMIN</p>
</security:authorize>  
<security:csrfInput/>  
</body>    
</html> 