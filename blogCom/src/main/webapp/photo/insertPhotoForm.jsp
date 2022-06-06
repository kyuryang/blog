<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<!-- 
		1)form 태그안에 값을 넘기는 기본타입(enctype)은 문자열이다.
		2)파일을 넘길 수 는 없다. 기본값 (application /x-www-form-urlended)을 변경해야한다.
		3)기본값을 "multipart/form-data"로 변경하면 기본값이 문자열에서 바이너리(이진수)로 변경된다.
		4)같은 폼안에 모든 값이 바이너리로 넘어간다.글자를 넘겨받으면 request.getParameter()을 사용할 수 없다.
		5)복잡한 코드를 통해서만 바이너리로 넘길 수 있다.
		6)외부 라이브러리(cos.jar)을 사용해서 복잡은 	코드를 간단히 구현해보자...
	
	 -->
	 	<div class="row">
 	 	<div class="col">
		<div class="mt-4 p-5 bg-info text-dark rounded text-center">
	 		<h1>이미지 등록</h1>
	 	</div>
	 	</div>
	 	</div>
	 		 <div class="col p-1">
				<form action="<%=request.getContextPath()%>/photo/insertPhotoAction.jsp" method="post" enctype="multipart/form-data">
				<table class="table table-bordered">
					<tr>
						<td>이미지파일</td>
						<td><input type="file" name="photo" class="form-control-file border"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="photoPw"></td>
					</tr>
					<tr>
						<td>글쓴이</td>
						<td><input type="text" name="writer"></td>
					</tr>
		</table>
		
		<button type="submit" class="btn btn-outline-info">이미지등록</button>
	</form>
	</div>
	</div>
</body>
</html>
