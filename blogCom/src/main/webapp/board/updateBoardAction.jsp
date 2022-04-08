<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import ="vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import="dao.*" %>
<%
	request.setCharacterEncoding("utf-8");	
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String boardTitle = request.getParameter("boardTitle");	
	String boardContent = request.getParameter("boardContent");		//파라미터값 가져오기
	String boardPw = request.getParameter("boardPw");
	String categoryName = request.getParameter("categoryName");
	
	System.out.println(boardNo+"  <--수정번호");
	System.out.println(boardTitle+"  <--수정제목");
	System.out.println(boardContent+"  수정내용");									//파라미터값 디버깅
	System.out.println(boardPw+"  <--수정비번");
	System.out.println(categoryName+"  <--수정 카테고리 이름");
	
	Board bo = new Board();
	bo.setBoardNo(boardNo);
	bo.setBoardTitle(boardTitle);
	bo.setBoardContent(boardContent);
	bo.setCategoryName(categoryName);
	bo.setBoardPw(boardPw);
	
	/*
		UDATE board SET
			category_name = ?,
			board_title = ?,
			board_content = ?,
			update_date = NOW()
		WHERE board_no = ? AND board_pw = ?
	*/
/*    Class.forName("org.mariadb.jdbc.Driver");					//드라이버 로딩
   System.out.println("성공");									//로딩 성공
   Connection conn = null;	
   String dburl = "jdbc:mariadb://localhost:3306/blog";			//url
   String dbuser = "root";										//사용자 계정
   String dbpw = "java1234";									//비밀번호
   conn = DriverManager.getConnection(dburl, dbuser, dbpw);		//위의 3개를 변수화하여 db접속
   																								//수정하는 쿼리문 작성
   String sql = "UPDATE board SET category_name = ?, board_title = ?, board_content = ?, update_date = NOW() WHERE board_no = ? AND board_pw = ?";
   PreparedStatement stmt = conn.prepareStatement(sql);							//sql문 실행
	// stmt의 ? 표현식값을 완성한다.
	stmt.setString(1, bo.categoryName);								
	stmt.setString(2, bo.boardTitle);
	stmt.setString(3, bo.boardContent);											//?순서대로 값 입력
	stmt.setInt(4,bo.boardNo);			
	stmt.setString(5, bo.boardPw);				
	
	int row = stmt.executeUpdate();										 // 몇행을 입력했는지 return */
	BoardDao bd = new BoardDao();
	int row = bd.updateBoard(bo);
	
	if(row == 1) {
		System.out.println(row+"수정 성공");									// 성공디버깅
	} else {
		System.out.println("실패");										// 실패디버깅
	}
	
   response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
%>