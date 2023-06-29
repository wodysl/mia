<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>

<%
request.setCharacterEncoding("UTF-8");

// 데이터베이스 연결 정보
String server = "172.16.100.32:3306";
String username = "root";
String password = "1234";
String database = "mia";
String url = "jdbc:mysql://" + server + "/" + database;

// 이미지 업로드 설정
String uploadDir = "/var/lib/tomcat/webapps/ROOT/MIA/admin/ch_img"; // 이미지 업로드 경로
int maxFileSize = 8 * 1024 * 1024; // 8MB
String encoding = "UTF-8";
DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();

// MultipartRequest를 사용하여 파일 업로드 처리
MultipartRequest multi = new MultipartRequest(request, uploadDir, maxFileSize, encoding, policy);

// 챔피언 정보 추출
String ch_name = multi.getParameter("ch_name");
int tier = Integer.parseInt(multi.getParameter("tier"));
String ch_img = "";
File savedFile = multi.getFile("ch_img");
if (savedFile != null) {
	// 이미지 파일명 중복 처리
	String originalFilename = multi.getOriginalFileName("ch_img");
	String fileExt = originalFilename.substring(originalFilename.lastIndexOf("."));
	String baseFileName = originalFilename.substring(0, originalFilename.lastIndexOf("."));

	// 중복 방지를 위한 숫자 추가
	int count = 0;
	String uniqueFileName = baseFileName + fileExt;
	File uploadedFile = new File(uploadDir, uniqueFileName);
	while (uploadedFile.exists()) {
	    count++;
	    if (count == 1) {
	        uniqueFileName = baseFileName + fileExt;
	    } else {
	        uniqueFileName = baseFileName + "_" + count + fileExt;
	    }
	    uploadedFile = new File(uploadDir, uniqueFileName);
	}

	if (!savedFile.renameTo(uploadedFile)) {
	    // 파일 이동에 실패한 경우
	    out.println("이미지 파일 이동에 실패했습니다.");
	    return;
	}

	ch_img = uniqueFileName; // 이미지 파일명
}

float win = 0;
if (multi.getParameter("win") != null && !multi.getParameter("win").isEmpty()) {
    win = Float.parseFloat(multi.getParameter("win"));
}
float ben = 0;
if (multi.getParameter("ben") != null && !multi.getParameter("ben").isEmpty()) {
    ben = Float.parseFloat(multi.getParameter("ben"));
}
float pick = 0;
if (multi.getParameter("pick") != null && !multi.getParameter("pick").isEmpty()) {
    pick = Float.parseFloat(multi.getParameter("pick"));
}

// 데이터베이스 연결
Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
try {
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(url, username, password);

    // 현재 챔피언 번호 조회
    int ch_no = 0;
    String selectQuery = "SELECT MAX(ch_no) FROM champion";
    pstmt = con.prepareStatement(selectQuery);
    rs = pstmt.executeQuery();
    if (rs.next()) {
        ch_no = rs.getInt(1) + 1; // 마지막 ch_no 값에 1을 더하여 다음 순번 설정
    }
    // 챔피언 정보 삽입 쿼리
    String insertQuery = "INSERT INTO champion (ch_no, ch_name, tier, ch_img, win, ben, pick) VALUES (?, ?, ?, ?, ?, ?, ?)";
    pstmt = con.prepareStatement(insertQuery);
    pstmt.setInt(1, ch_no);
    pstmt.setString(2, ch_name);
    pstmt.setInt(3, tier);
    pstmt.setString(4, ch_img);
    pstmt.setFloat(5, win);
    pstmt.setFloat(6, ben);
    pstmt.setFloat(7, pick);

    pstmt.executeUpdate();

    out.println("챔피언이 추가되었습니다.");

    // 3초 후에 championList.jsp로 이동
    response.setHeader("Refresh", "3;URL=championList.jsp");
} catch (Exception e) {
    e.printStackTrace();
} finally {
    if (rs != null) {
        try {
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    if (pstmt != null) {
        try {
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    if (con != null) {
        try {
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
%>
