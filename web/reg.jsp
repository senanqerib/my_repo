<%-- 
    Document   : reg
    Created on : Sep 5, 2017, 4:54:42 PM
    Author     : qeribli_s
--%>

<% 
    if (session.getAttribute("userid") != null) 
    { %> 
    <p align="right"> Welcome <%=session.getAttribute("userid")%> 

<a href='success.jsp'>Home</a> 
&nbsp;&nbsp;
<a href="reg.jsp">Add new user</a>
&nbsp;&nbsp;
<a href="edit_user.jsp">Edit user</a>
&nbsp;&nbsp;
<a href='logout.jsp'>Log out</a>
</p>
<% } %>
<%
if (session.getAttribute("userid") != null) {
    if ((session.getAttribute("userid").equals("admin"))) {        
        %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <link rel="stylesheet" href="css/style.css">
        <title>Registration</title>
    </head>
    <body>
        <form method="post" action="registration.jsp">
           
            	<input class="name" type="text" name="fname" value="" placeholder="First Name"/>
                <input class="name" type="text" name="lname" value="" placeholder="Last Name"/>
                <input  class="name" type="text" name="email" value="" placeholder="Email" />
                <input  class="name"  type="text" name="uname" value="" placeholder="User Name"/>
                <input  class="pw" type="password" name="pass" value="" placeholder="Password"/>
                        
                <input class="button" type="submit" value="Add user" />
        </form>
    </body>
</html>
<%
        
} 

else {

%>
You are not administrator<br/>
<a href="index.jsp">Please login as administrator user</a>
<%
}
}
else 
        {
            %>
            You are not logged in <br/>
            <a href="index.jsp">Please login as administrator user</a>
            <%
        }
%>


