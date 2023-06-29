<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONValue" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.nio.charset.*" %>
<%@ page import="org.json.*" %>
<%
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	String key = "RGAPI-5a303f1a-7d55-4937-9321-4d4b528f14de";
    String result = "";
    
    URL url = new URL("https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/"+name+"?api_key="+key);

    BufferedReader bf;

    bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));

    result = bf.readLine();
    
    System.out.println(result);
    
    
    JSONParser jsonParser = new JSONParser();
    JSONObject jsonObject = (JSONObject)jsonParser.parse(result);
    
    String id = (String)jsonObject.get("id");
    int profileIconId = Integer.parseInt(String.valueOf(jsonObject.get("profileIconId")));
    String puuid = (String)jsonObject.get("puuid");
    System.out.println("puuid : "+puuid);
    
   //------------------------------------------------2번째 ---------------------------
    
    URL url2 = new URL("https://kr.api.riotgames.com/lol/league/v4/entries/by-summoner/"+id+"?api_key="+key);

    bf = new BufferedReader(new InputStreamReader(url2.openStream(), "UTF-8"));
	result = "";
    result = bf.readLine();
    System.out.println("22 : "+result);
    
    JSONParser jsonParser2 = new JSONParser();
    
   	JSONArray arr = (JSONArray)jsonParser2.parse(result);
   	String tier [] = new String[arr.size()];
   	int lp [] = new int[arr.size()];
   	String rank [] = new String[arr.size()];
    int wins = 0;
    int losses = 0;
    float sum_wins = 0;
    float sum_losses = 0;
    
   	for(int i=0;i<arr.size();i++){
		JSONObject tmp = (JSONObject)arr.get(i);//인덱스 번호로 접근해서 가져온다.
		tier[i] = (String)tmp.get("tier");
		rank[i] = (String)tmp.get("rank");
		wins = Integer.parseInt(String.valueOf(tmp.get("wins")));
		losses = Integer.parseInt(String.valueOf(tmp.get("losses")));
		lp[i] = Integer.parseInt(String.valueOf(tmp.get("leaguePoints")));
		
		sum_wins += wins;
		sum_losses += losses;
		
		System.out.println("----- "+i+"번째 인덱스 값 -----");
		System.out.println("tier : "+tier);
	}

    double odds = sum_wins/(sum_wins+sum_losses);
    int odds_int = (int)(odds*100);

%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" href="../css/search/Search_act.css">
  <script src="jquery-3.6.0.min.js"></script>
  <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
</head>
<body>
<!-- nav -->
<nav class="sidebar">
  <div class="nav-header">
    <div class="logo-wrap">
      <a class="logo-text" href="#">MIAPING</a>
    </div>

    <div class="nav-search">
      <div class="search">
        <!-- <i class="material-icons">search</i> -->
        <input type="search" name="search" placeholder="Search">
      </div>
    </div>
  </div>
  <ul class="nav-categories ul-base">
    <li><a href="http://www.mediahawkz.com/topic/technology">Technology</a></li>
    <li><a href="http://www.mediahawkz.com/topic/science">Science</a></li>
    <li><a href="http://www.mediahawkz.com/topic/speak-up">Speak up</a></li>
    <li><a href="http://www.mediahawkz.com/topic/general">General</a></li>
    <li><a href="http://www.mediahawkz.com/topic/lifestyle">Lifestyle</a></li>
    <li><a href="http://www.mediahawkz.com/topic/world">World</a></li>
    <li><a href="http://www.mediahawkz.com/topic/business">Business</a></li>
    <li><a href="http://www.mediahawkz.com/topic/entertainment">Entertainment</a></li>
    <li><a href="http://www.mediahawkz.com/topic/sports">Sports</a></li>
  </ul>
  <div class="copyright">
    <span>&copy; 2023 <a href="#" class="link">Project</a> Made in 이동건 신재연 김지영</span>
    <span>Designed by <a href="#" target="_blank">Ravikumar Chauhan</a></span>
  </div>
</nav><!-- @end nav -->

<!-- header -->
<header>
  <div class="header-inner clearfix">
    <div class="nav-btn nav-slider">
      <i class="material-icons">MENU</i>
    </div>
    <div class="header-logo">
      <a href="http://www.mediahawkz.com/"><img src="" alt=""></a>
    </div>
    <div class="header-categories">
      <ul class="ul-base">
        <li class="dropdown">
          <a class="dropdown-toggle" href="../Main.jsp"><span>MAIN</span></a>
        </li>
      </ul>
    </div>
    <div class="header-search">
      <form action="./Search_act.jsp" method="post">
        <div class="search">
          <button type="submit">search</button>
          <input type="search" name="name" placeholder="">
        </div>
      </form>
    </div>
    <div class="header-menu">
      <ul class="ul-base">
      <% 
				String idd = (String)session.getAttribute("id");
				String nick = (String)session.getAttribute("nick");
				
				if(idd==null){
			%>
				<li><a href="../member/Sign.jsp">회원가입</a></li>
       			<li><a href="../member/Login.jsp">로그인</a></li>
			<%
				}else{
			%>
				<li><a href="../member/Logout.jsp">로그아웃</a></li>
			<%
				}
			%>
        
      </ul>
    </div>
    
  </div>
</header><!-- @end header -->

<!-- Main content -->
<main role="main">
  <div class="information">
  <img src="https://opgg-static.akamaized.net/meta/images/profile_icons/profileIcon<%= profileIconId %>.jpg" alt="">
    <h1><%= name %></h1>
    <h2><img id="tier" src="https://opgg-static.akamaized.net/images/medals_new/<%= tier[arr.size()-1] %>.png?image=q_auto,f_webp,w_144&v=1687932539766">  <%= tier[arr.size()-1] %> <%= rank[arr.size()-1] %></h2>
    <h3><%= lp[arr.size()-1] %>LP</h3>
    <h4>승률 <%= odds_int %>%(<%= (int)sum_wins %>승 <%= (int)sum_losses %>패)</h4>
  </div>
  <div class="side">
    <ul class="navi">
      <li><a href="#" target="search">종합</a></li>
      <li><a href="#" target="search">챔피언</a></li>
  </ul>
  </div>
  <p>&nbsp;</p>
  <hr>

  <!-- <div id="view"> -->
     <iframe src="./All.jsp?puuid=<%= puuid %>" frameborder="0" width="90%" height="100%" name="search" scrolling="no"></iframe>
  <!-- </div> -->

</main><!-- @end main -->

<!-- Footer -->
<footer></footer><!-- @end footer -->
<!-- 
<div class="overlay"></div> -->
</body>
<script type="text/javascript" src="../js/search/Search.js"></script>
</html>
