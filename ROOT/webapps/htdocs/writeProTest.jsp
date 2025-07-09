<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%
    request.setCharacterEncoding("utf-8");
    String DB_URL = "jdbc:mysql://localhost:3306/capDB";
    String DB_USER = "root";
    String DB_PASSWORD = "1234";
    Connection conn;
    Statement stmt;
    ResultSet rs = null;

    String filePath = request.getServletContext().getRealPath("/").replace("\\", "/");
    String userId = "9999";
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
        for (int i = 0; i < items.size(); i++) {
            System.out.println("");
            if (items.get(i).isFormField()) {
                System.out.println(items.get(i).getFieldName() + " = " + items.get(i).getString("utf-8"));
                if (items.get(i).getFieldName().equals("category")) {
                    category = items.get(i).getString("utf-8");
                } else if (items.get(i).getFieldName().equals("title")) {
                    title = items.get(i).getString("utf-8");
                } else if (items.get(i).getFieldName().equals("content")) {
                    content = items.get(i).getString("utf-8");
                }
            } else {
                System.out.println(items.get(i).getFieldName());

                String origin = items.get(i).getName();
                System.out.println(origin);
                String ext = origin.substring(origin.lastIndexOf("."));

                UUID uuid = UUID.randomUUID();
                String name = uuid + ext;

                File upPath = new File(String.valueOf(currentDir));
                if (!upPath.exists()) {
                    upPath.mkdirs();
                }
                String imageLocation = location + name;
                images += "images/" + name + " ";
                items.get(i).write(new File(upPath, name));
            }
        }
        System.out.println(images);
    } catch (Exception e) {
        e.printStackTrace();
    }

    int result =0;
    boolean success = true;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        stmt = conn.createStatement();
        result = stmt.executeUpdate("INSERT INTO post VALUES (null,'" + userId + "','" + category + "','" + title + "','" + content + "','" + images + "','" + date + "',0)");


        if (result == 0)
            success = false;
        conn.close();
    } catch (Exception e) {
        success = false;
        System.out.println(e.getMessage());
    }
%>

<script type="text/javascript">
    if (<%=success%>) {
        alert("성공");
        history.go(-1);
    } else {
        alert("오류 발생");
        <%
        out.print("서버 경로 : " + filePath);

        out.print("이미지 : " + images);
        out.print("\n완성 : \n" + content);
        out.print("\n쿼리문 : \n" + "INSERT INTO post VALUES (null,'"+userId+"','"+category+"','"+title+"','"+content+"','"+images+"','"+date+"',0)");
        out.print("\nresult 값: " + result);
        out.print("success 값: " + success);
        %>
    }


</script>