<%-- 
    Document   : upload_cert
    Created on : Oct 12, 2017, 11:39:17 PM
    Author     : Acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Upload Certificate</title>
        <link rel="stylesheet" href="css/style_upload_cert.css">
        <jsp:include page = "header.jsp"/>
   </head>
   
   <body>
      <form action = "UploadServlet" method = "post" enctype = "multipart/form-data">
         <input class="name" type = "file" name = "file" size = "50" />
         <input class="submit" type = "submit" value = "Upload File" />
      </form>
   </body>
</html>
