<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "java.util.*" %>
<%
	int guestbookNo=Integer.parseInt(request.getParameter("guestbookNo"));
	String guestbookPw = request.getParameter("guestbookPw");
	System.out.println(guestbookNo+"삭제액션 ");
	GuestbookDao guestbookDao = new GuestbookDao();
	int result=guestbookDao.deleteGuestbook(guestbookNo, guestbookPw);
	if(result==1){
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");				//삭제 성공 시 guestbook리스트로
	}else{
		response.sendRedirect(request.getContextPath()+"/guestbook/deletGuestbookForm.jsp");		//삭제 실패 시 삭제 폼으로 
	}
%>