package cardname;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CardnameDAO {

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public CardnameDAO() {
        try {
            String dbURL = "jdbc:mysql://localhost:3306/cardDB";
            String dbID = "root";
            String dbPassword = "1234";
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int getNextCardId() {
        String sql = "SELECT id FROM cardname ORDER BY id DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) + 1;
            }
            return 1; // If this is the first card
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // Database error
    }

    public int createCard(String user_id, Cardname card) {
        String sql = "INSERT INTO cardname (id,user_id, name, company, position, phone, email, address, memo) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, getNextCardId());
            pstmt.setString(2, user_id);
            pstmt.setString(3, card.getName());
            pstmt.setString(4, card.getCompany());
            pstmt.setString(5, card.getPosition());
            pstmt.setString(6, card.getPhone());
            pstmt.setString(7, card.getEmail());
            pstmt.setString(8, card.getAddress());
            pstmt.setString(9, card.getMemo());
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        } finally {
            try {
                if (pstmt != null) pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }


    public ArrayList<Cardname> getList(int pageNumber) {
        int startIndex = (pageNumber - 1) * 10; // 10은 페이지당 노출되어야 하는 명함 수
        String sql = "SELECT * FROM cardname ORDER BY id DESC LIMIT ?, ?";
        ArrayList<Cardname> list = new ArrayList<Cardname>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, startIndex);
            pstmt.setInt(2, 10); // 10은 페이지당 노출되어야 하는 명함 수
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Cardname card = new Cardname();
                card.setId(rs.getInt("id"));
                card.setUser_id(rs.getString("user_id"));
                card.setName(rs.getString("name"));
                card.setCompany(rs.getString("company"));
                card.setPosition(rs.getString("position"));
                card.setPhone(rs.getString("phone"));
                card.setEmail(rs.getString("email"));
                card.setAddress(rs.getString("address"));
                card.setMemo(rs.getString("memo"));
                list.add(card);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean nextPage(int pageNumber) {
        int startIndex = (pageNumber - 1) * 10; // 10은 페이지당 노출되어야 하는 명함 수
        String sql = "SELECT * FROM cardname ORDER BY id DESC LIMIT ?, 1";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, startIndex + 10); // 다음 페이지에서 첫번째 레코드의 위치
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public ArrayList<Cardname> getSearchList(String searchField, String searchText, int pageNumber) {
        int startIndex = (pageNumber - 1) * 10; // 10 is the number of cards that should be exposed per page
        ArrayList<Cardname> list = new ArrayList<Cardname>();

        String sql;
        if (searchField == null || searchText == null) {
            sql = "SELECT * FROM cardname JOIN user ON cardname.user_id = user.user_id ORDER BY id DESC LIMIT ?, ?";
        } else if (searchField.equals("nickname")) {
            sql = "SELECT * FROM cardname JOIN user ON cardname.user_id = user.user_id WHERE user.nickname LIKE ? ORDER BY id DESC LIMIT ?, ?";
        } else {
            sql = "SELECT * FROM cardname JOIN user ON cardname.user_id = user.user_id WHERE cardname." + searchField.trim() + " LIKE ? ORDER BY id DESC LIMIT ?, ?";
        }

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            if (searchField == null || searchText == null) {
                pstmt.setInt(1, startIndex);
                pstmt.setInt(2, 10); // 10 is the number of cards that should be exposed per page
            } else {
                pstmt.setString(1, "%" + searchText + "%");
                pstmt.setInt(2, startIndex);
                pstmt.setInt(3, 10); // 10 is the number of cards that should be exposed per page
            }
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Cardname card = new Cardname();
                card.setId(rs.getInt("id"));
                card.setUser_id(rs.getString("user_id"));
                card.setName(rs.getString("name"));
                card.setCompany(rs.getString("company"));
                card.setPosition(rs.getString("position"));
                card.setPhone(rs.getString("phone"));
                card.setEmail(rs.getString("email"));
                card.setAddress(rs.getString("address"));
                card.setMemo(rs.getString("memo"));
                list.add(card);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public Cardname getCard(int id) {
        String SQL = "SELECT * FROM Cardname WHERE id = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Cardname card = new Cardname();
                card.setId(rs.getInt("id"));
                card.setUser_id(rs.getString("user_id"));
                card.setName(rs.getString("name"));
                card.setCompany(rs.getString("company"));
                card.setPosition(rs.getString("position"));
                card.setPhone(rs.getString("phone"));
                card.setEmail(rs.getString("email"));
                card.setAddress(rs.getString("address"));
                card.setMemo(rs.getString("memo")); // added this line
                return card;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
            } catch (Exception e) { /* ignored */ }
            try {
                if (pstmt != null) pstmt.close();
            } catch (Exception e) { /* ignored */ }
        }
        return null;
    }

    public int deleteCard(int id) {
        String SQL = "DELETE FROM cardname WHERE id = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, id);
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return -1; // If a SQL exception occurs
        } finally {
            try {
                if (pstmt != null) pstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public int deleteCardCheck(String[] cardsId) {
        StringBuilder query = new StringBuilder();
        if (cardsId != null) {
            query.append("DELETE FROM ").append("cardname").append(" WHERE id IN (");
            for (String str : cardsId) {
                query.append(str);
                query.append(",");
            }
        }
        query.replace(query.length() - 1, query.length(), ")");
        try {
            pstmt = conn.prepareStatement(query.toString());
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return -1; // If a SQL exception occurs
        } finally {
            try {
                if (pstmt != null) pstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public boolean nextPage2(String searchField, String searchText, int pageNumber) {
        String sql;
        int startIndex = pageNumber * 10;
        if (searchField == null || searchText == null) {
            sql = "SELECT count(*) FROM cardname";
        } else if (searchField.equals("nickname")) {
            sql = "SELECT count(*) FROM cardname JOIN user ON cardname.user_id = user.user_id WHERE user.nickname LIKE ?";
        } else {
            sql = "SELECT count(*) FROM cardname WHERE " + searchField + " LIKE ?";
        }

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + searchText + "%");

            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                // Check if there are more records than the start index of the next page
                if (rs.getInt(1) > startIndex) {
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // If we've reached here, there is no next page
        return false;
    }

    public int updateCard(Cardname card) {
        String sql = "UPDATE cardname SET name = ?, company = ?, position = ?, phone = ?, email = ?, address = ?, memo = ? WHERE id = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, card.getName());
            pstmt.setString(2, card.getCompany());
            pstmt.setString(3, card.getPosition());
            pstmt.setString(4, card.getPhone());
            pstmt.setString(5, card.getEmail());
            pstmt.setString(6, card.getAddress());
            pstmt.setString(7, card.getMemo());
            pstmt.setInt(8, card.getId());
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return -1; // SQL error
        } finally {
            try {
                if (pstmt != null) pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public int getCardCount(String userId) {
        String sql = "SELECT count(*) as cnt FROM cardname WHERE user_id = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("cnt");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // database error
    }

    public ArrayList<Cardname> getUserCards(String userId, int startRow, int pageSize) {
        String sql = "SELECT * FROM cardname WHERE user_id = ? ORDER BY id DESC LIMIT ?, ?";
        ArrayList<Cardname> listCard = new ArrayList<Cardname>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            pstmt.setInt(2, startRow - 1);
            pstmt.setInt(3, pageSize);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Cardname cardname = new Cardname();
                cardname.setId(rs.getInt("id"));
                cardname.setName(rs.getString("name"));
                listCard.add(cardname);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listCard;
    }

    public int deleteUserCard(String userId) {
        String sql = "DELETE FROM cardname WHERE user_id = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Return -1 if there was an error
    }
}