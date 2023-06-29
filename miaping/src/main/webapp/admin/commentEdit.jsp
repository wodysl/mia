<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>댓글 수정</title>
</head>
<body>
    <h2>댓글 수정</h2>

    <% 
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // MariaDB 정보 입력
        String server = "172.16.100.32:3306";
        String username = "root";
        String password = "1234";
        String database = "mia";
        String url = "jdbc:mysql://" + server + "/" + database;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(url, username, password);

        // 댓글 ID 받아오기
        int comment_id = Integer.parseInt(request.getParameter("comment_id"));

        // 해당 댓글 조회
        String selectQuery = "SELECT * FROM comment WHERE comment_id = ?";
        pstmt = con.prepareStatement(selectQuery);
        pstmt.setInt(1, comment_id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String content = rs.getString("content");
            String author = rs.getString("user_id");
    %>

    <form action="commentUpdate.jsp" method="post">
        <input type="hidden" name="comment_id" value="<%= comment_id %>">
        <label for="content">댓글 내용:</label>
        <textarea name="content" id="content" rows="3" cols="30"><%= content %></textarea>
        <br>
        <label for="author">작성자:</label>
        <input type="text" name="author" id="author" value="<%= author %>">
        <br>
        <input type="submit" value="수정">
    </form>

    <% 
        } else {
            out.println("해당 댓글을 찾을 수 없습니다.");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) {
                rs.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    %>
</body>
</html>
