<%-- 
    Document   : success
    Created on : Sep 5, 2017, 4:56:35 PM
    Author     : Sanan Garibli
--%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Properties"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Update Page</title>
</head>
</html>

<%@ page import ="java.sql.*" %>
<%
    
if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) 
{
    response.sendRedirect("index.jsp");
 } 
else {
%>
<jsp:include page="header.jsp" />
<%
if (request.getParameterMap().containsKey("id") && request.getParameterMap().containsKey("cn") && request.getParameterMap().containsKey("expiry_date") && request.getParameterMap().containsKey("ip"))
{

    
        String cert_id = request.getParameter("id"); 
        String cn = request.getParameter("cn");  
        String ip = request.getParameter("ip");  
        String expiry_date = request.getParameter("expiry_date"); 
        String server_name = request.getParameter("server_name"); 
        String description = request.getParameter("description");
        String alghoritm = request.getParameter("alghoritm"); 
        String bit_length = request.getParameter("bit_length"); 
        String type = request.getParameter("type"); 
        String phone = request.getParameter("phone"); 
        String server_owner = request.getParameter("server_owner"); 
  

    try
    {  
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
    
        //Statement st = con.createStatement();
        PreparedStatement stmt=con.prepareStatement("UPDATE CERTS set ID=?, CN=?, IP=?,EXPIRY_DATE=?, SERVER_NAME=?, DESCRIPTION=?, ALGORITHM=?, BIT_LENGTH=?,  TYPE=?, PHONE=?, SERVER_OWNER=?  where ID=?");
        stmt.setString(1, cert_id);
        stmt.setString(2, cn);
        stmt.setString(3, ip);
        stmt.setString(4, expiry_date);
        stmt.setString(5, server_name);
        stmt.setString(6, description);
        stmt.setString(7, alghoritm);
        stmt.setString(8, bit_length);
        stmt.setString(9, type);
        stmt.setString(10, phone);
        stmt.setString(11, server_owner);
        
        stmt.setString(12, cert_id);


        int i=stmt.executeUpdate();  
        if (i>0)
        {
         %>
            <script type="text/javascript">
                alert('Certificate Updated');
            </script>
        <%
        } 

        con.close();

        response.sendRedirect("certificate.jsp?action=edit&id="+cert_id);
    }
   
       catch(Exception e)
        {
        String error=e.toString();
         %>
               <script type="text/javascript">
                   alert("Update failed. SQL Error: <%=error%>");
               </script>
        <%
        }  

    }
 }



%>
