<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%
	String tempPage = request.getParameter("page");
	String listType = request.getServletPath();
	
	int cPage = 0;
	int len = 15;
	int pageLength = 5;
	int start = 0;
	
	// 시작 페이지 예외처리
	if(tempPage==null || tempPage.length()==0){
		cPage = 1;
	}
	
	// 시작 페이지 지정
	try{
		cPage = Integer.parseInt(tempPage);
	}catch(NumberFormatException e){
		cPage = 1;
	}
	
	Connection con = null;
	PreparedStatement PS = null;
	ResultSet RS = null;
	String query = "";
	int totalRows = 0;
	String condition = "";
	
	try{
		//maraidb 정보입력 시작 
		String server = "172.16.100.32:3306";
		String username = "root";
		String pwd = "1234";
		String database = "mia";
		String url = "jdbc:mysql://" + server + "/" + database;
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(url, username, pwd);
		
		
		
		if(listType.equals("/MIA/board/Hotlist.jsp")){
			query = "select count(board_id) from board where good>50";
		}else if(listType.equals("/MIA/board/Newlist.jsp")){
			query = "select count(board_id) from board";
		}else if(listType.equals("/MIA/board/Freelist.jsp")){
			query = "select count(board_id) from board where category='free'";
		}else if(listType.equals("/MIA/board/Humorlist.jsp")){
			query = "select count(board_id) from board where category='humor'";
		}else if(listType.equals("/MIA/board/Userlist.jsp")){
			query = "select count(board_id) from board where category='userf'";
		}else{
			query = "select count(board_id) from board";
		}
		
		PS = con.prepareStatement(query);
		RS = PS.executeQuery();
		
		while(RS.next()){ //전체 데이터 개수
			totalRows = RS.getInt(1);
		}
	}catch(Exception ErrMsg){
		ErrMsg.printStackTrace();
		out.println("Unfortunately, Database connection failed"+ErrMsg.getMessage());
		
	}
	// 총 페이지 개수 구하기
	int totalPages = totalRows % len == 0 ? totalRows / len : (totalRows / len) + 1;
	
	if(totalPages == 0){
		totalPages = 1;
	}
	if(cPage > totalPages){
		cPage = 1;
	}
	
	// 페이지 처음과 끝을 지정하는 부분
	int currentBlock = cPage % pageLength == 0 ? cPage / pageLength : (cPage / pageLength) + 1;
	int startPage = (currentBlock - 1)*pageLength + 1;
	int endPage = startPage + pageLength - 1;
	
	if(endPage > totalPages){ //마지막 페이지에서 총 페이지 수를 넘어가면 끝 페이지를 마지막으로 지정
		endPage = totalPages;
	}
	
	start = (cPage - 1) * len;
%>