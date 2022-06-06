<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@	page import="java.util.ArrayList" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	int beginRow=0;
	int rowPerPage=10;
	PhotoDao photoDao = new PhotoDao();
	int photoTotalRow=photoDao.selectPhotoTotalRow();
	ArrayList<Photo> list = photoDao.selectPhotoListByPage(beginRow,rowPerPage);
	

	

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
		<!-- 메인 메뉴 시작 -->
		
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<!-- include시 컨텍스트명 (프로젝트이름)을 명시하지않는다 -->
		<!--  메인메뉴 끝 -->
		<div class="row">
 	 	<div class="col">
		<div class="mt-4 p-5 bg-info text-dark rounded text-center">
			<h1>이미지 목록 : <%=photoTotalRow %></h1>
		</div>
		</div>
		</div>
		<div class="col p-1">
			<ul class="pagination">
				 <li class="page-item"><a href="<%=request.getContextPath()%>/photo/insertPhotoForm.jsp"><h3>사진 등록</h3></a></li>
			</ul>
		</div>

  		<div class="col=8">
			<table class="table table-borderless ">
				<tr>
				<%
					//한행의 5개의 이미지 출력(tr안에 td가 5개)
					//이미지 3개 - tr 1개 -td 5개
					//이미지 5개 -tr 1개 -td 5개
					//이미지 10개 tr 2개  td 10개
					//td의 개수가 5의배수가 되도록
					//list.size()가 1~5 -td 5개
					//list.size()가 6~10 td 10개
					System.out.println(list.size());
					int startIdx=1;
					int endIdx= (((list.size()-1)/5)+1)*5;
					for(int i=0; i<endIdx; i++){
						if(i!=0 && i%5==0) { // 5일때(0을 제외한 5의배수일때) 
				%>
								</tr><tr>
				<%			
						}
			
						if(i<list.size()){
						//for(Photo p : list){
				%>
		
							<td>	
								<a href="<%=request.getContextPath() %>/photo/selectPhotoOne.jsp?photoNo=<%=list.get(i).getPhotoNo() %>">
								<img src="<%=request.getContextPath() %>/upload/<%=list.get(i).getPhotoName() %>" width="200" height="200">
								</a>
							</td>

				<%
						}else {
				%>
							<td>&nbsp;</td>
				<% 		
						}
				}
				%>
			</tr>
		</table>
	</div>
	</div>
</body>
</html>