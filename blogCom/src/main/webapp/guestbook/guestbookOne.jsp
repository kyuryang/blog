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
<title>Insert title here</title>
</head>
<body>
	<h1>guestbook 상세보기</h1>
	 <table border="1">
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
	 		<td><%=f.getGuestbookContent() %></td>
	 	</tr>
	<%} %>
	 </table>
	 <a href="<%=request.getContextPath() %>/guestbook/updateGuestbookForm.jsp?guestbookNo=<%=guestbookNo %>">수정</a>
	 <a href="<%=request.getContextPath() %>/guestbook/deleteGuestbookForm.jsp?guestbookNo=<%=guestbookNo %>">삭제</a>
</body>
</html>