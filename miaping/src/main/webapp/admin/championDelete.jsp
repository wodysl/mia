<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>챔피언 삭제</title>
</head>
<body>
    <h2>챔피언 삭제</h2>

    <%-- 데이터베이스 연결 --%>
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

        // 챔피언 번호 받아오기
        int ch_no = Integer.parseInt(request.getParameter("ch_no"));

        // 챔피언 삭제 쿼리
        String deleteQuery = "DELETE FROM champion WHERE ch_no = ?";
        pstmt = con.prepareStatement(deleteQuery);
        pstmt.setInt(1, ch_no);
        pstmt.executeUpdate();

        out.println("챔피언이 삭제되었습니다.");

        // 3초 후에 championList.jsp로 이동
        response.setHeader("Refresh", "3;URL=championList.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) {
            try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        if (con != null) {
            try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
    %>
</body>
</html>
