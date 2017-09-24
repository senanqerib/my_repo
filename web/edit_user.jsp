<%-- 
    Document   : reg
    Created on : Sep 5, 2017, 4:54:42 PM
    Author     : qeribli_s
--%>


<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Properties"%>
<%@ page import ="java.sql.*" %>
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
    String user_name = session.getAttribute("userid").toString(); 
    String user_select_query = "select uname,first_name, last_name, email from members where uname=? ";   

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

        
        PreparedStatement stmt=con.prepareStatement(user_select_query);
        stmt.setString(1, user_name); 

        ResultSet rs=stmt.executeQuery();
        String fname="";
        String lname="";
        String email="";
    try
        {         
         while (rs.next()) 
         {
         fname=rs.getString("first_name");
         lname=rs.getString("last_name");
         email=rs.getString("email");
         }
         
    }
        catch(Exception e)
        { 
            out.println(e);
        }
    

    
%>             
                    <%@page contentType="text/html" pageEncoding="UTF-8"%>
                    <!DOCTYPE html>
                    <html>
                        <head>
                            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                             <link rel="stylesheet" href="css/style.css">
                            <title>Edit User</title>
                        </head>
                        <body>
                            <form method="post" action="update_user.jsp">

                                    <input class="name" type="text"     name="fname" value="<%=fname%>" placeholder="First Name" readOnly/>
                                    <input class="name" type="text"     name="lname" value="<%=lname%>" placeholder="Last Name" readOnly />
                                    <input class="name" type="text"     name="email" value="<%=email%>" placeholder="Email"  required/>
                                    <input class="name" type="text"     name="uname" value="<%=user_name%>" placeholder="User Name" readOnly/>
                                    <input class="pw"   type="password" name="pass"  value="" placeholder="Password"  required/>

                                    <input class="button" type="submit" value="Update" />
                            </form>
                        </body>
                    </html>
             <%
            
           //response.sendRedirect("edit.jsp?id="+cert_id);
           stmt.close();
           con.close();
 }
catch (Exception e)
    {
        out.println("Connection failed: " + e.toString());
    }

}
 

 %>




