<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%

	//모델1 프로젝트 (dao 메서드 분리연습 등등 재활용 하게끔 빠져나간다)

	int currentPage=1;
	if(request.getParameter("currentPage")!=null){
		currentPage=Integer.parseInt(request.getParameter("currentPage"));							//페이징 작업
	}
	int rowPerPage=10;
	int beginRow = (currentPage-1)*rowPerPage;
	GuestbookDao guestbookDao = new GuestbookDao();
	ArrayList<Guestbook> list= guestbookDao.selectGuestbookListByPage(beginRow, rowPerPage);
	
	int lastPage=0;
	int totalCount = guestbookDao.selectGuestbookTotalRow();
		lastPage =(int)(Math.ceil((double)totalCount / (double)rowPerPage));								//올림함수이용 -?  나누어떨어지면 딱 맞는 페이지 나머지가 있으면 +1

			
/* 	lastPage =totalCount/rowPerPage;
	if(totalCount %rowPerPage!=0){
		lastPage++;
	} */
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>total데이터:<%=guestbookDao.selectGuestbookTotalRow() %></h1>

<% 
	for(Guestbook g : list) {
%>
		<table border="1">
			<tr>
				<td><%=g.getWriter()%></td>
				<td><%=g.getCreateDate()%></td>
			</tr>
			<tr>
				<td colspan="2"><%=g.getGuestbookContent()%></td>
			</tr>
		</table>
<%	
	}

	if(currentPage>1){
%>

		  <a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		
<%
	}
%>
<%

	if(currentPage<lastPage){
%>

		<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		
	
<%
	}
%>
	<!-- 방명록 입력 -->
	<form method="post" action="<%=request.getContextPath() %>/guestbook/insertGuestbookAction.jsp">
		<table border="1">
			<tr>
				<td>글쓴이</td>
				<td><input type="text" name="writer"></td>
				<td>비밀번호</td>
				<td><input type="password" name="guestbookPw"></td>

			</tr>
			<tr>
				<td colspan="4"><textarea name="guestbookContent" rows="2" cols="60"></textarea></td>
			</tr>
		</table>
		<button type="submit">입력</button>
	</form>
</body>
</html>