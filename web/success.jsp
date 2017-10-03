<%-- 
    Document   : success
    Created on : Sep 5, 2017, 4:56:35 PM
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
  
  <title>Home Page</title>
  <link rel="stylesheet" href="css/style_table.css">
  <jsp:include page="header.jsp" />
</head>



<%!
public  long Convert_to_longint(String startDateString)
{
Date return_date;
DateFormat df = new SimpleDateFormat("dd/MM/yyyy"); 
Date startDate;
try {
    startDate = df.parse(startDateString);
    return_date= startDate;
} catch (ParseException e) {
    System.out.println("Error ocurred when converted to long: " +e.toString());
    return_date = null;
}
return return_date.getTime() + 86400000;
}

%>

<%!
 public  long ToDay() 
{

Date startDate =  new Date();
long date_long;

try {
    date_long=startDate.getTime();
} 
catch (Exception e) 
{
    e.printStackTrace();
    date_long = 0;
}
return date_long;
 
}
%>

<%
    
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {        
        response.sendRedirect("index.jsp");    
    } else {
        
       int USER_TYPE = Integer.parseInt(session.getAttribute("USER_TYPE").toString());

%>


<%
         String id = "";
         String cn = "";
         String expiry_date = "";
         String server_name = "";
         String server_ip = "";
         String server_owner = "";
         String algorithm = "";
         String bit_length = "";
         String type = "";
         String phone = "";
         String description = "";
         boolean expired;
         boolean expiring;
         
         
        if (request.getParameter("id") != null) {           id =                        request.getParameter("id"); }
        if (request.getParameter("cn") != null) {           cn =                        request.getParameter("cn"); }
        if (request.getParameter("expiry_date") != null) {  expiry_date =               request.getParameter("expiry_date"); }
        if (request.getParameter("server_name") != null) {  server_name =               request.getParameter("server_name"); }
        if (request.getParameter("server_ip") != null) {    server_ip =                 request.getParameter("server_ip"); }
        if (request.getParameter("server_owner") != null) { server_owner =              request.getParameter("server_owner"); }
        if (request.getParameter("algorithm") != null) {    algorithm =                 request.getParameter("algorithm"); }
        if (request.getParameter("bit_length") != null) {   bit_length =                request.getParameter("bit_length"); }
        if (request.getParameter("type") != null) {         type =                      request.getParameter("type"); }
        if (request.getParameter("phone") != null) {        phone =                     request.getParameter("phone"); }
        if (request.getParameter("description") != null) {  description =               request.getParameter("description"); }
        
    
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
    
    String select_query =  "SELECT  ID,  CN,  EXPIRY_DATE,  SERVER_NAME,  IP,  DESCRIPTION,  ALGORITHM,  BIT_LENGTH,  TYPE,  "
            + "NOTIFY,  PHONE,  NOTIFIED_COUNT,  SERVER_OWNER "
            + "FROM CERTS "
            + "WHERE ID LIKE ? AND CN LIKE ? AND EXPIRY_DATE LIKE ? AND SERVER_NAME LIKE ? AND IP LIKE ? AND DESCRIPTION LIKE ? AND ALGORITHM LIKE ? AND BIT_LENGTH LIKE ? AND "
            + "TYPE LIKE ? AND PHONE LIKE ? AND SERVER_OWNER LIKE ?";
 
     expiring = request.getParameter("expiring" ) != null;
     expired  = request.getParameter("expired"  ) != null;
     
     if (expiring && expired)
    {
    
        select_query = select_query +" AND (SUBDATE(STR_TO_DATE(EXPIRY_DATE,'%d/%m/%Y'),31) <= NOW() OR SUBDATE(STR_TO_DATE(EXPIRY_DATE,'%d/%m/%Y'),0) < NOW()) ORDER BY STR_TO_DATE(EXPIRY_DATE,'%d/%m/%Y') ";
    }
     else if (expiring)
     {
        select_query = select_query +" AND SUBDATE(STR_TO_DATE(EXPIRY_DATE,'%d/%m/%Y'),31) <= NOW() AND  SUBDATE(STR_TO_DATE(EXPIRY_DATE,'%d/%m/%Y'),0) > NOW()  ORDER BY STR_TO_DATE(EXPIRY_DATE,'%d/%m/%Y') ";
     }
     else if (expired)
     {
        select_query = select_query +" AND  SUBDATE(STR_TO_DATE(EXPIRY_DATE,'%d/%m/%Y'),0) < NOW()  ORDER BY STR_TO_DATE(EXPIRY_DATE,'%d/%m/%Y') ";
  
     }

        PreparedStatement stmt = con.prepareStatement(select_query);
        stmt.setString(1, "%" + id + "%");
        stmt.setString(2, "%" + cn + "%");
        stmt.setString(3, "%" + expiry_date + "%");
        stmt.setString(4, "%" + server_name + "%");
        stmt.setString(5, "%" + server_ip + "%");
        stmt.setString(6, "%" + description + "%");
        stmt.setString(7, "%" + algorithm + "%");
        stmt.setString(8, "%" + bit_length + "%");
        stmt.setString(9, "%" + type + "%");
        stmt.setString(10, "%" + phone + "%");
        stmt.setString(11, "%" + server_owner + "%");
        
        ResultSet rs = stmt.executeQuery();
%>
 
    <FORM id="cert" name="certs" method="POST" ACTION="#" >
        <table class="responsive-table">
            <tr>

                <td>   </td>  
                <td></td> 
                <td><b> ID  </td> 
                <td><b> Certificate Name  </b> </td> 
                <td><b> Expiry Date  </b> </td> 
                <td><b> Server Name </b> </td> 
                <td><b> Server IP  </b> </td>
                <td><b> Server Owner </b> </td>
                <td><b> Algorithm </b> </td> 
                <td><b> Bit Length </b> </td> 
                <td><b> Type </b> </td> 
                <td><b> Phone </b> </td> 
                <td><b> Description  </b> </td>
                </b>
            </tr> 
            
           <tr>
               
                
               <td><input id="expired" name="expired" type="checkbox" onclick="this.form.submit();" title="Show Expired Certificates" <% if (expired) {%> checked <% } %>></td>  
                <td> <input id="expiring" name="expiring" type="checkbox" onclick="this.form.submit();" title="Soon Expiring Certificates" <% if (expiring) {%> checked <% } %>> <input type="submit" value="Filter" style="position: absolute; left: -9999px; width: 1px; height: 1px;" tabindex="-1" /></td> 
                <td> <input name="id" size="4" value="<%=id %>" /> </td> 
                <td> <input name="cn" size="12" value="<%=cn %>"/> </td> 
                <td> <input name="expiry_date" size="12" value="<%=expiry_date %>"/> </td> 
                <td> <input name="server_name" size="12" value="<%=server_name %>"/> </td> 
                <td> <input name="server_ip" size="12" value="<%=server_ip %>"/> </td>
                <td> <input name="server_owner" size="12" value="<%=server_owner %>"/> </td>
                <td> <input name="algorithm" size="4" value="<%=algorithm %>"/> </td> 
                <td> <input name="bit_length" size="4" value="<%=bit_length %>"/> </td> 
                <td> <input name="type" size="12" value="<%=type %>"/> </td> 
                <td> <input name="phone" size="12" value="<%=phone %>"/> </td> 
                <td> <input name="description" size="12" value="<%=description %>"/> </td>
                </b>
            </tr>
            
            <%
                
    String color = "";            
    while (rs.next()) {
        
            if ( (Convert_to_longint(rs.getString("EXPIRY_DATE"))-ToDay())/86400000 <= 0 ) 
            {
                color="#ff0000";
            }
            
             else if ( ((Convert_to_longint(rs.getString("EXPIRY_DATE"))-ToDay())/86400000 > 0) &&  ((Convert_to_longint(rs.getString("EXPIRY_DATE"))-ToDay())/86400000 <= 10)) 
            {
                color="#ff69b4";
            }
             
            else if ( ((Convert_to_longint(rs.getString("EXPIRY_DATE"))-ToDay())/86400000 > 10) &&  ((Convert_to_longint(rs.getString("EXPIRY_DATE"))-ToDay())/86400000 <= 20)) 
            {
                color="#ffbf00";
            } 
            
             else if ( ((Convert_to_longint(rs.getString("EXPIRY_DATE"))-ToDay())/86400000 > 20) &&  ((Convert_to_longint(rs.getString("EXPIRY_DATE"))-ToDay())/86400000 <= 30)) 
            {
                color="#ffbf00";
            }
            
            else { color="black"; }

                %>

                 
            <tr style="color: <%=color%>; background: white;"> <td> <a href="certificate.jsp?action=edit&id=<%=rs.getString("ID")%> "> EDIT </a></td> <td><a href='#' onclick=" if (confirm('Delete Certificate\nAre   you sure?')){ document.forms['certs'].action='certificate.jsp?id=<%=rs.getString("ID")%>&action=delete';document.forms['certs'].submit();} else { void(''); };"> DELETE </a></td> 
                <td> <%=rs.getString("ID")%>  </td>  
                <td> <%=rs.getString("CN")%>  </td> 
                <td> <%=rs.getString("EXPIRY_DATE")%>  </td> 
                <td> <%=rs.getString("SERVER_NAME")%>  </td> 
                <td> <%=rs.getString("IP")%>  </td> 
                <td> <%=rs.getString("SERVER_OWNER")%> </td> 
                <td> <%=rs.getString("ALGORITHM")%> </td>
                <td> <%=rs.getString("BIT_LENGTH")%> </td>
                <td> <%=rs.getString("TYPE")%> </td>
                <td> <%=rs.getString("PHONE")%> </td>
                <td> <%=rs.getString("DESCRIPTION")%>  </td>
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
</html>
<%


    }



%>
