<%-- 
    Document   : login
    Created on : Sep 5, 2017, 4:56:10 PM
    Author     : qeribli_s
--%>


<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Properties"%>
<%@ page import ="java.sql.*" %>
<%
    


    String userid = request.getParameter("uname");    
    String pwd = request.getParameter("pass");
    try {
    //Class.forName("com.mysql.jdbc.Driver");
    //Connection con = DriverManager.getConnection("jdbc:mysql://172.16.10.246:3306/certificates_monitoring", "seymur", "seymur");
    
    ////////////////////////////////////////////////////////////////////////////
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
    
    PreparedStatement stmt = con.prepareStatement("select * from members where uname=? and pass=password(?)");
    stmt.setString(1, userid);
    stmt.setString(2, pwd);
    ResultSet rs;
    rs = stmt.executeQuery();
    if (rs.next()) {
        session.setAttribute("userid", userid);
        //out.println("welcome " + userid);
        //out.println("<a href='logout.jsp'>Log out</a>");
        response.sendRedirect("success.jsp");
        }
    
    
    else {
        out.println("Invalid password <a href='index.jsp'>Try again</a>");
    }
    stmt.close();
    con.close();
    }
    catch (Exception e)
    {
    out.println(e.toString());
    }
%>
