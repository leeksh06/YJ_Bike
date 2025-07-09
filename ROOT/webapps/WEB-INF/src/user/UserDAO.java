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
            String dbPassword = "1234";
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int join(User user) {
        String sql = "insert into user values(?, ?, ?, ?, ?, ?)";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getUser_id());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getPassword2());
            pstmt.setString(4, user.getNickname());
            pstmt.setString(5, user.getHome_address());
            pstmt.setString(6, user.getPhone_number());
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public int login(String user_id, String password) {
        String sql = "select password from user where user_id = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user_id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                if (rs.getString(1).equals(password)) {
                    return 1;
                } else
                    return 0;
            }
            return -1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2;
    }

    public String getNickname(String user_id) {
        String SQL = "SELECT nickname FROM user WHERE user_id = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user_id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean nicknameExists(String nickname) {
        String sql = "SELECT * FROM user WHERE nickname = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, nickname);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (rs != null) rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public User getUserById(String userId) {
        User user = null;
        String sql = "SELECT * FROM user WHERE user_id = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUser_id(rs.getString("user_id"));
                user.setNickname(rs.getString("nickname"));
                user.setHome_address(rs.getString("home_address"));
                user.setPhone_number(rs.getString("phone_number"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    public boolean isNicknameDuplicate(String nickname) {
        String sql = "SELECT * FROM user WHERE nickname = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, nickname);
            rs = pstmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int updateUser(User user) {
        String sql = "UPDATE user SET password = ?, password2 = ?, nickname = ?, home_address = ?, phone_number = ? WHERE user_id = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getPassword());
            pstmt.setString(2, user.getPassword2());
            pstmt.setString(3, user.getNickname());
            pstmt.setString(4, user.getHome_address());
            pstmt.setString(5, user.getPhone_number());
            pstmt.setString(6, user.getUser_id());
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public User getUserDetails(String userId) {
        User user = new User();
        String sql = "SELECT * FROM user WHERE id = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                user.setNickname(rs.getString("nickname"));
                user.setHome_address(rs.getString("home_address"));
                user.setPhone_number(rs.getString("phone_number"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public int deleteUser(String userId) {
        String sql = "DELETE FROM user WHERE user_id = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Return -1 if there was an error
    }

    public int deletePosts(String userId) {
        String sql = "DELETE FROM post WHERE user_id = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public int deleteComments(String userId) {
        String sql = "DELETE FROM reply WHERE user_id = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public int deleteRank(String userId) {
        String sql = "DELETE FROM cycle WHERE user_id = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
}
