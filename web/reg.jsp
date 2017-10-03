<%-- 
    Document   : reg
    Created on : Sep 5, 2017, 4:54:42 PM
    Author     : qeribli_s
--%>

<%
if (session.getAttribute("userid") != null) {
    int USER_TYPE = Integer.parseInt(session.getAttribute("USER_TYPE").toString());
    if ( USER_TYPE == 0) {        
        %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <link rel="stylesheet" href="css/style_add_user.css">
         <jsp:include page="header.jsp" />
        <title>Registration Page</title>
    </head>
    <body>
        <script type="text/javascript">
            function checkPass()
            {
                //Store the password field objects into variables ...
                var pass1 = document.getElementById('pass1');
                var pass2 = document.getElementById('pass2');
                //Store the Confimation Message Object ...
                var message = document.getElementById('confirmMessage');
                //Set the colors we will be using ...
                var goodColor = "#66cc66";
                var badColor = "#ff6666";
                //Compare the values in the password field 
                //and the confirmation field
                if(pass1.value === pass2.value){
                    //The passwords match. 
                    //Set the color to the good color and inform
                    //the user that they have entered the correct password 
                    pass2.style.backgroundColor = goodColor;
                    message.style.color = goodColor;
                    message.innerHTML = "Passwords Match!";
                    return true;
                }else{
                    //The passwords do not match.
                    //Set the color to the bad color and
                    //notify the user.
                    pass2.style.backgroundColor = badColor;
                    message.style.color = badColor;
                    message.innerHTML = "Passwords Do Not Match!";
                    return false;
                }
            }  
            </script>
        
        <form method="post" action="registration.jsp">
           
             <input class="name" type="text" name="fname" value="" placeholder="First Name" required />
                <input class="name" type="text" name="lname" value="" placeholder="Last Name" required/>
                <input  class="name" type="text" name="email" value="" placeholder="Email" required/>
                <input  class="name"  type="text" name="uname" value="" placeholder="User Name" required/>
                    <style>
                      select:invalid { color: gray; }
                    </style>
                <select name="user_type" id="user_type" required>
                  <option value="2" disabled selected> User Type</option>
                  <option value="0">Admin</option>
                  <option value="1" selected>Operator</option>
                  <option value="2">ReadOnly</option>
                </select>
                
                <input  class="pw" type="password" name="pass"  id = "pass1" value="" placeholder="Password" required/>
                <input  class="pw" type="password" name="pass2" id = "pass2" value="" placeholder="Retype Password" required/>
                 <span id="confirmMessage" ></span>       
                <input class="button" type="submit" value="Add user" onclick="return checkPass();"/>
        </form>
    </body>
</html>
<%
        
} 

else {

%>
 <script type="text/javascript">   
    if (confirm('You are not administrator. Would you like login as administrator?')) 
    {
    window.location.href='logout.jsp';
       } 
else {
    window.history.back();
    }
  </script>
         <%
}
}
else 
        {
            %>
               <script type="text/javascript">
                   alert("You are not logged in. Please login as administrator user");
                   window.location.href='logout.jsp';
               </script>

            <%
        }
%>


