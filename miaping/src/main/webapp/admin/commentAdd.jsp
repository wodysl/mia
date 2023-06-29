<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>댓글 추가</title>
</head>
<body>
    <h2>댓글 추가</h2>

    <%-- 댓글 등록 폼 --%>
    <form method="POST" action="commentCreate.jsp">
        <input type="hidden" name="board_id" value="<%= request.getParameter("board_id") %>">
        <input type="hidden" name="user_id" value="<%= request.getParameter("user_id") %>">
        <input type="hidden" name="nickname" value="<%= request.getParameter("nickname") %>">
        <textarea name="content" rows="5" cols="50"></textarea><br>
        <input type="submit" value="댓글 등록">
    </form>
</body>
</html>
