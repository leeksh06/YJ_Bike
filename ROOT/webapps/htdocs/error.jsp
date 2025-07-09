<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error Page</title>
</head>
<body>
    <h1>An error occurred</h1>
    <p><strong>Error message:</strong> <%= exception.getMessage() %></p>
    <p><strong>Error stack trace:</strong></p>
    <pre><%
        java.io.StringWriter sw = new java.io.StringWriter();
        exception.printStackTrace(new java.io.PrintWriter(sw));
        String exceptionAsString = sw.toString();
        out.println(exceptionAsString);
    %></pre>
</body>
</html>
