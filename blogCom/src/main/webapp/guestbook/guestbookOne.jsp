<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%
	int guestbookNo=Integer.parseInt(request.getParameter("guestbookNo"));
	System.out.println(guestbookNo+"상세보기 ");
	GuestbookDao guestbookDao = new GuestbookDao();
	List<Guestbook> g = guestbookDao.selectGuestbookOne(guestbookNo);
	System.out.println(g);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="containerfluid" align="center">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	</div>
	<div class="mt-4 p-5 bg-info text-dark  text-center  ">
		<h1>guestbook 상세보기</h1>
	</div>
	<div class="container col-6" >		
	<table class="table table-hover table-dark" >
	 	<tr>
	 		<td>guestbookNo</td>
	 		<td><%=guestbookNo %></td>
	 	</tr>
	 	<%for(Guestbook f : g){ %>
	 	<tr>
	 		<td>guestbookWriter</td>
			 <td><%=f.getWriter()%></td>
	 	</tr>
	 	<tr>
	 		<td>guestbookContent</td>
	 		<td align="left"><%=f.getGuestbookContent() %></td>
	 	</tr>
	<%} %>
	 </table>
	 </div>
	<div class="container col-1" >	
			<a href="<%=request.getContextPath() %>/guestbook/guestbookList.jsp">이전</a>
		<a href="<%=request.getContextPath() %>/guestbook/updateGuestbookForm.jsp?guestbookNo=<%=guestbookNo %>">수정</a>
	 	<a href="<%=request.getContextPath() %>/guestbook/deleteGuestbookForm.jsp?guestbookNo=<%=guestbookNo %>">삭제</a>
	 </div>
</body>
</html>