<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("utf-8");										//utf-8로 셋팅
	String categoryName = request.getParameter("categoryName");					//파라미터 요청값 받기
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	String boardPw = request.getParameter("boardPw");
	
	System.out.println(categoryName+"  "+boardTitle+"   "+ boardPw);			//디버깅
	
	Board board = new Board();													//Board타입의 board객체를 생성
	board.setCategoryName(categoryName);											//board 속성에 요청받은 값 넣기
	board.setBoardTitle(boardTitle);
	board.setBoardPw(boardPw);
	board.setBoardContent(boardContent);
	

	BoardDao bd =new BoardDao();
	int row=bd.insertBoard(board);
	
	if(row==1){
		System.out.println("게시글 추가 성공");
	}else {
		System.out.println("게시글 추가 실패");
	}

	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");	

%>