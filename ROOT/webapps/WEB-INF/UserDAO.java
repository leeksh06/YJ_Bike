package user;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import user.*;
public class UserDAO {
	
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/capDB";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	public int join(User user) {
		  String sql = "insert into user values(?, ?, ?, ?, ?, ?)";
		  try {
		    pstmt = conn.prepareStatement(sql);
		    pstmt.setString(1, user.getId());
		    pstmt.setString(2, user.getPassword());
		    pstmt.setString(3, user.getPassword2());
		    pstmt.setString(4, user.getNickname());
		    pstmt.setString(5, user.getHome_address());
		    pstmt.setString(6, user.getPhone_number());
		    return pstmt.executeUpdate();
		  }catch (Exception e) {
		 	e.printStackTrace();
		  }
		  return -1;
		}
	
		public int login(String id, String password) {
			String sql = "select password from user where id = ?";
			try {
				pstmt = conn.prepareStatement(sql); 
				pstmt.setString(1, id); 
				rs = pstmt.executeQuery(); 
				if(rs.next()) {
					if(rs.getString(1).equals(password)) {
						return 1; 
					}else
						return 0; 
				}
				return -1;
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -2; 
		}
		public String getNickname(String id) {
		    String SQL = "SELECT nickname FROM user WHERE id = ?";
		    try {
		        PreparedStatement pstmt = conn.prepareStatement(SQL);
		        pstmt.setString(1, id);
		        ResultSet rs = pstmt.executeQuery();
		        if (rs.next()) {
		            return rs.getString(1);
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		    return null; 
		}
}
