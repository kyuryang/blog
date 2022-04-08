package dao;
import java.sql.Connection;
import java.sql.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import vo.Guestbook;


public class GuestbookDao {
	public GuestbookDao() {}
	public void insertGuestbook(Guestbook guestbook) throws Exception {	//입력값 테이블 들어갈 내용 다//jsp에서는 예외발생 시 무시  ,자바는 throw와 try/catch로 예외 처리
		//입력
		//GuestbookDao guestbookDao = new Guestbookdao();
		//Guestbook guestbook = new Guestbook();
		//guestbookDao.insertGuestbook(guestbook); 호출
		
		Class.forName("org.mariadb.jdbc.Driver");	
		//db자원 준비
		Connection conn = null;
		PreparedStatement stmt=null;
		
		String dburl="jdbc:mariadb://localhost:3306/blog";
		String dbuser="root";
		String dbpw ="java1234";
		String sql = "insert into guestbook(guestbook_content , writer, guestbook_pw, create_date , update_date) values(?,?,?,Now(),now())";
		conn=DriverManager.getConnection(dburl,dbuser,dbpw);
		stmt =conn.prepareStatement(sql);
		stmt.setString(1,guestbook.getGuestbookContent());
		stmt.setString(2,guestbook.getWriter());
		stmt.setString(3,guestbook.getGuestbookPw());
		int row= stmt.executeUpdate();				//몇행
		if(row==1) {
			System.out.println("입력성공");
		}else {
			System.out.println("입력실패");	
		}
		
	     stmt.close();
	     conn.close();

	}
	public void updateGuestbook(Guestbook guestbook) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");	
		//db자원 준비
		Connection conn = null;
		PreparedStatement stmt=null;
		
		String dburl="jdbc:mariadb://localhost:3306/blog";
		String dbuser="root";
		String dbpw ="java1234";
		String sql = "delete from guestbook where=?";
		
		conn=DriverManager.getConnection(dburl,dbuser,dbpw);
		stmt=conn.prepareStatement(sql);
		stmt.setInt(1, guestbook.getGuestbookNo());
		
		int row=stmt.executeUpdate();
		if(row==1) {
			System.out.println("삭제성공");
		}else {
			System.out.println("삭제실패");
		}
		
	}
	public void deleteGuestbook(int guestbookNo, String guestbookPw) {	
		
	}
	
	
	
		//guestbook 전체 행의수를 반환 메서드
	public int selectGuestbookTotalRow() throws Exception {
		int row = 0;
		
		Class.forName("org.mariadb.jdbc.Driver");	//jsp에서는 예외발생 시 무시  ,자바는 throw와 try/catch로 예외 처리
		//db자원 준비
		Connection conn = null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		String dburl="jdbc:mariadb://localhost:3306/blog";
		String dbuser="root";
		String dbpw ="java1234";
		String sql = "SELECT count(*) cnt from guestbook";
		conn=DriverManager.getConnection(dburl,dbuser,dbpw);
		stmt =conn.prepareStatement(sql);
		rs=stmt.executeQuery();
		while(rs.next()) {
			row= rs.getInt("cnt");
		}
		 rs.close();
	     stmt.close();
	     conn.close();
		return row;
	}
	
	
	// guestbook 10행씩 반환 메서드
	public ArrayList<Guestbook> selectGuestbookListByPage(int beginRow,int rowPerPage) throws Exception{
		ArrayList<Guestbook> list =new ArrayList<Guestbook>();
		//guestbook 10행 반환되도록 구현
		Class.forName("org.mariadb.jdbc.Driver");	//jsp에서는 예외발생 시 무시  ,자바는 throw와 try/catch로 예외 처리
		//db자원 준비
		Connection conn = null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		String dburl="jdbc:mariadb://localhost:3306/blog";
		String dbuser="root";
		String dbpw ="java1234";
		String sql = "SELECT guestbook_no guestbookNo, guestbook_content guestbookContent, writer, create_date createDate FROM guestbook ORDER BY create_date DESC LIMIT ?, ?";
		conn=DriverManager.getConnection(dburl,dbuser,dbpw);
		
		stmt =conn.prepareStatement(sql);
		stmt.setInt(1,beginRow);
		stmt.setInt(2, rowPerPage);
		rs=stmt.executeQuery();
		//db로직 끝
		
		//db 변환(가공)
	      while(rs.next()) {
	          Guestbook g = new Guestbook();
	          g.setGuestbookNo(rs.getInt("guestbookNo"));
	          g.setGuestbookContent(rs.getString("guestbookContent"));
	          g.setWriter(rs.getString("writer"));
	          g.setCreateDate(rs.getString("createDate"));
	          list.add(g);
	       }
	      //db 자원 반환
	      rs.close();
	      stmt.close();
	      conn.close();

		
		return list;
	}


}
