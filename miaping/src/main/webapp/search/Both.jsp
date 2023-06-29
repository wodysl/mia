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
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	request.setCharacterEncoding("utf-8");

	String puuid = request.getParameter("puuid");
	System.out.println("puuuuu : "+puuid);
	
	String key = "RGAPI-5a303f1a-7d55-4937-9321-4d4b528f14de";
	String result = "";
	
	URL url = new URL("https://asia.api.riotgames.com/lol/match/v5/matches/by-puuid/"+puuid+"/ids?start=0&count=20&api_key="+key);
	
	BufferedReader bf;
	
	bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
	result = bf.readLine();
	
	System.out.println(result);
	
	JSONParser jsonParser = new JSONParser();
    
   	JSONArray arr = (JSONArray)jsonParser.parse(result);
   	String league [] = new String[arr.size()];
   	
   	URL Url [] = new URL[arr.size()];
   	String win [] = new String[arr.size()];
   	
   	String color [] = new String[arr.size()];
   	String lane [] = new String[arr.size()];
   	String championName [] = new String[arr.size()];
   	Double kda [] = new Double[arr.size()];
   	int kills [] = new int[arr.size()];
   	int deaths [] = new int[arr.size()];
   	int assists [] = new int[arr.size()];
   	int item [][] = new int[arr.size()][7];
    Long gameStartTimestamp [] = new Long[arr.size()];
    
    String true_name [][] = new String[arr.size()][5];
    String true_championName [][] = new String[arr.size()][5];
    String false_name [][] = new String[arr.size()][5];
    String false_championName [][] = new String[arr.size()][5];
   
   	for(int i=0;i<arr.size();i++){
   	    int true_index = 0;
   	    int false_index = 0;
		league[i] = (String)arr.get(i);

	    Url[i] = new URL("https://asia.api.riotgames.com/lol/match/v5/matches/"+league[i]+"?api_key="+key);

	    bf = new BufferedReader(new InputStreamReader(Url[i].openStream(), "UTF-8"));
		result = "";
	    result = bf.readLine();
	    
	    System.out.println("both result : "+result);
	    
	    jsonParser = new JSONParser();
	    JSONObject jsonObject = (JSONObject)jsonParser.parse(result);
	   	
	    JSONObject jsonObject2 = (JSONObject)jsonObject.get("info");
	    gameStartTimestamp[i] = Long.parseLong(String.valueOf(jsonObject2.get("gameStartTimestamp")));
	   	
	    JSONArray jsonArray = (JSONArray)jsonObject2.get("participants");
	   	
	   	for(int j=0;j<jsonArray.size();j++){
			JSONObject tmp = (JSONObject)jsonArray.get(j);//인덱스 번호로 접근해서 가져온다.
			JSONObject tmp2 = (JSONObject)tmp.get("challenges");//인덱스 번호로 접근해서 가져온다.
			
			String puuid2 = (String)tmp.get("puuid");
			System.out.println("puuid2222 : "+puuid2);
			if(puuid2.equals(puuid)){
				Boolean winn = (Boolean)tmp.get("win");
				kills[i] = Integer.parseInt(String.valueOf(tmp.get("kills")));
				deaths[i] = Integer.parseInt(String.valueOf(tmp.get("deaths")));
				assists[i] = Integer.parseInt(String.valueOf(tmp.get("assists")));
				win[i] = String.valueOf(winn);
				kda[i] = Double.parseDouble(String.valueOf(tmp2.get("kda")));
				lane[i] = (String)tmp.get("lane");
				championName[i] = (String)tmp.get("championName");
				if(winn){
					color[i] = "green";
				}
				else{
					color[i] = "red";
				}
				
				for(int k=0 ; k<7 ; k++){
					String str = "item"+k;
					item[i][k] =  Integer.parseInt(String.valueOf(tmp.get(str)));
				}
				/* break; */
			}
			Boolean winn = (Boolean)tmp.get("win");
			if(winn){
				true_name[i][true_index] = (String)tmp.get("summonerName");
				true_championName[i][true_index] = (String)tmp.get("championName");
				true_index += 1;
			}
			else{
				false_name[i][false_index] = (String)tmp.get("summonerName");
				false_championName[i][false_index] = (String)tmp.get("championName");
				false_index += 1;
			}
			
		}

		System.out.println("----- "+i+"번째 인덱스 값 -----");
		System.out.println("wins : "+win[i]);
	}
   	
  
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" href="../css/search/Both.css">
</head>
<body>

<table class="fixed_headers">
 <!--  <thead>
    <tr>
      <th></th>
      <th>아이템</th>
      <th></th>
      <th>승패</th>
      <th>KDA</th>
    </tr>
  </thead> -->
  <tbody>
  
  <%
  for(int i=0 ; i<arr.size() ; i++){
	  String win_view = "";
	  String type = "";
	  if(win[i].equals("true")){
		  win_view = "승리";
	  }
	  else{
		  win_view = "패배";
	  }
	// Unix 타임스탬프를 Date 객체로 변환하기
	  Date date = new Date(gameStartTimestamp[i]);

	  // SimpleDateFormat을 사용하여 날짜와 시간 형식 지정하기
	  SimpleDateFormat formatter = new SimpleDateFormat("MM/dd");
	  String formattedDate = formatter.format(date);

	  System.out.println(formattedDate);
  %>
  
    <tr style="background-color: <%= color[i] %>;">
      <td id="start"><%= formattedDate %></td>
      <td><img src="https://opgg-static.akamaized.net/meta/images/lol/champion/<%= championName[i] %>.png" alt=""></td>
      <td>
      <%
      for(int j=0 ; j<7 ; j++){
      %>
      <img src="https://opgg-static.akamaized.net/meta/images/lol/item/<%= item[i][j] %>.png" alt="" id="small">
      <%
      }
      %>
	  </td>
      <td><%= win_view %></td>
      <%
      String kda_str = String.format("%.2f", kda[i]);
      
      %>
      <td><%= kills[i] %> / <%= deaths[i] %> / <%= assists[i] %><br>(<%= kda_str %>)</td>
      <td id="end">
	      <%
	      for(int j=0 ; j<5 ; j++){
	      %>
	      <img src="https://opgg-static.akamaized.net/meta/images/lol/champion/<%= true_championName[i][j] %>.png" alt="" id="cham"><span id="true_name"><%= true_name[i][j] %></span>
	      <img src="https://opgg-static.akamaized.net/meta/images/lol/champion/<%= false_championName[i][j] %>.png" alt="" id="cham"><span><%= false_name[i][j] %></span>
	      <br>
	      <%
	      }
	      %>
      </td>
    </tr>
    <tr id="margin"></tr>
  <%
  }
  %>
  </tbody>
</table>
</body>
</html>