<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import ="java.io.File" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%

	//form 태그의 enctype="multipart/form-data"로 넘겨져서 request.getParameter()API를 사용 할 수 없다.
	/* String writer=request.getParameter("writer");
	String photo=request.getParameter("photo"); */
	
	/*
	form태그의 enctype="multipart/form-data"로 넘겨져서 request.getParameter() API를 사용할 수 없다. 		
	String writer = request.getParameter("writer");
	System.out.println(writer);
	request.getParameter() API 대신 다른 API를 사용해야 하는데 너무 복잡--
	--> request를 단순하게 사용하게 해주는 cos.jar같은 API(외부라이브리)를 사용하자.
	*/

	//->cos.jar와 같은 API(외부라이브러리)를 사용하자
	
	request.setCharacterEncoding("utf-8");
	
	String path= application.getRealPath("upload");		//application변수  톰켓을 가르키는 변수
	
	//DefaultFileRenamePolicy rp = new DefaultFileRenamePolicy();
	//MultipartRequest multiReq = new MultipartRequest(request,"파일저장될 폴더위치",1024*1024*100(파일크기),"utf-8(생략가능)",rp(new DefaultFileRenamePolicy()) 둘중하나 가능 파일이름 설정);
						//멀티파트리퀘스트는 파일경로가 확정된 순간에 그냥 넣는다.
	//	MultipartRequest multiReq = new MultipartRequest(request,"upload",1024*1024*100,"utf-8",rp);
		MultipartRequest multiReq = new MultipartRequest(request, path, 1024*1024*100, "utf-8", new DefaultFileRenamePolicy());
		

	//2^10 byte =1kbyte (1024 byte) 
	//2^10 kbyte = 1mbyte
	//100 mbyte = 1024*1024*100 byte =104857600 byte 곰셈을 계산해서 코딩하면 가독성이 떨어진다. 24* 60*60
	
	String photoPw = multiReq.getParameter("photoPw");
	String writer = multiReq.getParameter("writer");
	
	// input type="file" name="photo" 
		String photoOriginalName = multiReq.getOriginalFileName("photo"); // 파일 업로드시 원본의 이름
		String photoName = multiReq.getFilesystemName("photo"); // new DefaultFileRenamePolicy()객체를 통해 변경된 이름
		String photoType = multiReq.getContentType("photo");	//포토 타입(이미지)만 받게 허용
		
		System.out.println(photoPw + " <-- photoPw");
		System.out.println(writer + " <-- writer");
		System.out.println(photoOriginalName + " <-- photoOriginalName");
		System.out.println(photoName + " <-- photoName");
		System.out.println(photoType + " <-- photoType");
	
		//파일 업로드의 경우 100mbyte 이하의 image/gif, image/png, image/jpg  3가지 이미지만 허용
		if(photoType.equals("image/gif") || photoType.equals("image/png") || photoType.equals("image/jpeg")){
			//db저장
			System.out.println("dbㄱㄱ");
			PhotoDao photoDao = new PhotoDao();
			Photo photo = new Photo();
			photo.setPhotoName(photoName);
			photo.setPhotoOriginalName(photoOriginalName);
			photo.setPhotoType(photoType);
			photo.setPhotoPw(photoPw);
			photo.setWriter(writer);
			
			photoDao.insertPhoto(photo); // 메서드 구현

			response.sendRedirect(request.getContextPath()+"/photo/photoList.jsp");
		}else {
			//업로드 취소 
			//19줄의 주석의 이유로 잘못된 파일은 삭제하는 절차 (멀티 리퀘스트는 경로를 달아주면 그냥 파일의 종류없이 업로드한다.)
			System.out.println("img파일만 업로드!");
			File file = new File(path+"/"+photoName);			//java.io.file 잘못된 파일을 불러온다.	웹에서는 \\ = /
			file.delete();
			response.sendRedirect(request.getContextPath()+"/photo/insertPhotoForm.jsp");
			
		}
%>
