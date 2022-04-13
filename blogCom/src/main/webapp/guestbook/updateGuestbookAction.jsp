<%@page import="org.apache.catalina.filters.SetCharacterEncodingFilter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "java.util.*" %>

<%
request.setCharacterEncoding("utf-8");
int guestbookNo=Integer.parseInt(request.getParameter("guestbookNo"));
String guestbookPw = request.getParameter("guestbookPw");
String guestbookContent = request.getParameter("guestbookContent");
System.out.println(guestbookNo+"수정액션 ");

Guestbook guestbook = new Guestbook();
	guestbook.setGuestbookNo(guestbookNo);
	
	guestbook.setGuestbookPw(guestbookPw);
	guestbook.setGuestbookContent(guestbookContent);


GuestbookDao guestbookDao = new GuestbookDao();
int result=guestbookDao.updateGuestbook(guestbook);
if(result==1){
	response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");				//수정 성공 시 guestbook리스트로
}else{
	response.sendRedirect(request.getContextPath()+"/guestbook/deletGuestbookForm.jsp");		//수정 실패 시 삭제 폼으로 
}

%>
