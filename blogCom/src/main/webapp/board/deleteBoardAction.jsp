<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>    
<%@ page import ="dao.*" %>
<%
	request.setCharacterEncoding("utf-8");	
	int boardNo=Integer.parseInt(request.getParameter("boardNo"));		//boardNo 요청값 가져오기
	System.out.println(boardNo+"<--deleteboardNo delete 액션");						//boardNo 디버깅
	String boardPw=request.getParameter("inputPw");
	System.out.println(boardPw+"<--deleteInputPw");	
	
	BoardDao boardDao =new BoardDao();									//board클래스 생성
	int row=boardDao.deleteBoard(boardNo, boardPw); 					//int형 함수로 int형으로 받기
	System.out.println(row);
	  if(row == 0) { 																// 삭제 실패(0줄 실행됨)						
			System.out.println("삭제 실패");
			response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");	
		} else if(row == 1) { 														// 삭제 성공		
			System.out.println("삭제 성공");
			response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");	
		} else { 																	// 여러행이 삭제?
			System.out.println("에러....");											//  0줄 1줄이 아닌 여러 행의 잘못된 방 ---> 에러 출력
	} 

									
/* 		 Class.forName("org.mariadb.jdbc.Driver");					//드라이버 로딩
	 	  System.out.println("성공");									//로딩 성공
	 	  Connection conn = null;	
	 	  String dburl = "jdbc:mariadb://localhost:3306/blog";			//url
	 	  String dbuser = "root";										//사용자 계정
		   String dbpw = "java1234";									//비밀번호
		   conn = DriverManager.getConnection(dburl, dbuser, dbpw);		//위의 3개를 변수화하여 db접속
	   
		   String sql="delete from Board where boardNo=?";
		   PreparedStatement stmt = conn.prepareStatement(sql);
		   stmt.setInt(1,boardNo);
		   int row = stmt.executeUpdate();								//수행 결과 행을 반환
		   conn.close();												//db종료
		   if(row == 0) { 																// 삭제 실패(0줄 실행됨)						
				System.out.println("삭제 실패");
				response.sendRedirect(request.getContextPath()+"/boardList.jsp");	
			} else if(row == 1) { 														// 삭제 성공		
				System.out.println("삭제 성공");
				response.sendRedirect(request.getContextPath()+"/boardList.jsp");	
			} else { 																	// 여러행이 삭제?
				System.out.println("에러....");											//  0줄 1줄이 아닌 여러 행의 잘못된 방 ---> 에러 출력
		} */
%>