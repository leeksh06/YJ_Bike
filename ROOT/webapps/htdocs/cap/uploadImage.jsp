<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="javax.xml.bind.DatatypeConverter" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="javax.imageio.ImageIO" %>

<%
    String base64_image = request.getParameter("base64_image");
    if (base64_image != null) {
        String fileName = request.getParameter("fileName");
        String filePath = request.getServletContext().getRealPath("/").replace("\\", "/");
        String location = filePath + "images/";
        File currentDir = new File(location);

        // base64 이미지 한장씩
//        System.out.println("업로드 이미지 : " + upload_image);
        File upPath = new File(String.valueOf(currentDir));
        if (!upPath.exists()) {
            upPath.mkdirs();
        }
        byte[] imageBytes = DatatypeConverter.parseBase64Binary(base64_image);
        try {
            BufferedImage bufImg = ImageIO.read(new ByteArrayInputStream(imageBytes));
            String ext = fileName.substring(fileName.lastIndexOf(".") + 1);
            ImageIO.write(bufImg, ext,new File(upPath, fileName));
            System.out.println("이미지 저장 : " + fileName);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
%>