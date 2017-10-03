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
<jsp:include page="header.jsp" />
<%  
    
    if (request.getParameterMap().containsKey("fname") && request.getParameterMap().containsKey("lname") && 
            request.getParameterMap().containsKey("uname") && request.getParameterMap().containsKey("email")
            && ((request.getParameter("pass").toString()!="") && request.getParameter("pass").toString()!= null )
            && ((request.getParameter("pass1").toString()!="") && request.getParameter("pass1").toString()!= null )
            && ((request.getParameter("pass2").toString()!="") && request.getParameter("pass2").toString()!= null ))
{       
    try {
        String uname = request.getParameter("uname");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String email = request.getParameter("email");
        String pass  = request.getParameter("pass");
        String pass1 = request.getParameter("pass1");
        String pass2 = request.getParameter("pass2");
        
        String query_password="select pass from USERS where pass=password(?)";
            
        //String username = session.getAttribute("userid").toString(); 
        String user_update_query = "update USERS  set uname=?, first_name=?, last_name=?, email=?, pass=password(?) where uname=? ";   
    
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
    
    
        PreparedStatement stmt_q=con.prepareStatement(query_password);
        stmt_q.setString(1, pass);
        ResultSet rs_p = stmt_q.executeQuery();
        int count=0;
        while(rs_p.next())
        {
        count++;
        }
        if (count > 0 && pass1.equals(pass2))
        {
        PreparedStatement stmt=con.prepareStatement(user_update_query);
        stmt.setString(1, uname); 
        stmt.setString(2, fname);
        stmt.setString(3, lname);
        stmt.setString(4, email);
        stmt.setString(5, pass1);
        stmt.setString(6, uname);
   
    try
        {         
        int i=stmt.executeUpdate();
        if (i>0)
        {%>
             <script type="text/javascript">
                alert("Password Changed! Go to Home Page ...");
                window.location.href='success.jsp';
              </script>
         <%
            
        }
        else 
        {%>
             <script type="text/javascript">
                 alert("Error: Password didn't change");
                  window.history.back();
              </script>
         <%        
          }
        stmt.close();
        stmt_q.close();
    }
        catch(Exception e)
        { 
                  String error=e.toString();
         %>
               <script type="text/javascript">
                   alert("Error: <%=error%>");
               </script>
        <%
        }
    
    
 
    }
        else 
        {%>
            <script type="text/javascript">
                alert("Current password is wrong!");
                window.history.back();
              </script>
         <%           
        }
    }
    catch (Exception e)
            {
                   String error=e.toString();
         %>
               <script type="text/javascript">
                   alert("Database connection error: <%=error%>");
               </script>
        <%
            }
}
    else  {
%>
             <script type="text/javascript">
                alert("Password is empty! Please, fill  password field");
                window.history.back();
              </script>
         <%       
    }
}
%>