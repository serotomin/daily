package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() { //Data Access Object
		try{
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC"; // BBS는 DB이름
			String dbID = "root";
			String dbPassword = "zldzhdals1991!";
			
			Class.forName("com.mysql.cj.jdbc.Driver"); //mysql에 연결해주는 드라이버. 즉, 매개체
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword); // conn 객체 안에 접속된 정보가 담기게 됨
		} catch(Exception e) {
			e.printStackTrace(); //발생된 예외 프린트
		}
	}
	public int login(String userID, String userPassword){
		String SQL = "SELECT userPassword FROM USER WHERE UserID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery(); // rs에 쿼리 실행결과를 넣어준다
			if(rs.next()){ // 결과가 존재한다면 참
				if(rs.getString(1).equals(userPassword))
					return 1; // 로그인 성공
				else
					return 0; // 비밀번호 불일치
			} 
			return -1; // 아이디가 없음	
		} catch(Exception e){
			e.printStackTrace();
		}
		return -2; // DB Error
	}
}
