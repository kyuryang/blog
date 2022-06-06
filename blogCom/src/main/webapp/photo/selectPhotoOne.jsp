<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	int photoNo=Integer.parseInt(request.getParameter("photoNo"));			//photoNo값 요청
	System.out.println(photoNo);
	PhotoDao photoDao = new PhotoDao();										//photoDao 클래스객체 생성
	Photo photo=photoDao.selectPhotoOne(photoNo);							//selectPhotoOne 메서드 호출
	
	System.out.println(photo.getPhotoNo());
	System.out.println(photo.getWriter());
	System.out.println(photo.getPhotoName());						//디버깅
	System.out.println(photo.getCreateDate());
	System.out.println(photo.getUpdateDate());


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
		<div class="containerfluid" align="center">	
			<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	 	<div class="row">
 	 	<div class="col">
		<div class="mt-4 p-5 bg-info text-dark rounded text-center">
			<h1>photo 상세보기</h1>
		</div>
	 	</div>
	 	</div>
	<table class="table table-bordered text-center">
		<tr>
			<td>번호</td>
			<td>
				<%=photo.getPhotoNo()%>
			</td>
		</tr>
		<tr>
			<td>그림</td>
			<td>
				<img src="<%=request.getContextPath()%>/upload/<%=photo.getPhotoName()%>" width="200" height="200">

			</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>
				<%=photo.getWriter()%>
			</td>
		</tr>
	</table>
	<ul class="pagination justify-content-center " style="margin:100px ">
		  <li class="page-item"><a href="<%=request.getContextPath()%>/photo/photoList.jsp">뒤로가기</a></li>
		
		  <li class="page-item"><a href="<%=request.getContextPath()%>/photo/deletePhotoForm.jsp?photoNo=<%=photo.getPhotoNo() %>">삭제</a></li>
	</ul>
	</div>
</body>
</html>