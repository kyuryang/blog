package dao;
import vo.Photo;
import java.sql.*;
import java.util.*;

import java.util.ArrayList;

import org.apache.catalina.ant.ListTask;
public class PhotoDao {
	public PhotoDao() {}
	public void insertPhoto(Photo photo) throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");								//드라이버 로딩 
		System.out.println("삽입메서드 로딩 성공");						//로딩 디버깅
//		public int photoNo;
//		public String photoName;
//		public String photoOriginalName;
//		public String photoType;
//		public String photoPw;
//		public String writer;

		String dburl="jdbc:mariadb://localhost:3306/blog";
		String dbuser="root";														//3가지 변수화
		String dbpw="java1234";
		Connection conn=null;
		conn=DriverManager.getConnection(dburl,dbuser,dbpw);					//db접속
		System.out.println("접속 성공");											//접속 디버깅
		String sql="insert into photo(photo_name, photo_original_name,photo_type,photo_pw,writer,create_date,update_date) values(?,?,?,?,?,now(),now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, photo.getPhotoName());
		stmt.setString(2, photo.getPhotoOriginalName());
		stmt.setString(3, photo.getPhotoType());
		stmt.setString(4, photo.getPhotoPw());
		stmt.setString(5, photo.getWriter());
		
		int row = stmt.executeUpdate();
		System.out.println(row);
		conn.close();

	}
	public int deletePhoto(int photoNo,String photoPw) throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");									//드라이버로딩
		System.out.println("드라이버로딩 성공");					//로딩 디버깅
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";									//변수화
		String dbpw = "java1234";
		
		Connection conn=null;
		conn=DriverManager.getConnection(dburl,dbuser,dbpw);
		
		PreparedStatement stmt = null;
		String sql= "delete from photo where photo_no=? and photo_pw=?";
		stmt=conn.prepareStatement(sql);
		stmt.setInt(1, photoNo);
		stmt.setString(2, photoPw);
		
		int row=0;
		row = stmt.executeUpdate();
		conn.close();
		return row;
		
			
	}
	
	public ArrayList<Photo> selectPhotoListByPage(int beginRow, int rowPerPage) throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");									//드라이버로딩
		System.out.println("드라이버로딩 성공");					//로딩 디버깅
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";									//변수화
		String dbpw = "java1234";
		
		Connection conn=null;
		conn=DriverManager.getConnection(dburl,dbuser,dbpw);
		
		PreparedStatement stmt = null;
		String sql= "select photo_no photoNo, photo_name photoName, writer, create_date createDate from Photo order by createDate desc limit ?,?";
		stmt=conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		
		
		
		ArrayList<Photo> list =new ArrayList<Photo>();
		
		while(rs.next()) {
			Photo photo = new Photo();							
			photo.setPhotoNo(rs.getInt("photoNo"));
			photo.setPhotoName(rs.getString("photoName"));
			photo.setWriter(rs.getString("writer"));
			photo.setCreateDate(rs.getString("createDate"));
			list.add(photo);
		}
		conn.close();
		
		return list;
	}
	public int selectPhotoTotalRow() throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");									//드라이버로딩
		System.out.println("드라이버로딩 성공");					//로딩 디버깅
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";									//변수화
		String dbpw = "java1234";
		
		Connection conn=null;
		conn=DriverManager.getConnection(dburl,dbuser,dbpw);
		
		PreparedStatement stmt = null;
		String sql= "select count(*) cnt from Photo";
		stmt=conn.prepareStatement(sql);

		ResultSet rs = stmt.executeQuery();
		int photoTotalRow=0;
		while(rs.next()) {
		photoTotalRow=rs.getInt("cnt");
		}
		return photoTotalRow;
	}
	
	public Photo selectPhotoOne(int photoNo) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");									//드라이버로딩
		System.out.println("드라이버로딩 성공");					//로딩 디버깅
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";									//변수화
		String dbpw = "java1234";
		
		Connection conn=null;
		conn=DriverManager.getConnection(dburl,dbuser,dbpw);
		
		PreparedStatement stmt = null;
		String sql="select photo_no photoNo,photo_name photoName, photo_original_name photoOriginalName,writer,photo_type photoType,photo_pw photoPw,create_date createDate,update_date updateDate from photo where photo_No=?";
		stmt=conn.prepareStatement(sql);
		stmt.setInt(1,photoNo);
		Photo photo = new Photo();
		
		ResultSet rs=stmt.executeQuery();
		while(rs.next()) {
			photo.setPhotoNo(rs.getInt("photoNo"));
			photo.setPhotoName(rs.getString("photoName"));
			photo.setPhotoOriginalName(rs.getString("photoOriginalName"));			//
			photo.setWriter(rs.getString("writer"));
			photo.setPhotoType(rs.getString("photoType"));
			photo.setPhotoPw(rs.getString("photoPw"));
			photo.setCreateDate(rs.getString("createDate"));
			photo.setUpdateDate(rs.getString("updateDate"));
		}
		
		
		return photo;
	}
	public String selectPhotoName(int photoNo) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");									//드라이버로딩
		System.out.println("드라이버로딩 성공");					//로딩 디버깅
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";									//변수화
		String dbpw = "java1234";
		
		Connection conn=null;
		conn=DriverManager.getConnection(dburl,dbuser,dbpw);
		
		PreparedStatement stmt = null;
		String sql= "select photo_name photoName from photo where photo_No=?";				//photoNo로 photoName을 알아내는 쿼리문 작성
		stmt=conn.prepareStatement(sql);											//실행
		stmt.setInt(1,photoNo);														//?에 photoNo값을 준다.
		String photoName=null;																
		ResultSet rs=stmt.executeQuery();											
		while(rs.next()) {
			photoName=rs.getString("photoName");									//rs의 photoName 값을 넣는다.
		}
		return photoName;														//photoName 반환
	}
}

