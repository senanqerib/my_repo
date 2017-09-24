<%-- 
    Document   : test2
    Created on : Sep 17, 2017, 12:52:29 AM
    Author     : Acer
--%>


<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Date Converter</title>
    </head>
    <body>
<%!
public  Date Convert_to_date(String startDateString)
{
Date return_date;
DateFormat df = new SimpleDateFormat("dd/MM/yyyy"); 
Date startDate;
try {
    startDate = df.parse(startDateString);
    return_date= startDate;
} catch (ParseException e) {
    e.printStackTrace();
    return_date = null;
}
return return_date;
}


%>

<%!
public  long Convert_to_longint(String startDateString)
{
Date return_date;
DateFormat df = new SimpleDateFormat("dd/MM/yyyy"); 
Date startDate;
try {
    startDate = df.parse(startDateString);
    return_date= startDate;
} catch (ParseException e) {
    e.printStackTrace();
    return_date = null;
}
return return_date.getTime();
}

%>

<%!
 public  long ToDay() 
{

Date startDate =  new Date();
long date_long;

try {
    date_long=startDate.getTime();
} 
catch (Exception e) 
{
    e.printStackTrace();
    date_long = 0;
}
return date_long;
 
}
%>

        <%
        out.println("Convert_to_date('21/12/2018'): " + Convert_to_date("21/12/2018"));
        out.println("<br>");
        out.println("Convert_to_longint: " + Convert_to_longint("21/12/2018"));
        out.println("<br>");
        out.println("Convert_to_longint: " + Convert_to_longint("22/12/2018"));
        out.println("<br>");
        long days=(Convert_to_longint("18/09/2018") - ToDay())/86400000;
        out.println("Difference by days: " + days);
        out.println("<br>");
        //out.println("Today as longint: " +ToDay());

        %>
    </body>
</html>
