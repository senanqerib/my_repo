<%-- 
    Document   : registration
    Created on : Sep 5, 2017, 4:55:19 PM
    Author     : Sanan Garibli
--%>

<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Properties"%>
<%@ page import ="java.sql.*" %>

<%
    if (session.getAttribute("userid") != null) {
        
    int USER_TYPE = Integer.parseInt(session.getAttribute("USER_TYPE").toString());
    if ( USER_TYPE == 0 ) {          

    String user = request.getParameter("uname");    
    String pwd = request.getParameter("pass");
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String email = request.getParameter("email");
    String user_type = request.getParameter("user_type");
    
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
        
        
    //Statement st = con.createStatement();
   PreparedStatement stmt=con.prepareStatement("insert into USERS(first_name, last_name, email, uname, pass, regdate, type) "
                                                                                    + "values (?, ?, ?, ?, password(?), CURDATE(), ?)");
    stmt.setString(1, fname);
    stmt.setString(2, lname);
    stmt.setString(3, email);
    stmt.setString(4, user);
    stmt.setString(5, pwd);
    stmt.setString(6, user_type);
    
   int i = stmt.executeUpdate();
    if (i > 0) {
 %>
             <script type="text/javascript">
                alert("User Successfully Created! Go to Login Page ...");
                window.location.href='logout.jsp';
              </script>
         <%
    } else {
        response.sendRedirect("index.jsp");
    }
    }
    catch (Exception e)
             { 
                 String error=e.toString();
         %>
               <script type="text/javascript">
                   alert("Registation Failed. Error: <%=error%>");
                   window.history.back();
               </script>
        <%
             }
    }
    

    else {

%>
               <script type="text/javascript">
                   alert("You are not administrator. Please login as administrator user");
                   window.location.href("logout.jsp");
               </script>
<%
}
}
else
{
%>
<script type="text/javascript">
   alert("You are not logged in. Please login as administrator user");
   window.location.href("logout.jsp");
</script>
<%
}
%>
