<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%
	int photoNo= Integer.parseInt(request.getParameter("photoNo"));				//photoNo값 가져오기
	System.out.println(photoNo +"<-- deleteForm photoNo");						//디버깅

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="containerfluid" align="center">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	 	<div class="row">
 	 	<div class="col">
		<div class="mt-4 p-5 bg-info text-dark rounded text-center">
			<h1>사진 삭제</h1>
		</div>
	 	</div>
	 	</div>
	 	<div class="col p-1">
			<form method="post" action="<%=request.getContextPath()%>/photo/deletePhotoAction.jsp?photoNo=<%=photoNo%>">
			 <div class="input-group mb-3 input-group-lg">
   				 <div class="input-group-prepend">
    				  <span class="input-group-text">
    				  		photoPw
    				  </span>
    				  </div>
						<input class="form-control" type="password" value="" name="photoPw"> 		<!-- password타입으로 photoPw 받기 -->
					</div>
		<div><button  type="submit" class="btn btn-outline-info"> 삭제</button></div>
	</form>
	</div>
	</div>
</body>
</html>