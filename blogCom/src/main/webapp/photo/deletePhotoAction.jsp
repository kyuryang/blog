<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import =" java.io.File" %>
<%
	//1)db 테이블 데이터 삭제	(photoNo로 삭제 가능)
	//2) upload폴더에 이미지 삭제 (photoName)
	

	int photoNo = Integer.parseInt(request.getParameter("photoNo"));			//photoNo 값 요청
	String photoPw = request.getParameter("photoPw");							//photopw 값 요청
	System.out.println(photoNo +"   "+photoPw +" <--deletePhotoAction" );		//디버깅
	
	PhotoDao photoDao =new PhotoDao();											
	String photoName=photoDao.selectPhotoName(photoNo);							
	
	//1)테이블 데이터 삭제
	int delRow= photoDao.deletePhoto(photoNo,photoPw);
	
	//2)폴더이미지 삭제
	if(delRow==1){	//테이블데이터 삭제 성공
		String path=application.getRealPath("upload");
		File file= new File(path+"\\"+photoName);		//잘못된 파일을 불러온다 java.io.File
		file.delete();									//파일 삭제
		response.sendRedirect(request.getContextPath()+"/photo/photoList.jsp");	//이동
	}else{
		System.out.println("삭제 실패");
		response.sendRedirect(request.getContextPath()+"/photo/photoList.jsp");	//이동
	}
%>