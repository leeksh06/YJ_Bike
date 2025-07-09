package cycle;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;

public class CycleDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public CycleDAO() {
        try {
            String dbURL = "jdbc:mysql://localhost:3306/capDB";
            String dbID = "root";
            String dbPassword = "1234";
            Class.forName("com.mysql.jdbc.Driver"); // Update this as per your MySQL Connector/J version
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Existing methods...

    public ArrayList<Cycle> getCycleData(String userId) {
        ArrayList<Cycle> list = new ArrayList<Cycle>();
        String query = "SELECT * FROM cycle WHERE user_id=?";
        try {
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Cycle cycle = new Cycle();

                cycle.setIdx(rs.getInt("idx"));
                cycle.setUser_id(rs.getString("user_id"));
                cycle.setDistance(rs.getDouble("distance"));
                cycle.setSpeed(rs.getDouble("speed"));
                cycle.setDate(rs.getDate("date"));
                list.add(cycle);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Cycle> getCycleDataForLastWeek(String userId) {
        List<Cycle> list = new ArrayList<Cycle>();
//        String query = "SELECT * FROM cycle WHERE user_id = ? AND date BETWEEN DATE(NOW()) - INTERVAL 7 DAY AND DATE(NOW()) ORDER BY date DESC";
        String query = "select idx, date, sum(distance) as distance, avg(speed) as speed from cycle where user_id = ? and date BETWEEN DATE(NOW()) - INTERVAL 7 DAY AND DATE(NOW()) group by date order by date desc";
        try {
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Cycle cycle = new Cycle();
                cycle.setIdx(rs.getInt("idx"));
                cycle.setUser_id(userId);
                cycle.setDistance(Math.round(rs.getDouble("distance") * 100) / 100.0);
                cycle.setSpeed(Math.round(rs.getDouble("speed") * 100) / 100.0);
                cycle.setDate(rs.getDate("date"));
                list.add(cycle);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Cycle> getCycleDataForLastMonth(String userId) {
        List<Cycle> list = new ArrayList<Cycle>();
//        String query = "SELECT * FROM cycle WHERE user_id = ? AND date BETWEEN DATE(NOW()) - INTERVAL 30 DAY AND DATE(NOW()) ORDER BY date DESC";
        String query = "select idx, date, sum(distance) as distance, avg(speed) as speed from cycle where user_id = ? and date BETWEEN DATE(NOW()) - INTERVAL 30 DAY AND DATE(NOW()) group by date order by date desc";
        try {
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Cycle cycle = new Cycle();
                cycle.setIdx(rs.getInt("idx"));
                cycle.setUser_id(userId);
                cycle.setDistance(Math.round(rs.getDouble("distance") * 100) / 100.0);
                cycle.setSpeed(Math.round(rs.getDouble("speed") * 100) / 100.0);
                cycle.setDate(rs.getDate("date"));
                list.add(cycle);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
