package purchase_info;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Purchase_infoDAO {

	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	
	public  Purchase_infoDAO()  {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/capDB";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}
