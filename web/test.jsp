<%-- 
    Document   : test
    Created on : Sep 14, 2017, 5:53:23 PM
    Author     : qeribli_s
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.lang.String"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
public  String Convert_to_date_string(String startDateString)
{
String return_date;
DateFormat df = new SimpleDateFormat("dd/MM/yyyy"); 
Date startDate;
try {
    startDate = df.parse(startDateString);
    String newDateString = df.format(startDate);
    return_date= newDateString;
} catch (ParseException e) {
    e.printStackTrace();
    return_date = null;
}
return return_date;
}


%>

<%!
 public int Compare_date(String str) throws ParseException
  {
    Date date  =  new Date();
    Date date1 = new SimpleDateFormat("dd/MM/yyyy").parse(str);

    Calendar cal = Calendar.getInstance();
    cal.setTime(date);
    Calendar cal1 = Calendar.getInstance();
    cal1.setTime(date1);

    if(cal.get(Calendar.YEAR) == cal1.get(Calendar.YEAR) && cal.get(Calendar.MONTH) == cal1.get(Calendar.MONTH)
            && cal.get(Calendar.DAY_OF_MONTH) == cal1.get(Calendar.DAY_OF_MONTH)
            )
    {
        System.out.println("Dates are equal");
    return 1;
    }
    else
    {
        System.out.println("Dates not equal");
    return 0;
        }

    }

%>
        
        
<%!
private Date before_10_days() {
    final Calendar cal = Calendar.getInstance();
    cal.add(Calendar.DATE, -10);
    return cal.getTime();
}
%> 

<%!
private Date before_20_days() {
    final Calendar cal = Calendar.getInstance();
    cal.add(Calendar.DATE, -20);
    return cal.getTime();
}
%> 

<%!
private Date before_30_days() {
    final Calendar cal = Calendar.getInstance();
    cal.add(Calendar.DATE, -30);
    return cal.getTime();
}
%> 

  <%!
 public  int ToDay() 
{
    try {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Date date = new Date();

        return Integer.parseInt(sdf.format(date));

        } 
    catch (Exception e) 
    {
        e.printStackTrace();
        return 0;
    }
 
}
%>



<% 
out.println("10 days before: " +before_10_days());
out.println("<br>");
out.println("20 days before: " +before_20_days());
out.println("<br>");
out.println("30 days before: " +before_30_days());
out.println("<br>");
out.println("ToDay: " +ToDay());
out.println("<br>");
out.println("Convert_to_date('21/12/2018'): " + Convert_to_date("21/12/2018"));
out.println("<br>");
Compare_date("15/09/2017");
%>

    </body>
</html>
