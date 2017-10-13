<%-- 
    Document   : upload_cert
    Created on : Oct 12, 2017, 4:33:40 PM
    Author     : qeribli_s
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%  
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
        response.sendRedirect("index.jsp");
    } 
    
    else {
        %>
<!DOCTYPE html>
<html>
    <head>
       
     <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
     <link rel="stylesheet" href="css/style_upload_file.css">
     <jsp:include page="header.jsp" />
    <title>Upload Certificate</title>
    </head>
    <body>
     <form action = "UploadServlet" method = "post"  enctype = "multipart/form-data">
       <select name="cert_type" id="cert_type" required>
                  <option value="4" disabled selected> Select Certificate Type</option>
                  <option value="0" >*.pem, *.der, *.cer, *.crt</option>
                  <option value="1" >*.p7b, *.p7c, PKCS#7</option>
                  <option value="2">*.pfx, *.p12, PKCS#12</option>
                  <option value="3">*.JKS, Java Keystore</option>
                  
        </select>
         <input class="name" type = "file" name = "file" size = "50" />
          <input class="name" type = "password" name = "cert_pass" size = "50" />
         <input class="button" type = "submit" value = "Upload Certificate" />
      </form>
        
        

    </body>
</html>
                 <%
                 }
    %>
