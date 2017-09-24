<%-- 
    Document   : logout
    Created on : Sep 5, 2017, 4:57:09 PM
    Author     : qeribli_s
--%>

<%
session.setAttribute("userid", null);
session.invalidate();
response.sendRedirect("index.jsp");
%>
