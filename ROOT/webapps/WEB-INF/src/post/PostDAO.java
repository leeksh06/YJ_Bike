package post;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.text.SimpleDateFormat;
import java.util.List;


//import user.Post;
//import user.*;
import java.util.Arrays;
import java.util.Collections;

public class PostDAO {

    private Connection conn;
    private ResultSet rs;

    // 기본 생성자
    public PostDAO() {
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

    // 생성 날짜 메서드
    public Timestamp getDate() {
        String sql = "select now()";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getTimestamp(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // 데이터베이스 오류
    }

    // 게시물 번호 지정 메서드
 // 게시물 번호 지정 메서드 (카테고리별)
    public int getNext() {
        String sql = "select idx from post order by idx desc";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) + 1;
            }
            return 1; // 첫 번째 게시물인 경우
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }

    // 글쓰기 메서드
    public int write(String title, String user_id, String content,String category) {
        String sql = "insert into post (idx, user_id,category, title, content, date, views) values(?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, getNext());
            pstmt.setString(2, user_id);
            pstmt.setString(3, category);
            pstmt.setString(4, title);
            pstmt.setString(5, content);
            pstmt.setTimestamp(6, getDate());
            pstmt.setInt(7, 0);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }
    
 // 게시글 리스트 메소드
   /** public ArrayList<Post> getList(int pageNumber) {
        String sql = "select * from post where idx < ? order by idx desc limit 10";
        ArrayList<Post> list = new ArrayList<Post>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Post post = new Post();
                post.setIdx(rs.getInt("idx"));
                post.setUser_id(rs.getString("user_id"));
                post.setCategory(rs.getString("category"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setThum(rs.getString("thum"));
                post.setDate(rs.getTimestamp("date"));
                post.setViews(rs.getInt("views"));
                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
**/
    // 페이징 처리 메소드
    public boolean nextPage(int pageNumber, String category) {
        String sql = "select * from post where idx < ? and category = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
            pstmt.setString(2, category);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    
   
    
    public ArrayList<Post> getFilteredPosts(int pageNumber, List<String> categories) {
        // Prepare the placeholders for the categories in the SQL query
        StringBuilder placeholders = new StringBuilder();
for (int i = 0; i < categories.size(); i++) {
    placeholders.append("?");
    if (i < categories.size() - 1) {
        placeholders.append(", ");
    }
}
String placeholdersStr = placeholders.toString();


        String sql = "select * from post where idx < ? and category in (" + placeholders + ") order by idx desc limit 10";
        ArrayList<Post> list = new ArrayList<Post>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            int index = 1;
            for (String category : categories) {
                pstmt.setInt(index++, getNext() - (pageNumber - 1) * 10);
            }
            for (String category : categories) {
                pstmt.setString(index++, category);
            }

            rs = pstmt.executeQuery();
            while (rs.next()) {
                Post post = new Post();
                post.setIdx(rs.getInt("idx"));
                post.setUser_id(rs.getString("user_id"));
                post.setCategory(rs.getString("category"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setThum(rs.getString("thum"));
                post.setDate(rs.getTimestamp("date"));
                post.setViews(rs.getInt("views"));
                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public String formatDate(Timestamp date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH시 mm분");
        return sdf.format(date);
    }
    
    public Post getPost(int idx) {
        // 조회수 증가
        increaseViews(idx);
        
        String sql = "select * from post where idx = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idx);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                Post post = new Post();
                post.setIdx(rs.getInt(1));
                post.setUser_id(rs.getString(2));
                post.setCategory(rs.getString(3));
                post.setTitle(rs.getString(4));
                post.setContent(rs.getString(5));
                post.setThum(rs.getString(6));
                post.setDate(rs.getTimestamp(7));
                post.setViews(rs.getInt(8));
                return post;
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String formatDate2(Timestamp date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(date);
    }

    public int update(int idx, String title, String content) {
        String sql = "UPDATE post SET title = ?, content = ? WHERE idx = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, title);
            pstmt.setString(2, content);
            pstmt.setInt(3, idx);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }
    public int delete(int idx) {
        
        PreparedStatement pstmt = null;
        String sql = "DELETE FROM post WHERE idx = ?";
        try {
         
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idx);

            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) conn.close();
                if (pstmt != null) pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return -1;
    }
 // 조회수 증가 메소드
    public int increaseViews(int idx) {
        String sql = "UPDATE post SET views = views + 1 WHERE idx = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idx);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }

  public ArrayList<Post> getSearch(String searchField, String searchText, String category, int startRow, int pageSize) {
    ArrayList<Post> list = new ArrayList<Post>();
    // JOIN post 테이블과 user 테이블
    String SQL = "SELECT p.*, u.nickname FROM post p JOIN user u ON p.user_id = u.user_id WHERE "
               + searchField.trim() + " LIKE ? ";

    if (!category.equals("")) {
        SQL += "AND category = ? ";
    }

    SQL += "ORDER BY idx DESC LIMIT ?, ?";

    try {
        PreparedStatement pstmt = conn.prepareStatement(SQL);
        pstmt.setString(1, "%" + searchText.trim() + "%");

        int nextIndex = 2;
        if (!category.equals("")) {
            pstmt.setString(nextIndex++, category);
        }

        pstmt.setInt(nextIndex++, startRow);
        pstmt.setInt(nextIndex, pageSize);

        rs = pstmt.executeQuery();
        while (rs.next()) {
            Post post = new Post();
            post.setIdx(rs.getInt("idx"));
            post.setUser_id(rs.getString("user_id"));
            post.setCategory(rs.getString("category"));
            post.setTitle(rs.getString("title"));
            post.setContent(rs.getString("content"));
            post.setThum(rs.getString("thum"));
            post.setDate(rs.getTimestamp("date"));
            post.setViews(rs.getInt("views"));
            String authorNickname = rs.getString("nickname"); // 작성자 닉네임 받아옴
            list.add(post);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}



    public int getCommentCount(int idx) {
        String sql = "select count(*) from reply where ref = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idx);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }
    
    public String getNickname(String idx) {
        String sql = "select nickname from User where user_id = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, idx);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // 데이터베이스 오류
    }
    
    public Post getPost2(int idx) {
        String sql = "select * from post where idx = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idx);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                Post post = new Post();
                post.setIdx(rs.getInt(1));
                post.setUser_id(rs.getString(2));
                post.setCategory(rs.getString(3));
                post.setTitle(rs.getString(4));
                post.setContent(rs.getString(5));
                post.setThum(rs.getString(6));
                post.setDate(rs.getTimestamp(7));
                post.setViews(rs.getInt(8));
                return post;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String getAuthorID(int idx) {
        String sql = "SELECT user_id FROM post WHERE idx = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idx);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString("user_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // database error
    }
    public Post getPostById(int idx) {
        String sql = "SELECT * FROM post WHERE idx = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idx);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Post post = new Post();
                post.setIdx(rs.getInt("idx"));
                post.setUser_id(rs.getString("user_id"));
                post.setCategory(rs.getString("category"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setThum(rs.getString("thum"));
                post.setDate(rs.getTimestamp("date"));
                post.setViews(rs.getInt("views"));
                return post;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // 해당 ID의 게시물이 없는 경우
    }

    public int getPostCount(String userId) {
        String sql = "SELECT count(*) as cnt FROM post WHERE user_id = ?";
        try  {
        	PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()) {
                return rs.getInt("cnt");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // database error
    }
    public ArrayList<Post> getUserPosts(String userId, int startRow, int pageSize) {
        String sql = "SELECT * FROM post WHERE user_id = ? ORDER BY idx DESC LIMIT ?, ?";
       ArrayList<Post> listPost = new ArrayList<Post>();

        try  {
        	PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            pstmt.setInt(2, startRow - 1);
            pstmt.setInt(3, pageSize);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                Post post = new Post();
                post.setIdx(rs.getInt("idx"));
                post.setTitle(rs.getString("title"));
                listPost.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listPost;
    }
    public int thumupdate(int idx, String title, String content,String thum) {
        String sql = "UPDATE post SET title = ?, content = ? thum = ? WHERE idx = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, title);
            pstmt.setString(2, content);
            pstmt.setInt(3, idx);
            pstmt.setString(4, thum);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }

 public int getTotalPages(int pageSize, String category) {
        int totalPages = 1;
        String sql = "SELECT COUNT(*) FROM post WHERE category = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, category);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                int rowCount = rs.getInt(1);
                totalPages = (int) Math.ceil((double) rowCount / pageSize);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return totalPages;
    }
    public ArrayList<Post> getCategoryPostsPaged(int pageNumber, int pageSize, String category) {
    	   String query = "SELECT * FROM post WHERE category = ? ORDER BY idx DESC LIMIT ?, ? ";
    	   ArrayList<Post> list = new ArrayList<Post>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, category);
            pstmt.setInt(2, (pageNumber - 1) * pageSize);
            pstmt.setInt(3, pageSize);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Post post = new Post();
                post.setIdx(rs.getInt("idx"));
                post.setUser_id(rs.getString("user_id"));
                post.setCategory(rs.getString("category"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setThum(rs.getString("thum"));
                post.setDate(rs.getTimestamp("date"));
                post.setViews(rs.getInt("views"));
                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public int getTotalCount(String category) {
        String sql = "SELECT COUNT(*) FROM post WHERE category = ?";
        int totalCount = 0;
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, category);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                totalCount = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return totalCount;
    }
public int getSearchCount(String searchField, String searchText, String category) {
String sql = "SELECT COUNT(*) FROM post WHERE " + searchField.trim() + " LIKE ? ";

if (!category.equals("")) {
    sql += "AND category = ? ";
}

int count = 0;
try {
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, "%" + searchText.trim() + "%");

    if (!category.equals("")) {
        pstmt.setString(2, category);
    }

    rs = pstmt.executeQuery();

    if (rs.next()) {
        count = rs.getInt(1);
    }
} catch (Exception e) {
    e.printStackTrace();
}

return count;
}

public ArrayList<Post> getSearchPaged(String searchField, String searchText, String category, int pageNumber, int pageSize) {
ArrayList<Post> list = new ArrayList<Post>();
String sql = "SELECT * FROM post WHERE " + searchField.trim() + " LIKE ? ";

if (!category.equals("")) {
    sql += "AND category = ? ";
}

sql += "ORDER BY idx DESC LIMIT ?, ?";

try {
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, "%" + searchText.trim() + "%");

    if (!category.equals("")) {
        pstmt.setString(2, category);
    }

    pstmt.setInt(3, (pageNumber - 1) * pageSize);
    pstmt.setInt(4, pageSize);

    rs = pstmt.executeQuery();
    while (rs.next()) {
        Post post = new Post();
        post.setIdx(rs.getInt("idx"));
        post.setUser_id(rs.getString("user_id"));
        post.setCategory(rs.getString("category"));
        post.setTitle(rs.getString("title"));
        post.setContent(rs.getString("content"));
        post.setThum(rs.getString("thum"));
        post.setDate(rs.getTimestamp("date"));
        post.setViews(rs.getInt("views"));
        list.add(post);
    }
} catch (Exception e) {
    e.printStackTrace();
}

return list;
}
}
