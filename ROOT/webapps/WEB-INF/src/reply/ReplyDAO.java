package reply;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class ReplyDAO {
    private Connection conn;
    private ResultSet rs;
    private String dbURL = "jdbc:mysql://localhost:3306/capDB";
    private String dbID = "root";
    private String dbPassword = "1234";

    public ReplyDAO() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

   public ArrayList<Reply> getList(int ref, int pageNumber, int commentsPerPage) {
//    String SQL = "SELECT * FROM reply WHERE ref = ? ORDER BY idx DESC LIMIT ?, ?";
    String SQL = "SELECT * FROM reply WHERE ref = ? LIMIT ?, ?";
    ArrayList<Reply> list = new ArrayList<Reply>();
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        pstmt = conn.prepareStatement(SQL);
        pstmt.setInt(1, ref);
        pstmt.setInt(2, (pageNumber - 1) * commentsPerPage);
        pstmt.setInt(3, commentsPerPage);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            Reply reply = new Reply();
            reply.setIdx(rs.getInt("idx"));
            reply.setUser_id(rs.getString("user_id"));
            reply.setContent(rs.getString("content"));
            reply.setDate(rs.getTimestamp("date"));
            reply.setRef(rs.getInt("ref"));
            reply.setReStep(rs.getInt("re_step"));
            reply.setReLevel(rs.getInt("re_level"));
            list.add(reply);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    return list;
}


    public int getNext() {
        String SQL = "SELECT idx FROM reply ORDER BY idx DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) + 1;  // 현재 인덱스(현재 게시글 개수) +1 반환
            }
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public int write(Reply reply) {
        String SQL = "INSERT INTO reply(user_id, idx, content, ref, re_step, re_level, post_idx) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, reply.getUser_id());
            pstmt.setInt(2, getNext());
            pstmt.setString(3, reply.getContent());
            pstmt.setInt(4, reply.getRef());
            pstmt.setInt(5, reply.getReStep());
            pstmt.setInt(6, reply.getReLevel());
            pstmt.setInt(7, reply.getRef());
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public String formatDate(Timestamp date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        return sdf.format(date);
    }

    public int getCommentsCount(int ref) {
        String SQL = "SELECT COUNT(*) FROM reply WHERE ref = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, ref);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

       public String getUpdateReply(int idx) {
        String SQL = "SELECT content FROM reply WHERE idx = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, idx);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString("content");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // 일치하는 댓글이 없을 경우 null 반환
    }

    public int update(int idx, String content) {
        String SQL = "UPDATE reply SET content = ? WHERE idx = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, content);
            pstmt.setInt(2, idx);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }

    public Reply getReply(int idx) {
        String SQL = "SELECT * FROM reply WHERE idx = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, idx);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Reply reply = new Reply();
                reply.setIdx(rs.getInt("idx"));
                reply.setUser_id(rs.getString("user_id"));
                reply.setContent(rs.getString("content"));
                reply.setDate(rs.getTimestamp("date"));
                reply.setRef(rs.getInt("ref"));
                reply.setReStep(rs.getInt("reStep"));
                reply.setReLevel(rs.getInt("reLevel"));
                return reply;
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int delete(int idx) {
        String SQL = "DELETE FROM reply WHERE idx = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, idx);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }

    public int getPostIdByReplyId(int replyID) {
        String sql = "SELECT ref FROM reply WHERE idx = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, replyID);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("ref");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 해당하는 댓글이 없거나 다른 문제가 발생한 경우 -1 반환
    }

    public String getAuthorID(int idx) {
        String sql = "SELECT user_id FROM post WHERE idx = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idx);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // 데이터베이스 오류 발생 시 null 반환
    }

    public int getReplyCount(String userId) {
        String sql = "SELECT COUNT(*) as cnt FROM reply WHERE user_id=?";
        int cnt = 0;

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                cnt = rs.getInt("cnt");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return cnt;
    }

       public List<Reply> getReplies(String userId, int startRow, int pageSize) {
        String sql = "SELECT * FROM reply WHERE user_id=? ORDER BY idx DESC LIMIT ?, ?";
        List<Reply> replies = new ArrayList<Reply>();

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            pstmt.setInt(2, startRow - 1);
            pstmt.setInt(3, pageSize);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Reply reply = new Reply();
                reply.setIdx(rs.getInt("idx"));
                reply.setContent(rs.getString("content"));
                replies.add(reply);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return replies;
    }
}

