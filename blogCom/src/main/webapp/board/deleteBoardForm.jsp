<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo")); //boardNo 요청값 가져오기
	System.out.println(boardNo + "<--deleteboardNo 폼"); //boardNo 디버깅
	
	Class.forName("org.mariadb.jdbc.Driver"); //드라이버 로딩
	System.out.println("드라이버 로딩 성공"); //로딩 성공
	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3306/blog"; //url
	String dbuser = "root"; //사용자 계정
	String dbpw = "java1234"; //비밀번호
	conn = DriverManager.getConnection(dburl, dbuser, dbpw); //위의 3개를 변수화하여 db접속
	System.out.println("삭제폼 접속 성공");
	/*public int boardNo;
	public String categoryName;
	public String boardTitle;
	public String boardContent;
	public String boardPw;
	public String createDate;
	public String updateDate;
	*/
	
	String sql = "select board_no boardNo, category_name categoryName,board_title boardTitle,board_pw boardPw from board where board_No=?"; //board테이블의 boardNO,카테고리,board제목,boardPw를 가져오는 쿼리문 작성
	PreparedStatement stmt = conn.prepareStatement(sql); //쿼리문 실행
	stmt.setInt(1, boardNo); //?에 boardNo값 넣기
	ResultSet rs = stmt.executeQuery(); //실행결과값을 rs에 저장
	
	Board board = new Board();
	while (rs.next()) {
		board.setBoardNo(rs.getInt("boardNo"));
		board.setCategoryName(rs.getString("categoryName")); //쿼리문 결과값을 객체 board에 저장 후
		board.setBoardTitle(rs.getString("boardTitle"));
		board.setBoardPw(rs.getString("boardPw"));
	}
	conn.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteBoardForm</title>
<style>


</style>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<form method="post"
		action="<%=request.getContextPath()%>/board/deleteBoardAction.jsp?boardNo=<%=board.getBoardNo()%>">
		<div class="containerfluid" align="center">
			<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		</div>
		<div class="mt-4 p-5 bg-info text-dark rounded text-center">
			<h1>게시글 삭제</h1>
		</div>
		<div class=".container-fluid">
			<table class="table table-hover table-dark ">

				<tr>
					<th>boardNo</th>
					<th><%=board.getBoardNo()%>
					<th>
				</tr>
				<tr>
					<th>categoryName</th>
					<th><%=board.getCategoryName()%>
					<th>
				</tr>
				<tr>
					<th>boardTitle</th>
					<th><%=board.getBoardTitle()%>
					<th>
				</tr>
				<tr>
					<th>boardPw</th>
					<th><input type="password" value="" name="inputPw"></th>
				</tr>
			</table>
			<div>
				<ul class="pagination">
				<li><a class="page-link" href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=board.getBoardNo()%>">이전</a></li>
				<li><button class="btn btn-outline-light text-dark" type="submit">삭제</button></li>
				</ul>
			</div>

		</div>
	</form>

</body>
</html>
