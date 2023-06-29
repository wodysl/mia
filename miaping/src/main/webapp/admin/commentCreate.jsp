<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>댓글 등록</title>
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

        int boardId = Integer.parseInt(request.getParameter("board_id"));
        String userId = request.getParameter("user_id");
        String nickname = request.getParameter("nickname");
        String content = request.getParameter("content");

        // 쿼리 실행
        String query = "INSERT INTO comment (board_id, user_id, nickname, content, create_date) VALUES (?, ?, ?, ?, NOW())";
        pstmt = con.prepareStatement(query);
        pstmt.setInt(1, boardId);
        pstmt.setString(2, userId);
        pstmt.setString(3, nickname);
        pstmt.setString(4, content);
        pstmt.executeUpdate();

        // 댓글 등록 완료 메시지 출력
        out.println("댓글이 등록되었습니다.");

        // 3초 후에 게시물 상세 페이지로 이동
        response.setHeader("Refresh", "3;URL=boardDetail.jsp?board_id=" + boardId);
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
</body>
</html>
