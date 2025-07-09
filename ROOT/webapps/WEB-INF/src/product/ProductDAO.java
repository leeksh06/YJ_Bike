package product;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ProductDAO {

	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	
	public ProductDAO()  {
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
	
	public Product getProductDetails(int productIdx) {
        Product product = new Product();
        String sql = "SELECT * FROM product WHERE idx = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, productIdx);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                product.setProduct_name(rs.getString("product_name"));
                product.setProduct_photo(rs.getString("product_photo"));
                product.setPrice(rs.getInt("price"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return product;
    }
}
