<%-- 
    Document   : registration
    Created on : Sep 5, 2017, 4:55:19 PM
    Author     : qeribli_s
--%>

<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Properties"%>
<%@ page import ="java.sql.*" %>

<%
    if (session.getAttribute("userid") != null) {
    
    if ( (session.getAttribute("userid").equals("admin")) ) {        

    String user = request.getParameter("uname");    
    String pwd = request.getParameter("pass");
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String email = request.getParameter("email");
    
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
   PreparedStatement stmt=con.prepareStatement("insert into members(first_name, last_name, email, uname, pass, regdate) "
                                                                                    + "values (?, ?, ?, ?, password(?), CURDATE())");
    stmt.setString(1, fname);
    stmt.setString(2, lname);
    stmt.setString(3, email);
    stmt.setString(4, user);
    stmt.setString(5, pwd);
    
   int i = stmt.executeUpdate();
    if (i > 0) {
        //session.setAttribute("userid", user);
        response.sendRedirect("welcome.jsp");
       // out.print("Registration Successfull!"+"<a href='index.jsp'>Go to Login</a>");
    } else {
        response.sendRedirect("index.jsp");
    }
    stmt.close();
    con.close();
    }
    catch (Exception e)
             {  
                 out.println("Error occuired: ");
                 out.println(e.toString());
             }
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
