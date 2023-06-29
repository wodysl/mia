<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>게시물 목록</title>
</head>
<body>
    <h2>게시물 목록</h2>
    <table border="1">
        <tr>
            <th>글번호</th>
            <th>작성자</th>
            <th>제목</th>
            <th>내용</th>
            <th>작성일</th>
            <th>삭제</th>
        </tr>

        <%-- 데이터베이스 연결 --%>
        <% 
    	Connection con = null;
    	PreparedStatement PS = null;
    	ResultSet RS = null;
    	
    	try{
    		//maraidb 정보입력 시작 
    		String server = "172.16.100.32:3306";
    		String username = "root";
    		String pwd = "1234";
    		String database = "mia";
    		String url = "jdbc:mysql://" + server + "/" + database;
    		Class.forName("com.mysql.jdbc.Driver");
    		con = DriverManager.getConnection(url, username, pwd);

            String query = "SELECT * FROM board";
            PS = con.prepareStatement(query);
    		RS = PS.executeQuery();
    		
    		int count = 0;

    		while(RS.next()) {
                int boardId = RS.getInt("board_id");
                String writer = RS.getString("user_id");
                String title = RS.getString("title");
                String contents = RS.getString("contents");
                Date createDate = RS.getDate("create_date");

                out.println("<tr>");
                out.println("<td>" + boardId + "</td>");
                out.println("<td>" + writer + "</td>");
                out.println("<td>" + title + "</td>");
                out.println("<td>" + contents + "</td>");
                out.println("<td>" + createDate + "</td>");
                out.println("<td><a href='adminDeleteBoard.jsp?boardId=" + boardId + "'>삭제</a></td>");
                out.println("</tr>");
                count++;

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (RS != null) {
                try { RS.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (PS != null) {
                try { PS.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (con != null) {
                try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
        %>
    </table>
</body>
</html>
