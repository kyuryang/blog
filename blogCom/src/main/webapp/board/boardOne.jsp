<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%
	String boardNo = request.getParameter("boardNo"); // boardNo값 받아오기
	// 디버깅 코드
	System.out.println(boardNo + "<--boardNo");
	
	//0) 마리아 db 드라이버 
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩 성공");
		
	//1) 계정 로그인
	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소저장
	String dbuser = "root"; // 아이디 저장
	String dbpw = "java1234"; // 비번 저장
	conn = DriverManager.getConnection(dburl,dbuser,dbpw);
	System.out.println(conn+"<--conn"); // 디버깅
	
	//---------------------------------------------------------------------------------------------
	//목록 받아오기
	
	// select문 문자열로 변수에 저장
	String categorySql = "select category_name categoryName, COUNT(*) cnt from board group by category_name";  // category_name과 목차별 합계(cnt)
	
	PreparedStatement categoryStmt = conn.prepareStatement(categorySql); // categoryStmt에 저장한 쿼리 실행
	System.out.println(categoryStmt + "<--categoryStmt"); // 디버깅

	ResultSet categoryRs = categoryStmt.executeQuery(); // stmt에서 실행한 쿼리결과값 categoryRs에 저장 
	System.out.println(categoryRs + "<--categoryRs"); // 디버깅

	// result 값  arraylist에 넣기
	ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>> (); // category전체 리스트 저장하기 위한 arraylist 만들기
	while(categoryRs.next()) { // 돌리면서 true 값일때마다 categoryRs에 저장 
		HashMap<String, Object> map = new HashMap<String, Object> ();
		map.put("categoryName",categoryRs.getString("categoryName"));
		map.put("cnt", categoryRs.getInt("cnt"));
		categoryList.add(map);
	}
	
	// ---------------------------------------------------------------------------------------------
	//boardOne
	
	String boardOneSql = "select board_no boardNo, category_name categoryName, board_title boardTitle, board_content boardContent, board_pw boardPw, create_date createDate, update_date updateDate from board WHERE board_no = ? order by create_date desc limit 0,10";
	PreparedStatement stmt = conn.prepareStatement(boardOneSql);
	stmt.setString(1,boardNo); // 요청받아온 boardNo값 넣기
	
	ResultSet boardOneRs = stmt.executeQuery(); // boardOneRs boardSql 쿼리로 들고온 값 저장
	System.out.println(boardOneRs + "<--boardOneRs"); // 디버깅
	
	Board board = null;
	if(boardOneRs.next()) { // true값일때만 커서 옮기면서
		board = new Board(); // board값 담을 새로운 리스트 생성
		board.setBoardNo(boardOneRs.getInt("boardNo"));
		board.setCategoryName(boardOneRs.getString("categoryName"));
		board.setBoardTitle(boardOneRs.getString("boardTitle"));
		board.setBoardContent(boardOneRs.getString("boardContent"));
		board.setCreateDate(boardOneRs.getString("createDate"));
		board.setUpdateDate(boardOneRs.getString("updateDate"));
	}


	conn.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
		<div class="containerfluid" align="center">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	</div>
			<div class="mt-4 p-5 bg-info text-dark rounded container-fluid text-center">
				<h1>board 상세보기</h1>
			</div>
	<!-- category별 게시글 링크 메뉴 -->
		<div class=".container-fluid">
			<div class="row">
				<div class="col-3" >
					<ul class="list-group list-group-flush">
						<%
							for(HashMap<String, Object> m : categoryList) { 
						%>
						<li class="list-group-item text-body">
							<a href = "<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>"><%=m.get("categoryName")%>(<%=m.get("cnt") %>)</a> 
						</li>
					<%	
						}
					%>
				</ul>
			</div>
			<div class="col-8">
			<table class="table table-hover table-dark">
				<tr>
					<td>boardNo</td>
					<td><%= board.getBoardNo()%></td>
				</tr>
				<tr>
				<td>categoryNo</td>
				<td><%= board.getCategoryName() %></td>
			</tr>	
			<tr>
				<td>boardTitle</td>
				<td><%= board.getBoardTitle()%></td>
			</tr>
			<tr>
				<td>boardContent</td>
				<td><%= board.getBoardContent()%></td>
			</tr>
			<tr>
				<td>createDate</td>
				<td><%= board.getCreateDate()%></td>
			</tr>
			<tr>
				<td>updateDate</td>
				<td><%= board.getUpdateDate()%></td>
			</tr>
		</table>
 	   <div class="container  col-3" >	
 	   		<ul class="pagination">
				<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/board/updateBoardForm.jsp?boardNo=<%= board.getBoardNo()%>">수정</a></li>
				<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/board/deleteBoardForm.jsp?boardNo=<%= board.getBoardNo()%>">삭제</a></li>
			</ul>
    	</div>
    	</div>
   	</div>
   	</div>
</body>
</html>