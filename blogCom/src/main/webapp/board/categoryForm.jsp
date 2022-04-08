<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<% 

/*
boardList 
1) categoryName null일떄
SELECT category_name, board_title, create_date FROM board
ORDER BY create_date DESC
LIMIT 0, 10;

2) categoryName null아닐때
SELECT category_name, board_title, create_date FROM board
WHERE category_name =?
ORDER BY create_date DESC
LIMIT 0, 10;
?<-- categoryName값
*/
	
	String categoryName = request.getParameter("categoryName"); //categoryName 불러오기
 
	System.out.println(request.getParameter("categoryName") + " :선택한 카테고리"); //선택한 카테고리 정보
	
	//mariadb 드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩"); //드라이버로딩 디버깅
	
	/*
		--category쿼리문--
		"SELECT category_name categoryName, COUNT(*) cnt
		FROM board GROUP BY 
		category_name;"
	*/
	
	//mariadb 접속
	Connection conn = null; // conn 값 변수로두고 받기
	String dburl ="jdbc:mariadb://localhost:3306/blog";
	String dbuser ="root";
	String dbpw ="java1234";
	conn = DriverManager.getConnection(dburl,dbuser,dbpw); //접속 수정에 편함
	System.out.println( conn + "<--conn"); //디버깅코드
	
	//쿼리 저장
	String categorySql ="SELECT category_name categoryName, COUNT(*) cnt FROM board GROUP BY category_name;"; //쿼리문 변수에 저장
	PreparedStatement categoryStmt = conn.prepareStatement(categorySql); //저장된 쿼리문 대입
	System.out.println(categoryStmt + " <--categoryStmt"); // 디버깅
	
	//쿼리 실행문
	ResultSet categoryRs = categoryStmt.executeQuery();
	//vo로 저장할수 없음 -> HashMap 사용
	ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
	while(categoryRs.next()) {
		HashMap<String,Object> map = new HashMap<String, Object>();
		map.put("categoryName",categoryRs.getString("categoryName")); //카테고리이름 
		map.put("cnt",categoryRs.getInt("cnt")); //개시글 개수
		categoryList.add(map);
	}
	

	//board 작성
	String boardSql = null;	//쿼리문 넣을 변수
	PreparedStatement boardStmt = null; // stmt 변수
	
	
	if(categoryName == null) { //categoryName 이 null일때
		boardSql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board ORDER BY create_date DESC LIMIT 0, 10;";
		boardStmt = conn.prepareStatement(boardSql);
	} else { //categoryName이 null이 아닐때
		boardSql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board WHERE category_name =? ORDER BY create_date DESC LIMIT 0, 10;";
		boardStmt = conn.prepareStatement(boardSql); //선택한 쿼리문 Stmt 변수에 저장
		boardStmt.setString(1,categoryName);
	}
	System.out.println( boardSql + " <--선택한 쿼리문"); //쿼리문 확인
	System.out.println(boardStmt + " <--boardStmt확인"); //디버깅
	
	//쿼리 실행문
	ResultSet boardRs = boardStmt.executeQuery(); //boardRs에 결과값담기
	
	//ResultSet -> ArrayList<Board> 변경
	ArrayList<Board> boardList = new ArrayList<Board>(); 
	while(boardRs.next()) {
		Board board = new Board();
		board.setBoardNo(boardRs.getInt("boardNo"));
		board.setCategoryName(boardRs.getString("categoryName"));
		board.setBoardTitle(boardRs.getString("boardTitle"));
		board.setCreateDate(boardRs.getString("createDate"));
		boardList.add(board);
	}
	
	conn.close(); //connection 객체 반납
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>
<style type="text/css">
		table, td {border : 1px solid #000000;}
</style>
</head>
<body>
	<!-- category별 게시글 링크 메뉴 -->
	<div>
		<ul>
			<% 
				for(HashMap<String,Object> m : categoryList) { //HashMap으로받았으니까 바꾸기
			%>
					<li> <!-- request.getContextpath()는  -->
						<a href="<%=request.getContextPath()%>/boardList.jsp?categoryName=<%=m.get("categoryName")%>"><%=m.get("categoryName")%>(<%=m.get("cnt")%>)</a>
					</li>
			<%
				}
			%>
		</ul>
	</div>
	<table>
		<thead>
			<tr>
				<td>boardNo</td>
				<td>categoryName</td>
				<td>boardTitle</td>
				<td>createDate</td>
			</tr>
		</thead>
		</tbody>
			<%
				for(Board b : boardList) {
			%>
					<tr>
						<td><%=b.getBoardNo()%></td>
						<td><%=b.getCategoryName()%></td>
						<td><%=b.getBoardTitle()%></td>
						<td><%=b.getCreateDate()%></td>
					</tr>
			<%
				}
			%>
		</tbody>
	</table>
</body>
</html>