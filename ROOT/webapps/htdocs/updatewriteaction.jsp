<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="post.PostDAO" %>
<%@ page import="post.Post" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.IOException" %>

<%
request.setCharacterEncoding("utf-8");
String DB_URL = "jdbc:mysql://localhost:3306/capDB";
String DB_USER = "root";
String DB_PASSWORD = "1234";
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

int idx = 0;
if (request.getParameter("idx") != null) {
    idx = Integer.parseInt(request.getParameter("idx"));
}

String userId = session.getAttribute("user_id").toString();
String thumImg = null;
String filePath = request.getServletContext().getRealPath("/").replace("\\", "/");

SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Calendar cal = Calendar.getInstance();
cal.add(Calendar.DATE, 0);
String date = dateFormat.format(cal.getTime());

String location = filePath + "images/";
int maxSize = 1024 * 1024 * 10;

File currentDir = new File(location);
DiskFileItemFactory factory = new DiskFileItemFactory();
factory.setRepository(currentDir);
factory.setSizeThreshold(maxSize);

String category = "", title = "", content = "";
int result = 0;
boolean success = true;

String thum = "", str = "";
String[] tempStrArr = null;
ArrayList<Integer> remainArr = new ArrayList<Integer>();

ServletFileUpload upload = new ServletFileUpload(factory);

try {
    List<FileItem> items = upload.parseRequest(request);

    for (FileItem fi : items) {
        if (fi.isFormField()) {
            String fieldName = fi.getFieldName();
            if ("category".equals(fieldName)) {
                category = fi.getString("utf-8");
            } else if ("title".equals(fieldName)) {
                title = fi.getString("utf-8");
            } else if ("content".equals(fieldName)) {
                content = fi.getString("utf-8");
            } else if ("str".equals(fieldName)) {
                str = fi.getString("utf-8");
                tempStrArr = str.split(" ");
            }
        } else {
             String origin = fi.getName();
             if (!origin.equals("")) {
                 String ext = origin.substring(origin.lastIndexOf("."));

                 UUID uuid = UUID.randomUUID();
                 String name = uuid + ext;

                 File upPath = new File(String.valueOf(currentDir));
                 if (!upPath.exists()) {
                     upPath.mkdirs();
                 }
                 thum += "images/" + name + " ";
                 fi.write(new File(upPath, name));
             }
        }
    }

    if (remainArr.size() > 0) {
        String tempStr = "";
        for (int j = 0; j < remainArr.size(); j++) {
            tempStr += tempStrArr[remainArr.get(j)] + " ";
        }
        thum = tempStr + thum;
    }

} catch (Exception e) {
    success = false;
    e.printStackTrace();
}

String sql = "UPDATE post SET category=?, title=?, content=?, thum=? WHERE idx=?";
try {
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, category);
    pstmt.setString(2, title);
    pstmt.setString(3, content);
    pstmt.setString(4, thum);
    pstmt.setInt(5, idx);

    result = pstmt.executeUpdate();

    if (result == 0)
        success = false;

    conn.close();
} catch (Exception e) {
    success = false;
    System.out.println(e.getMessage());
}

if (success) {
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('글이 수정되었습니다.')");
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
    script.println("alert('글 수정이 실패했습니다.')");
    script.println("history.back()");
    script.println("</script>");
}
%>
