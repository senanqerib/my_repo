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
     <link rel="stylesheet" href="css/style_upload_cert.css">
     <jsp:include page="header.jsp" />
    <title>Upload Certificate</title>
    <script type="text/javascript">
    function activate_input(val){
        var element=document.getElementById('cert_pass');
        if(val==='2'||val==='3')
          element.style.display='block';
        else  
          element.style.display='none';
       }

    </script>
    </head>
    <body>
     <form action = "FileUploadServlet" method = "post" enctype = "multipart/form-data">
       <input class="name" type = "file" name = "file" size = "50" />
       <select name="cert_type" id="cert_type" onchange='activate_input(this.value);' >
                  <option value="4" disabled selected> Select Certificate Type</option>
                  <option value="0">*.pem, *.der, *.cer, *.crt</option>
                  <option value="1">*.p7b, *.p7c, pkcs#7</option>
                  <option value="2">*.pfx, *.p12, pkcs#12</option>
                  <option value="3">*.jks, Java Keystore</option>
                  
       </select>
        <input type="text" value="d:\\uploaded_certs" name="destination" placeholder="destination"/>
         
         <input class="name" type = "password" name = "cert_pass" id = "cert_pass" size = "50" placeholder="certificate password" style='display:none;'/>
         <input class="button" type = "submit" value = "Upload Certificate" />
      </form>
        
        

    </body>
</html>
                 <%
                 }
    %>
