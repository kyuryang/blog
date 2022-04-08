<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%
/*
public int guestbookNo;
public String guestbookContent;
public String writer;
public String createDate;
public String updateDate;
public String guestbookPw; 	
*/	request.setCharacterEncoding("utf-8");										//utf-8로 셋팅
	String guestbookContent=request.getParameter("guestbookContent");			//요청값 가져오기
	String guestbookPw = request.getParameter("guestbookPw");
	String writer = request.getParameter("writer");
	System.out.println(guestbookContent +" ,"+ guestbookPw+","+ writer	);					//파라미터값 디버깅
	//GuestbookDao guestbookDao = new GuestbookDao();
			//Guestbook guestbook = new Guestbook();
			//guestbookDao.insertGuestbook(guestbook); 호출
	GuestbookDao guestbookDao = new GuestbookDao();								//클래스 객체 생성
	Guestbook guestbook = new Guestbook();										//guestbook 객체 생성
	
	guestbook.setGuestbookContent(guestbookContent);								
	guestbook.setGuestbookPw(guestbookPw);										//-->guestbook에 가져온 파라미터값 넣기
	guestbook.setWriter(writer);
	

	
	guestbookDao.insertGuestbook(guestbook);									//guestbookDao 클래스에서 insertGuestbook함수 호출
	
	response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");	//guestbooklist페이지 돌아가기
	
%>