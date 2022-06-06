<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.GuestbookDao"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
//모델1 프로젝트 (dao 메서드 분리연습 등등 재활용 하게끔 빠져나간다)

	int currentPage = 1;	
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage")); //페이징 작업
	}
	int rowPerPage = 10;
	int beginRow = (currentPage - 1) * rowPerPage;

	//db 데이터 가져오기
	GuestbookDao guestbookDao = new GuestbookDao();
	
	ArrayList<Guestbook> list = guestbookDao.selectGuestbookListByPage(beginRow, rowPerPage);

	//페이징
	int lastPage = 0;
	int totalCount = guestbookDao.selectGuestbookTotalRow();
	lastPage = (int) (Math.ceil((double) totalCount / (double) rowPerPage)); //올림함수이용 -?  나누어떨어지면 딱 맞는 페이지 나머지가 있으면 +1
	
	/* 	lastPage =totalCount/rowPerPage;
		if(totalCount %rowPerPage!=0){
		lastPage++;
	} */
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>방명록</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<style>
		table{
			size:1000px;
	
		}
		#right{
			text-align:right;
		}
	</style>
</head>
<body>
	<div class="containerfluid" align="center">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	</div>
	<div class="mt-4 p-5 bg-info text-dark  text-center  ">
		<h1>
			total데이터:<%=guestbookDao.selectGuestbookTotalRow()%>
		</h1>
	</div>
	<%
	for (Guestbook g : list) {
	%>
	<div class="container pt-4 col-6" >	
		<table class="table table-hover table-dark" >
			<tr>
				<td><%=g.getWriter()%></td>
				<td id="right"><%=g.getCreateDate()%></td>
			</tr>
			<tr>
				<td colspan="2"><a href="<%=request.getContextPath()%>/guestbook/guestbookOne.jsp?guestbookNo=<%=g.getGuestbookNo()%>"><%=g.getGuestbookContent()%></a></td>
			</tr>
			
		
	<%
	}
	%>
	</table>	
	</div>
	<div class="container pt-4 col-6" >	
	<%
		if (currentPage > 1) {
	%>

		<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage - 1%>">이전</a>

	<%
	}
	%>
	<%
	if (currentPage < lastPage) {
	%>
		<a  href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage + 1%>">다음</a>
		
	<%
	}
	%>
	</div>
	<!-- 방명록 입력 -->
	<form method="post" action="<%=request.getContextPath()%>/guestbook/insertGuestbookAction.jsp" >
	<div class="container col-6" >	
		<table class="table table-hover table-dark  ">
			<tr>
				<td>글쓴이</td>
				<td><input type="text" name="writer"></td>
				<td>비밀번호</td>
				<td><input type="password" name="guestbookPw"></td>

			</tr>
			<tr>
				<td colspan="4" align="center"><textarea name="guestbookContent" rows="3"
						cols="60"></textarea></td>
				
			</tr>
						<tr>
			<td><button class="btn btn-link btn-outline-warning" type="submit">입력</button></td>
			</tr>
		</table>
	
		</div>
	</form>


</body>
</html>