<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "java.util.*" %>
<%

int guestbookNo=Integer.parseInt(request.getParameter("guestbookNo"));
System.out.println(guestbookNo+"수정폼 ");
GuestbookDao guestbookDao = new GuestbookDao();
List<Guestbook> g = guestbookDao.selectGuestbookOne(guestbookNo);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

</head>
<body>
	<h1>guestbook 수정 폼</h1>
	 <form method="post" action="<%=request.getContextPath()%>/guestbook/updateGuestbookAction.jsp">
	 	<table border="1">
	 		<tr>
	 			<td>guestbookNo</td>
	 			<td><input type="text" value="<%=guestbookNo %>" name="guestbookNo" readOnly></td>
		 	</tr>
			 	<%for(Guestbook f : g){ %>
		 	<tr>
		 		<td>guestbookWriter</td>
				 <td><%=f.getWriter()%></td>
		 	</tr>
		 	<tr>
		 		<td>guestbookContent</td>
		 		<td><input type="text" name="guestbookContent" value="<%=f.getGuestbookContent()%>"></td>
	 	</tr>
	 	<tr>
		 		<td>guestbookPw</td>
		 		<td><input type="password"  name="guestbookPw"></td>
	 	</tr>
		<%} %>
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>