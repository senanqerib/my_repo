import java.io.*;
import java.util.*;
 
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;


@WebServlet("")
@MultipartConfig

public class UploadServlet extends HttpServlet {
   
   private boolean isMultipart;
   private String filePath;
   private final int maxFileSize = 50 * 1024;
   private final int maxMemSize = 4 * 1024;
   private File file ;

   @Override
   public void init( ){
      // Get the file location where it would be stored.
      filePath = getServletContext().getInitParameter("file-upload"); 
   }
   
   @Override
   public void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, java.io.IOException {
   
      // Check that we have a file upload request
      isMultipart = ServletFileUpload.isMultipartContent(request);
      response.setContentType("text/html");
      java.io.PrintWriter out = response.getWriter( );
   
      if( !isMultipart ) {
         out.println("<html>");
         out.println("<head>");
         out.println("<title>Servlet upload</title>");  
         out.println("</head>");
         out.println("<body>");
         out.println("<p>No file uploaded</p>"); 
         out.println("</body>");
         out.println("</html>");
         return;
      }
  
      DiskFileItemFactory factory = new DiskFileItemFactory();
   
      // maximum size that will be stored in memory
      factory.setSizeThreshold(maxMemSize);
   
      // Location to save data that is larger than maxMemSize.
      factory.setRepository(new File("c:\\temp"));

      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
   
      // maximum file size to be uploaded.
      upload.setSizeMax( maxFileSize );

      try { 
         // Parse the request to get file items.
         List fileItems = upload.parseRequest(request);
	
         // Process the uploaded file items
         Iterator i = fileItems.iterator();

         out.println("<html>");
         out.println("<head>");
         out.println("<title>Servlet upload</title>");  
         out.println("</head>");
         out.println("<body>");
         
        String cert_type = "";
        if (request.getParameterMap().containsKey("cert_type"))  
            cert_type = request.getParameter("cert_type"); 
      
        String cert_pass= "";
        if (request.getParameterMap().containsKey("cert_pass")) 
            cert_pass= request.getParameter("cert_pass"); 
   
         while ( i.hasNext () ) {
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField () ) {
               // Get the uploaded file parameters
               String fieldName = fi.getFieldName();
               String fileName = fi.getName();
               String contentType = fi.getContentType();
               boolean isInMemory = fi.isInMemory();
               long sizeInBytes = fi.getSize();
            
               // Write the file
               if( fileName.lastIndexOf("\\") >= 0 ) {
                  file = new File( filePath + fileName.substring( fileName.lastIndexOf("\\"))) ;
               } else {
                  file = new File( filePath + fileName.substring(fileName.lastIndexOf("\\")+1)) ;
               }
               fi.write( file ) ;
               out.println("Uploaded Filename: " + fileName + "<br>");
               out.println("Uploaded Cert Type: " + cert_type + "<br>");
               out.println("Uploaded Cert Pass: " + cert_pass + "<br>");
            }     
            
         }
         
                     ////////////////////////////////

        
              ReadCert RC = new ReadCert();
              String[] a;
              a = new String[10];
              
                switch (cert_type) {
                    case "0":
                       a = RC.Read_PEM_DER_Cert(file.toString());
                       for (String a1 : a) {
                        out.println(a1);
                        out.println("</br>");
             }  
                        break;
                    case "1":
                         RC.Read_PKCS7_Cert(file.toString());
                         for (String a1 : a) {
                            out.println(a1);
                            out.println("</br>");
             }  
                        break;
                    case "2":
                         RC.Read_PFX_Cert(file.toString(), cert_pass); 
                         for (String a1 : a) {
                            out.println(a1);
                            out.println("</br>");
             }  
                        break;
                    case "3":
                         RC.Read_JKS(file.toString(), cert_pass);
                         for (String a1 : a) {
                            out.println(a1);
                            out.println("</br>");
             }  
                        break;
                    default:
                        out.println("Select Certificate Type" );
                        break;
                        
                        
                }
                
                       
            //////////////////////////////////
            
            
         out.println("</body>");
         out.println("</html>");
         } catch(Exception ex) {
            out.println(ex);
         }
      }
      
   @Override
      public void doGet(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, java.io.IOException {

         throw new ServletException("GET method used with " +
            getClass( ).getName( )+": POST method required.");
      }
   }
