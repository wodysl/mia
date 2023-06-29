<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String idd = (String)session.getAttribute("id");
	String nick = (String)session.getAttribute("nick");

	request.setCharacterEncoding("UTF-8");
	
	String location = "/var/lib/tomcat/webapps/ROOT/MIA/board/uploadImg";
	//String location= request.getServletContext().getRealPath("/uploadimg");
	
	int maxSize = 1024 * 1024 * 5; // 키로바이트 * 메가바이트 * 기가바이트
	
	MultipartRequest multi = new MultipartRequest(request,
		      location,
			  maxSize,
			  "utf-8",
			  new DefaultFileRenamePolicy());
	

	String category = multi.getParameter("category");
	String gameid = multi.getParameter("gameid");
	String title = multi.getParameter("title");
	String content = multi.getParameter("content");
	String img = multi.getParameter("img_name");
	Enumeration<?> files = multi.getFileNames();
	

			Connection con = null;
			PreparedStatement PS = null;
			int RS = 0;
			
			try{
				//maraidb 정보입력 시작 
				String server = "172.16.100.32:3306";
				String username = "root";
				String pwd = "1234";
				String database = "mia";
				String url = "jdbc:mysql://" + server + "/" + database;
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(url, username, pwd);
				
				if(category.equals("userf")){ //유저찾기
					String query = "insert into board(user_id,nickname,title,contents,game_id,category) values(?,?,?,?,?,?);";
					PS = con.prepareStatement(query);
					PS.setString(1, idd);
					PS.setString(2, nick);
					PS.setString(3, title);
					PS.setString(4, content);
					PS.setString(5, gameid);
					PS.setString(6, category);
					
					RS = PS.executeUpdate();
					
				}else{ // 파일 입력 폼이 있는 게시글
					String element = "";
					String filesystemName = "";
					String originalFileName = "";
					String contentType = "";
					long length = 0;		
							
					if (!(img.isEmpty())) { // 다음 정보가 있으면 Like rs.next()
								
						element = (String)files.nextElement(); // file을 반환
								
						filesystemName 			= multi.getFilesystemName(element); // 서버에 업로드된 파일명을 반환
						originalFileName 		= multi.getOriginalFileName(element); // 사용자가 업로드한 파일명을 반환
						contentType 			= multi.getContentType(element);	// 업로드된 파일의 타입을 반환 
						length 					= multi.getFile(element).length(); // 파일의 크기를 반환 (long타입)
						
						String query = "insert into board(user_id,nickname,title,contents,board_img,category) values(?,?,?,?,?,?);";
						PS = con.prepareStatement(query);
						PS.setString(1, idd);
						PS.setString(2, nick);
						PS.setString(3, title);
						PS.setString(4, content);
						PS.setString(5, filesystemName);
						PS.setString(6, category);
						
						RS = PS.executeUpdate();
					
					}else{ //파일이 없을경우
						
						String query = "insert into board(user_id,nickname,title,contents,category) values(?,?,?,?,?);";
						PS = con.prepareStatement(query);
						PS.setString(1, idd);
						PS.setString(2, nick);
						PS.setString(3, title);
						PS.setString(4, content);
						PS.setString(5, category);
						
						RS = PS.executeUpdate();
					}
					
					
				}
				
				response.sendRedirect("Newlist.jsp");
				
			}catch(Exception e){
				e.printStackTrace();
				out.println("Unfortunately, Database connection failed"+e.getMessage());
			}

	
%>