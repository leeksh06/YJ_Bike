<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@page import="post.PostDAO"%>
<%@page import="post.Post"%>
<%
    request.setCharacterEncoding("utf-8");
    String DB_URL = "jdbc:mysql://localhost:3306/capDB";
    String DB_USER = "root";
    String DB_PASSWORD = "1234";
    Connection conn;
    Statement stmt;
    ResultSet rs = null;

    String filePath = request.getServletContext().getRealPath("/").replace("\\", "/");
      String userId = session.getAttribute("user_id").toString();
   
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Calendar cal = Calendar.getInstance();
    cal.add(Calendar.DATE, 0);
    String date = dateFormat.format(cal.getTime());

    //************************************************************
    String location = filePath + "images/";
    int maxSize = 1024 * 1024 * 10;

    File currentDir = new File(location);
    DiskFileItemFactory factory = new DiskFileItemFactory();
    factory.setRepository(currentDir);
    factory.setSizeThreshold(maxSize);

    String images = "";
    String category = "", title = "", content = "";

    ServletFileUpload upload = new ServletFileUpload(factory);
    try {
        List<FileItem> items = upload.parseRequest(request);
        for (FileItem fi : items) {
            System.out.println("");
            if (fi.isFormField()) {
                System.out.println(fi.getFieldName() + " = " + fi.getString("utf-8"));
                if (fi.getFieldName().equals("category")) {
                    category = fi.getString("utf-8");
                } else if (fi.getFieldName().equals("title")) {
                    title = fi.getString("utf-8");
                } else if (fi.getFieldName().equals("content")) {
                    content = fi.getString("utf-8");
                }
            } else {
                System.out.println(fi.getFieldName() + " = " + fi.getName());

                String origin = fi.getName();
                String ext = origin.substring(origin.lastIndexOf("."));

                UUID uuid = UUID.randomUUID();
                String name = uuid + ext;

                File upPath = new File(String.valueOf(currentDir));
                if (!upPath.exists()) {
                    upPath.mkdirs();
                }
                String imageLocation = location + name;
                System.out.println("저장" + imageLocation);
                images += "images/" + name + " ";
                fi.write(new File(upPath, name));
            }
        }
        System.out.println(images);
    } catch (Exception e) {
        e.printStackTrace();
    }

    boolean success = true;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        stmt = conn.createStatement();
        int writeResult = stmt.executeUpdate("INSERT INTO post VALUES (null,'" + userId + "','" + category + "','" + title + "','" + content + "','" + images + "','" + date + "',0)");

        if (writeResult == 0)
            success = false;
        conn.close();

        if (success) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('글이 업로드되었습니다.')");
            if (category.equals("free")) {
                script.println("location.href='Untitled-2.jsp'");
            } else if (category.equals("ask")) {
                script.println("location.href='Untitled-3.jsp'");
            } else if (category.equals("use")) {
                script.println("location.href='Untitled-4.jsp'");
            } else {
                script.println("location.href='Untitled-5.jsp'");
            }
            script.println("</script>");
        } else {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('글쓰기에 실패했습니다')");
            script.println("history.back()");
            script.println("</script>");
        }
    } catch (Exception e) {
        success = false;
        System.out.println(e.getMessage());
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
</body>
</html>
