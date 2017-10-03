<%-- 
    Document   : index
    Created on : Sep 5, 2017, 4:11:49 PM
    Author     : Sanan Garibli
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <link rel="stylesheet" href="css/style_login.css">
        <title>Login Page</title>

    </head>
    <body>
        
     
        
<body>
  <link href='https://fonts.googleapis.com/css?family=Source+Sans+Pro' rel='stylesheet' type='text/css'>
<form method="post" action="login.jsp">
  <h4> Login Information </h4>
  <input name="uname" id="uname" class="name" type="text" placeholder="Enter Username" required/>
  <input name="pass" class="pw" type="password" placeholder="Enter Password" required/>
  
  <input class="button" type="submit" value="Log in"/>
            
</form>
  
<script type="text/javascript">
          document.getElementById("uname").focus();
</script>  
        
</body>
</html>
