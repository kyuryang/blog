package dao;
import java.sql.*;
import java.util.*;
import vo.*; 
public class BoardDao {
	public BoardDao() {}
	public int insertBoard(Board board) throws Exception{		//모든 예외 무시
//		String boardContent=board.boardContent;
//		String boardTitle=board.boardTitle;
//		String boardPw=board.boardPw;
//		String categoryName=board.categoryName;
//		
//		Board b = new Board();
//		ArrayList<Board> brd= new ArrayList<Board>();
//		b.boardContent = boardContent;
//		b.boardPw = boardPw;
//		b.boardTitle =boardTitle;
//		b.categoryName=categoryName;
//		brd.add(b);
		
		Class.forName("org.mariadb.jdbc.Driver");		//드라이버 로딩
		System.out.println("드라이버 로딩 성공");				//로딩 디버깅
		Connection conn=null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn=DriverManager.getConnection(dburl,dbuser,dbpw);				//db url,계정,비밀번호 3가지를 변수화 하여 db 접속
		System.out.println("접속 성공");										//접속 디버깅
		
		PreparedStatement stmt = null;
		String sql="insert into board (category_name,board_title,board_content,board_pw,create_date,update_date) values(?,?,?,?,Now(),Now())";
		stmt=conn.prepareStatement(sql);
		stmt.setString(1, board.getCategoryName());
		stmt.setString(2, board.getBoardTitle());
		stmt.setString(3, board.getBoardContent());
		stmt.setString(4, board.getBoardPw());
		
		int row=stmt.executeUpdate();
		System.out.println(row);
		conn.close();
		
		return row;
		
	}
	
	public int deleteBoard(int boardNo,String boardPw) throws Exception{
		
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("boardDelete 로딩 성공");
		Connection conn =null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn=DriverManager.getConnection(dburl,dbuser,dbpw);
		System.out.println("deleteBoard db접속 성공");
		
		System.out.println(boardNo+"            "+boardPw);								//boardNo boardPw 디버깅
		String sql="delete from board where board_no=? and board_pw=?";
		PreparedStatement stmt = null;
		stmt=conn.prepareStatement(sql);
		stmt.setInt(1,boardNo);
		stmt.setString(2,boardPw);
		int row=stmt.executeUpdate();			//수행 결과 행을 row에 반환
		
		
		conn.close();
		System.out.println(row);
		return row;
	}
	
	public int updateBoard(Board b) throws Exception {
		

		
		

		Class.forName("org.mariadb.jdbc.Driver");		//드라이버 로딩
		System.out.println("드라이버 로딩 성공");				//로딩 디버깅
		Connection conn=null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn=DriverManager.getConnection(dburl,dbuser,dbpw);				//db url,계정,비밀번호 3가지를 변수화 하여 db 접속
		System.out.println("접속 성공");										//접속 디버깅
		
		PreparedStatement stmt = null;
		String sql="update board set category_name=? ,board_Title=?,board_Content=?,update_date=Now() where board_no=? and board_pw=?";
		stmt=conn.prepareStatement(sql);
		stmt.setString(1, b.getCategoryName());
		stmt.setString(2, b.getBoardTitle());
		stmt.setString(3, b.getBoardContent());
		stmt.setInt(4, b.getBoardNo());
		stmt.setString(5, b.getBoardPw());
		
		int row=stmt.executeUpdate();
		
		conn.close();

		return row;
	}
	
}
