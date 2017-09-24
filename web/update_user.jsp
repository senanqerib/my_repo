<%-- 
    Document   : update_user.jsp
    Created on : Sep 5, 2017, 4:54:42 PM
    Author     : Sanan Garibli
--%>


<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@ page import ="java.sql.*" %>
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
     <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <link rel="stylesheet" href="css/style_table.css">
            <title>User Update</title>
        </head>
            <body>
            </body>
    </html>
                    
                    
<%
  if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {

  response.sendRedirect("index.jsp");
  }
else  {
%>
<p align="right"> Welcome <%=session.getAttribute("userid")%>
<a href='success.jsp'>Home</a> 
&nbsp;&nbsp;
<a href="reg.jsp">Add new user</a>
&nbsp;&nbsp;
<a href="edit_user.jsp">Edit user</a>
&nbsp;&nbsp;
<a href='logout.jsp'>Log out</a>
</p>
<%  
    
    if (request.getParameterMap().containsKey("fname") && request.getParameterMap().containsKey("lname") && 
            request.getParameterMap().containsKey("uname") && request.getParameterMap().containsKey("email")
            && ((request.getParameter("pass").toString()!="") && request.getParameter("pass").toString()!= null ) )
{       
    try {
        String uname= request.getParameter("uname");
        String fname= request.getParameter("fname");
        String lname= request.getParameter("lname");
        String email= request.getParameter("email");
        String pass = request.getParameter("pass");
    
        //String username = session.getAttribute("userid").toString(); 
        String user_update_query = "update members  set uname=?, first_name=?, last_name=?, email=?, pass=password(?) where uname=? ";   

    
    String url = "";
    String driver = "";
    String username = "";
    String password = "";
    Properties    props = new Properties();
      
    
    props.load(new FileInputStream(getServletContext().getRealPath("/") + File.separator + "conf" + File.separator + "config.properties"));
    
    driver =    props.getProperty("driver").trim();
    url =       props.getProperty("url").trim();
    username =  props.getProperty("username").trim();
    password =  props.getProperty("password").trim();
    
    Class.forName(driver);
    Connection con =DriverManager.getConnection(url, username, password);
    
    
        PreparedStatement stmt=con.prepareStatement(user_update_query);
        stmt.setString(1, uname); 
        stmt.setString(2, fname);
        stmt.setString(3, lname);
        stmt.setString(4, email);
        stmt.setString(5, pass);
        stmt.setString(6, uname);

   
    try
        {         

        int i=stmt.executeUpdate();
        if (i>0)
        {
            out.println("user updated <br><br>");
            out.println("<a href='edit_user.jsp'>Back to user edit page </a>");
            //response.sendRedirect("edit_user.jsp");
        }
        else {
            out.println("Error: user not updated  <br><br>");
            out.println("<a href='edit_user.jsp'>Back to user edit page </a>");
        }
    }
        catch(Exception e)
        { 
            out.println(e);
        }
    
finally {
    try { stmt.close(); } catch (Exception e) { out.println(e); }
    try { con.close();  } catch (Exception e) { out.println(e); }
} 
    }
    catch (Exception e)
            {
            out.println("Connection failed:" +e.toString());
            }
}
    else  {
    out.println("Password is empty! Please, fill  password field <br><br>");
    out.println("<a href='edit_user.jsp'>Back to user edit page </a>");
    }
}
%>




