<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%
//boardList페이지 실행하면 최근 10개의 목록을 보여주고 1페이지 1page로 설정
int currentPage = 1; //현재페이지의 기본값이 1페이지
if (request.getParameter("currentPage") != null) { //이전,다음 링크를 통해서 들어왔다면 
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}
System.out.println(currentPage + "<-- currentPage");
// 페이지가 바뀌면 데이터도 바뀌어야 한다.
/*
	알고리즘 
	select .... limit 0,10"
	1page -> 0
	2page -> 11
	
	?	<--(currentpage-1) *10

*/

int rowPerPage = 10;
int beginRow = (currentPage - 1) * rowPerPage;

String categoryName = "";
if (request.getParameter("categoryName") != null) {
	categoryName = request.getParameter("categoryName");

}

Class.forName("org.mariadb.jdbc.Driver");
Connection conn = null;
String dburl = "jdbc:mariadb://localhost:3306/blog";
String dbuser = "root";
String dbpw = "java1234";
conn = DriverManager.getConnection(dburl, dbuser, dbpw);
System.out.println(conn + " <-- conn");
/*
	SELECT category_name categoryName, COUNT(*) cnt
	FROM board
	GROUP BY category_name
*/
String categorySql = "SELECT category_name categoryName, COUNT(*) cnt FROM board GROUP BY category_name";
PreparedStatement categoryStmt = conn.prepareStatement(categorySql);
ResultSet categoryRs = categoryStmt.executeQuery();

// 쿼리에 결과를 Category, Board VO로 저장할 수 없다. -> HashMap을 사용해서 저장하자!
ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
while (categoryRs.next()) {
	HashMap<String, Object> map = new HashMap<String, Object>();
	map.put("categoryName", categoryRs.getString("categoryName"));
	map.put("cnt", categoryRs.getInt("cnt"));
	categoryList.add(map);
}

// boardList
String boardSql = null;
PreparedStatement boardStmt = null;
if (categoryName.equals("")) {
	boardSql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board ORDER BY create_date DESC LIMIT ?, ?";
	boardStmt = conn.prepareStatement(boardSql);
	boardStmt.setInt(1, beginRow);
	boardStmt.setInt(2, rowPerPage);
} else {
	boardSql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board WHERE category_name =? ORDER BY create_date DESC LIMIT ?, ?";
	boardStmt = conn.prepareStatement(boardSql);
	boardStmt.setString(1, categoryName);
	boardStmt.setInt(2, beginRow); //현재페이지가 변경되면 데이터도 변경된다!  카테고리 네임도 같이넘어가야된다..(그냥 다음 클릭시 카테고리가 짬뽕됨) 
	//버그 문제 <---- 문제인식  이슈
	boardStmt.setInt(3, rowPerPage);
}
ResultSet boardRs = boardStmt.executeQuery();
ArrayList<Board> boardList = new ArrayList<Board>();
while (boardRs.next()) {
	Board b = new Board();
	b.setBoardNo(boardRs.getInt("boardNo"));
	b.setCategoryName(boardRs.getString("categoryName"));
	b.setBoardTitle(boardRs.getString("boardTitle"));
	b.setCreateDate(boardRs.getString("createDate"));
	boardList.add(b);
}

int totalRow = 0; // select count(*) from board;
String totalRowSql = "SELECT COUNT(*) cnt FROM board";
PreparedStatement totalRowStmt = conn.prepareStatement(totalRowSql);
ResultSet totalRowRs = totalRowStmt.executeQuery();
if (totalRowRs.next()) {
	totalRow = totalRowRs.getInt("cnt");
	System.out.println(totalRow + " <-- totalRow(1000)");
}

int lastPage = 0;
if (totalRow % rowPerPage == 0) {
	lastPage = totalRow / rowPerPage;
} else {
	lastPage = (totalRow / rowPerPage) + 1;
}
conn.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">

<style>
	bt {
		display:grid;
	}

</style>
</head>
<body>
	<div class="containerfluid" align="center">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	</div>
	<div class="mt-4 p-5 bg-info text-dark rounded text-center">
		<h1>
			게시글 목록(total :
			<%=totalRow%>)
		</h1>
	</div>
	<!-- category별 게시글 링크 메뉴 -->
	<div class=".container-fluid">
		<div class="row">
			<div class="col-3">
				<ul class="list-group list-group-flush">
					<%
					for (HashMap<String, Object> m : categoryList) {
					%>
					<li class="list-group-item text-body"><a
						href="<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>"><%=m.get("categoryName")%>(<%=m.get("cnt")%>)</a>
					</li>
					<%
					}
					%>
				</ul>
			</div>
			<!-- 게시글 리스트 -->
			<div class="col-8">
				<a class="page-link"
					href="<%=request.getContextPath()%>/board/insertBoardForm.jsp">게시글
					추가</a>
				<table class="table table-hover table-dark ">

					<thead>
						<tr>
							<th>categoryName</th>
							<th>boardTitle</th>
							<th>createDate</th>
						</tr>
					</thead>
					<tbody>
						<%
						for (Board b : boardList) {
						%>
						<tr>
							<td><%=b.getCategoryName()%></td>
							<td><a
								href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.getBoardNo()%>"><%=b.getBoardTitle()%></a></td>
							<td><%=b.getCreateDate()%></td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
				<div class="container  col-6" >	
					<ul class="pagination">
					
						<!-- 페이지가 만약 10페이지였으면 이전을 누르면 9페이지가 되고 다음을 누르면 11페이지 -->
						
																	<!--  마지막 페이지 ? 
									10개			 1
									11,12,13~20  2
									21~30 		 3
									31~40		 4
									
									마지막 페이지 = 전체행 /rowPerPage
								 -->
						<%
						if (currentPage > 1) { //현재페이지가 1이면 이전페이지가 존재해서는 안된다.
						%>

						<li class="page-item"><a class="page-link .active " id="bt"  href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage - 1%>&categoryName=<%=categoryName%>">  이전  </a></li>
						<%
						}
						%>

						<%
						for (int i = 1; i < lastPage; i++) {			//1~부터 라스트페이지까지 10개씩 끊어서 출력
							if ((((currentPage / 10) + 1) * 10 -1) >= i && i >= ((currentPage / 10) * 10)) {
						%>
						<li class="page-item"><a class="page-link .active " href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=i%>"><%=i%></a></li>
						<%
						}
						}
						%>
						<%
						if (currentPage < lastPage) {
						%>
						<li class="page-item"><a class="page-link active row" href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage + 1%>&categoryName=<%=categoryName%>">다음</a>
						</li>
						<%
						}
						%>
					</ul>
					<div>
						현재 페이지 :<%=currentPage%>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>