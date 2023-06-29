<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<link rel="stylesheet" href="../css/board/Write.css">
<link rel="stylesheet" href="../css/board/Sidebar.css">
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="jquery-3.6.0.min.js"></script>
<script>

$(document).ready(function(){
	$("#gameid").hide();
})

function changeFile(){
	var fileName = $("#img").val().split('/').pop().split('\\').pop();
	  $(".upload-name").val(fileName);   
}

function changeSelect(){
    var langSelect = document.getElementById("category");
     
    // select element에서 선택된 option의 value가 저장된다.
    var selectValue = langSelect.options[langSelect.selectedIndex].value;
    
    if(selectValue=="userf"){
    	$("#imgfile").hide();
    	$("#gameid").show();
    }else{
    	$("#imgfile").show();
    	$("#gameid").hide();
    }
    
}
</script>
</head>
<body>
	<div class="container">
		<div class="left">
			<div class="login"><button class="lgbtn" onclick="location.href='../member/Login.jsp'">로그인</button></div>
			<div class="sidebar">
			<h3 class="lb">커뮤니티</h3>
				<ul>
					<li><a href="Hotlist.jsp">인기</a></li>
					<li><a href="Newlist.jsp">최신</a></li>
					<li><a href="Freelist.jsp">자유</a></li>
					<li><a href="Humorlist.jsp">유머</a></li>
					<li><a href="Userlist.jsp">유저 찾기</a></li>
				</ul>
			</div>
		</div>
		<div class="center">
		<div class="write_title">
			<h3>글쓰기</h3>
		</div>
			<form action="Write_regi.jsp" method="post" enctype="multipart/form-data">
				<div class="form">
					<div class="select">
					<select id="category" name="category" onchange="changeSelect()">
						<option value="" selected disabled>커뮤니티 선택</option>
						<option value="free">자유</option>
						<option value="humor">유머</option>
						<option value="userf">유저 찾기</option>
					</select>
					</div>
					<div class="gameid" id="gameid">
						<input type="text" id="gameid" name="gameid" placeholder="소환사 아이디">
					</div>
					<div class="title">
						<input type="text" id="title" name="title" placeholder="제목" required>
					</div>
					<div class="content">
						<textarea id="content" name="content" required></textarea>
					</div>
					<div class="file" id="imgfile">
						<input type="text" class="upload-name" id="img_name" name="img_name" value="" placeholder="첨부파일">
    					<label for="img">파일찾기</label> 
						<input type="file" id="img" name="img" accept="image/png, image/jpeg" onchange="changeFile()">
					</div>
					<div class="submit">
						<input type="submit" class="subbtn" value="작성">
					</div>
					<div class="cancle">
						<input type="button" class="canbtn" value="취소" onClick="history.go(-1)">
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>