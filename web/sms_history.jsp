<%-- 
    Document   : sms_history
    Created on : Sep 20, 2017, 10:26:47 AM
    Author     : Sanan Garibli
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Properties"%>
<%@ page import ="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <title>SMS History Page</title>
  <meta charset="UTF-8">
   <link rel="stylesheet" href="css/style_table.css">
   <jsp:include page="header.jsp" />
</head>
</html>



<%
    
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {        
        response.sendRedirect("index.jsp");    
    } else {


         String id = "%";
         String sms_text = "%";
         String phone = "%";
         String sent_date = "%";
         String sms_response = "%";
         
         
        if (request.getParameter("id") != null) {           id =                request.getParameter("id"); }
        if (request.getParameter("sms_text") != null) {     sms_text =          request.getParameter("sms_text"); }
        if (request.getParameter("phone") != null) {        phone =             request.getParameter("phone"); }
        if (request.getParameter("sent_date") != null) {    sent_date =         request.getParameter("sent_date"); }
        if (request.getParameter("sms_response") != null) { sms_response =      request.getParameter("sms_response"); }
        
    
 try { 
        
    String url = "";
    String driver = "";
    String username = "";
    String password = "";
    Properties  props = new Properties();
      
    
    props.load(new FileInputStream(getServletContext().getRealPath("/") + File.separator + "conf" + File.separator + "config.properties"));
    
    driver =    props.getProperty("driver").trim();
    url =       props.getProperty("url").trim();
    username =  props.getProperty("username").trim();
    password =  props.getProperty("password").trim();
    
    Class.forName(driver);
    Connection con =DriverManager.getConnection(url, username, password);
    
    String select_query =  "SELECT  CERT_ID,  PHONE, INSERT_DATE AS SENT_DATE, RESPONSE, SMS_TEXT  FROM SMS_HISTORY "
                         + " WHERE CERT_ID LIKE ? AND PHONE  LIKE ?  AND INSERT_DATE LIKE ? AND RESPONSE LIKE ? AND SMS_TEXT LIKE ?";


        PreparedStatement stmt = con.prepareStatement(select_query);
        stmt.setString(1, "%" + id + "%");
        stmt.setString(2, "%" + phone + "%");
        stmt.setString(3, "%" + sent_date + "%");
        stmt.setString(4, "%" + sms_response + "%");
        stmt.setString(5, "%" + sms_text + "%");

        ResultSet rs = stmt.executeQuery();
%>
 
    <FORM id="cert" name="certs" method="POST" ACTION="#" >
        <table class="responsive-table">
            <tr>
                <td><b> Certificate ID  </b> </td> 
                <td><b> Phone  </b> </td> 
                <td><b> Sent Date </b> </td> 
                <td><b> SMS Response  </b> </td>
                <td><b> SMS Text </b> </td>
            </tr> 
            
           <tr>
               
                

                <input type="submit" value="Filter" style="position: absolute; left: -9999px; width: 1px; height: 1px;" tabindex="-1" />
                <td> <input name="id" size="4" value="<%=id %>" /> </td> 
                <td> <input name="phone" size="12" value="<%=phone %>"/> </td> 
                <td> <input name="sent_date" size="12" value="<%=sent_date %>"/> </td> 
                <td> <input name="sms_response" size="12" value="<%=sms_response %>"/> </td> 
                <td> <input name="sms_text" size="36" value="<%=sms_text %>"/> </td>
                
                </b>
            </tr>
            
            <%
                       
    while (rs.next()) {


                %>

                <td> <%=rs.getString("CERT_ID")%>  </td>  
                <td> <%=rs.getString("PHONE")%>  </td> 
                <td> <%=rs.getString("SENT_DATE")%>  </td> 
                <td> <%=rs.getString("RESPONSE")%>  </td> 
                <td> <%=rs.getString("SMS_TEXT")%>  </td> 

            </tr>
                 
                 <% 
            

    }
    stmt.close();
    con.close();
}
catch (Exception e)
{
       String error=e.toString();
         %>
               <script type="text/javascript">
                   alert("Error: <%=error%>");
               </script>
        <%
}
 

    %>
   </table>
    </FORM>
<%


    }



%>
