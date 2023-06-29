<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>댓글 삭제</title>
    <meta http-equiv="refresh" content="3;url=commentList.jsp">
</head>
<body>
    <% 
    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        // MariaDB 정보 입력
        String server = "172.16.100.32:3306";
        String username = "root";
        String password = "1234";
        String database = "mia";
        String url = "jdbc:mysql://" + server + "/" + database;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(url, username, password);

        String comment_id = request.getParameter("comment_id");
        String query = "DELETE FROM comment WHERE comment_id = ?";
        pstmt = con.prepareStatement(query);
        pstmt.setInt(1, Integer.parseInt(comment_id));
        int rowCount = pstmt.executeUpdate();

        if (rowCount > 0) {
            out.println("<h2>댓글이 삭제되었습니다.</h2>");
        } else {
            out.println("<h2>댓글 삭제에 실패했습니다.</h2>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
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

    <a href="commentList.jsp">댓글 목록으로 바로 가기</a>
</body>
</html>
