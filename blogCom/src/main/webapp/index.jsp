<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Index</title>
</head>
<body>
	<div class="containerfluid" align="center">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	</div>
		
		<h1>HOME</h1>
		<table>
				<tr>
					<td><a href="<%=request.getContextPath()%>/board/boardList.jsp">게시판</a></td>
				</tr>
				<tr>
					<td><a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp">방명록</a></td>
				</tr>
				<tr>
					<td><a href="<%=request.getContextPath()%>/photo/photoList.jsp">사진</a></td>
				</tr>
		</table>
</body>
</html>