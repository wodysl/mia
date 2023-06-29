<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>회원 추가</title>
    <script>
        function redirectToAdminPage() {
            setTimeout(function() {
                location.href = "admin.jsp";
            }, 2000); // 2초 후에 admin.jsp로 이동
        }
    </script>
</head>
<body>
    <h2>회원 추가</h2>

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
    %>

    <%-- 회원 정보 입력 폼 --%>
    <form method="post" action="insert.jsp">
        <label for="user_id">아이디:</label>
        <input type="text" id="user_id" name="user_id" required><br>

        <label for="pwd">비밀번호:</label>
        <input type="password" id="pwd" name="pwd" required><br>

        <label for="name">이름:</label>
        <input type="text" id="name" name="name" required><br>

        <label for="nickname">닉네임:</label>
        <input type="text" id="nickname" name="nickname" required><br>

        <label for="email">이메일:</label>
        <input type="email" id="email" name="email" required><br>

        <label for="grade">등급:</label>
        <input type="number" id="grade" name="grade" required><br>

        <input type="submit" value="추가">
    </form>

    <%-- 회원 정보를 데이터베이스에 추가 --%>
    <% 
        String user_id = request.getParameter("user_id");
        String pwd = request.getParameter("pwd");
        String name = request.getParameter("name");
        String nickname = request.getParameter("nickname");
        String email = request.getParameter("email");
        int grade = Integer.parseInt(request.getParameter("grade"));

        String insertQuery = "INSERT INTO user (user_id, pwd, name, nickname, email, grade, regdate) VALUES (?, ?, ?, ?, ?, ?, ?)";
        pstmt = con.prepareStatement(insertQuery);
        pstmt.setString(1, user_id);
        pstmt.setString(2, pwd);
        pstmt.setString(3, name);
        pstmt.setString(4, nickname);
        pstmt.setString(5, email);
        pstmt.setInt(6, grade);
        pstmt.setTimestamp(7, new Timestamp(System.currentTimeMillis()));
        pstmt.executeUpdate();

        out.println("회원이 추가되었습니다.");

        // JavaScript를 사용하여 2초 후에 admin.jsp로 이동
        out.println("<script>redirectToAdminPage();</script>");
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
