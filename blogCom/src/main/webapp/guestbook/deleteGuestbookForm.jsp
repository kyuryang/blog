<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "java.util.*" %>
<%
	int guestbookNo=Integer.parseInt(request.getParameter("guestbookNo"));
	System.out.println(guestbookNo+"삭제폼 ");
	GuestbookDao guestbookDao = new GuestbookDao();
	List<Guestbook> g = guestbookDao.selectGuestbookOne(guestbookNo);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>guestbook 삭제 폼</h1>
	 <form method="post" action="<%=request.getContextPath()%>/guestbook/deleteGuestbookAction.jsp">
		 <table border="1">
		 	<tr>
		 		<td>guestbookNo</td>
		 		<td><input type="text" value= "<%=guestbookNo %>" name=guestbookNo readOnly></td>
		 	</tr>
		 	<%for(Guestbook f : g){ %>
		 	<tr>
		 		<td>guestbookWriter</td>
				<td><input type="text" value=<%=f.getWriter() %> name=guestbookWriter readOnly></td>
		 	</tr>
		 	<tr>
		 		<td>guestbookContent</td>
	 			<td><input type="text" value=<%=f.getGuestbookContent() %> name=guestbookContent readOnly></td>
	 		</tr>
	 			<%} %>
	 		<tr>
	 			<td>비밀번호</td>
	 			<td><input type="password" name=guestbookPw ></td>
			</tr>
			
			</table>
			<button type="submit">삭제</button>
		</form>
</body>
</html>