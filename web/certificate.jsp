<%-- 
    Document   : certificate.jsp
    Created on : Sep 12, 2017, 4:56:35 PM
    Author     : qeribli_s
--%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Properties"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="css/style_add_cert.css">
  <script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript">
function check_expiry_date()
{
    var expiry_date = document.getElementById('expiry_date').value;

    var curr_year = (new Date()).getFullYear();
    var my_expiry_date = expiry_date.split('/');
    var my_day=my_expiry_date[0];
    var my_month=my_expiry_date[1];
    var my_year = my_expiry_date[2];
    var response ;
    //alert(my_year);
  if (my_day>=1 && my_day<=31 && my_month>=1 && my_month<=12 && my_year>=curr_year)
  {
     response=true;
     return response;
  }
  else 
  {
    response=false;
    alert('Date not valid. Date format must be like dd/mm/yyyy. e.g. 31/12/'+curr_year);
    return response; 
  }
    
}

</script>

<%@ page import ="java.sql.*" %>
<%
    
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
        response.sendRedirect("index.jsp");
    } 
    
    else {
%>
<a><p align="right"> Welcome <%=session.getAttribute("userid")%></a>
<a href='success.jsp'>Home</a> 
&nbsp;&nbsp;
<a href="reg.jsp">Add new user</a>
&nbsp;&nbsp;
<a href="edit_user.jsp">Edit user</a>
&nbsp;&nbsp;
<a href='logout.jsp'>Log out</a>
</p>


<%
try {
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

   String cert_id = "";
   String action  = "";
    
if (request.getParameterMap().containsKey("id"))
{
    cert_id = request.getParameter("id");
} 

if (request.getParameterMap().containsKey("action"))
{
    action = request.getParameter("action");
} 




    
    if (action.equals("edit") && cert_id.length()>0) {
    try {
    PreparedStatement stmt=con.prepareStatement("SELECT ID, CN, EXPIRY_DATE, SERVER_NAME, IP,DESCRIPTION,  ALGORITHM, BIT_LENGTH,  TYPE, PHONE, SERVER_OWNER "
                                                + "  FROM CERTS WHERE ID=?");
    stmt.setString(1, cert_id);
    ResultSet rs = stmt.executeQuery();
     while (rs.next())
     {

    %>
        <form method="post" id ="update_cert" name="update_cert" action="#" onchange="return check_expiry_date() ">           
            <input  type="hidden" name="id" value="<%=rs.getString("ID")%>"> 
            <input  class="name" type="text" name="cn" value="<%=rs.getString("CN")%>" title="Certificate name (CN)" onchange="return IsEmpty()" required/>
            <input  class="name" type="text" id="expiry_date" name="expiry_date" value="<%=rs.getString("EXPIRY_DATE")%>" title="Expiry Date (e.g. 31/09/2021" required/>
            <input  class="name" type="text" name="server_name" value="<%=rs.getString("SERVER_NAME")%>" title="Server Name"  required/>
            <input  class="name"  type="text" name="ip" value="<%=rs.getString("IP")%>" title="Server IP Address"  required/>
            <input  class="name" type="text" name="description" title="<%=rs.getString("DESCRIPTION")%>" value="<%=rs.getString("DESCRIPTION")%>"/>
            <input  class="name"  type="text" name="alghoritm" value="<%=rs.getString("ALGORITHM")%>" title="Alghoritm (e.g. SHA256)"/>
            <input  class="name"  type="text" name="bit_length" value="<%=rs.getString("BIT_LENGTH")%>" title="Bit Length (e.g. 2048 bit)" onkeypress='return event.charCode >= 48 && event.charCode <= 57' />
            <input  class="name"  type="text" name="type" value="<%=rs.getString("TYPE")%>" title="Certificate type (e.g. Web, ACS etc.)"/>
            <input  class="name"  type="text" name="phone" value="<%=rs.getString("PHONE")%>" title="Phone (e.g. +994551234567;+994501234567" onkeypress="return (event.charCode >= 48 && event.charCode <= 57) || event.charCode===43 || event.charCode===59" />
            <input  class="name"  type="text" name="server_owner" value="<%=rs.getString("SERVER_OWNER")%>" title="Server owner (e.g. admin@millikart.az"/>         
            <input  type="hidden" name="action" value="edit">             
            <input class="button" type="submit" name="btnSubmit" id="btnSubmit" value="Update certificate" onclick="if (check_expiry_date()) {if (confirm('Update Certificate with ID: <%=rs.getString("ID")%>\nAre   you sure?')){ document.forms['update_cert'].action='update.jsp?id=<%=rs.getString("ID")%>&action=update';document.forms['update_cert'].submit();}} else { void(''); }; "/>
        </form>
<% 
}
stmt.close();
con.close();
}
        catch(Exception e)
        {
        String error=e.toString();
         %>
               <script type="text/javascript">
                   alert("Update failed! SQL Error: <%=error%>");
               </script>
        <%
        }
} //edit scope
else if (action.equals("add")) {%>


    <form method="post" name="add_cert" action="certificate.jsp">
           
        <input  class="name" type="text" name="cn" value="" placeholder="Certificate name (CN)" required/>
        <input  class="name" type="text" name="expiry_date" value="" placeholder="Expiry Date (e.g. dd/mm/yyyy)"  maxlength="10"  pattern="(^(((0[1-9]|1[0-9]|2[0-8])[\/](0[1-9]|1[012]))|((29|30|31)[\/](0[13578]|1[02]))|((29|30)[\/](0[4,6,9]|11)))[\/](19|[2-9][0-9])\d\d$)|(^29[\/]02[\/](19|[2-9][0-9])(00|04|08|12|16|20|24|28|32|36|40|44|48|52|56|60|64|68|72|76|80|84|88|92|96)$)" required/>
        <input  class="name" type="text" name="server_name" value="" placeholder="Server Name"  required/>
        <input  class="name"  type="text" name="ip" value="" placeholder="Server IP Address" required/>
        <input  class="name" type="text" name="description" value="" placeholder="Description"  required/>
        <input  class="name"  type="text" name="alghoritm" value="" placeholder="Alghoritm (e.g. SHA256)" required/>
        <input  class="name"  type="text" name="bit_length" value="" placeholder="Bit Length (e.g. 2048 bit)" required onkeypress='return event.charCode >= 48 && event.charCode <= 57'/>
        <input  class="name"  type="text" name="type" value="" placeholder="Certificate type (e.g. Web, ACS etc.)" required/>
        <input  class="name"  type="text" name="phone" value="" placeholder="Phone (e.g. +994551234567;+994501234567" required onkeypress='return (event.charCode >= 48 && event.charCode <= 57) || event.charCode===43 || event.charCode===59' />
        <input  class="name"  type="text" name="server_owner" value="" placeholder="Server owner (e.g. admin@millikart.az" required/>
        <input type="hidden" name="action" value="add">
        <input  class="button" type="submit" value="Add certificate" />
     </form>  
        


<%    if  (  request.getParameterMap().containsKey("cn") && 
        request.getParameterMap().containsKey("expiry_date") &&
        request.getParameterMap().containsKey("server_name") &&
        request.getParameterMap().containsKey("ip") &&
        request.getParameterMap().containsKey("description") &&
        request.getParameterMap().containsKey("alghoritm") &&
        request.getParameterMap().containsKey("bit_length") &&
        request.getParameterMap().containsKey("type") &&
        request.getParameterMap().containsKey("phone") &&
        request.getParameterMap().containsKey("server_owner")    )
      {

            String cn = request.getParameter("cn"); 
            String expiry_date = request.getParameter("expiry_date"); 
            String server_name = request.getParameter("server_name");
            String ip = request.getParameter("ip"); 
            String description = request.getParameter("description");
            String alghoritm = request.getParameter("alghoritm"); 
            String bit_length = request.getParameter("bit_length"); 
            String type = request.getParameter("type"); 
            String phone = request.getParameter("phone"); 
            String server_owner = request.getParameter("server_owner"); 



        try {
            PreparedStatement stmt=con.prepareStatement("INSERT INTO CERTS   (CN, EXPIRY_DATE, SERVER_NAME, IP,DESCRIPTION,  ALGORITHM, BIT_LENGTH,  TYPE, PHONE, SERVER_OWNER ) VALUES (?,?,?,?,?,?,?,?,?,?)");
            stmt.setString(1, cn);
            stmt.setString(2, expiry_date);
            stmt.setString(3, server_name);
            stmt.setString(4, ip);
            stmt.setString(5, description);
            stmt.setString(6, alghoritm);
            stmt.setString(7, bit_length);
            stmt.setString(8, type);
            stmt.setString(9, phone);
            stmt.setString(9, phone);
            stmt.setString(10,server_owner);


            int i = stmt.executeUpdate(); 

        if (i>0)
        {
         %>
            <script type="text/javascript">
                alert('Certificate Added');
            </script>
        <%
        }

        } //try scope

        catch(Exception e)
        {
        String error=e.toString();
         %>
               <script type="text/javascript">
                   alert("Please, check entered data. SQL Error: <%=error%>");
               </script>
        <%
        }
        %>
            <br><br>
            <%

       } // parameter map scope
}


else if (action.equals("delete") && cert_id.length()>0)  // delete SQL  

    {
    try 
    {
        PreparedStatement stmt=con.prepareStatement("DELETE FROM CERTS WHERE ID=?");
        stmt.setString(1, cert_id);
        

        int j = stmt.executeUpdate(); 

        if (j>0) {
         %>
            <script type="text/javascript">
                alert('Certificate Deleted');
            </script>
        <% response.sendRedirect("success.jsp");                
                }
    }
    catch (Exception e)
        {
        String error=e.toString();
         %>
               <script type="text/javascript">
                   alert("Deletion failed. SQL Error: <%=error%>");
               </script>
        <%
            response.sendRedirect("success.jsp");
        }
    }







else //if (!request.getParameterMap().containsKey("id") && request.getParameterMap().containsKey("action"))
{
out.println("CN, EXPIRY_DATE, SERVER_NAME, IP,DESCRIPTION,  ALGORITHM, BIT_LENGTH,  TYPE, PHONE are mandatory parameters!");
         %> <!--
               <script type="text/javascript">
                   alert("CN, EXPIRY_DATE, SERVER_NAME, IP,DESCRIPTION,  ALGORITHM, BIT_LENGTH,  TYPE, PHONE are mandatory parameters!");
               </script>
            -->
        <%
}

}

catch (Exception e) 
{
out.println("database connection error:" +e.toString());
}


} // session scope




%>
</head>
</html>
