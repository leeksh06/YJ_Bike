package purchase_info;
import java.sql.Timestamp;
public class Purchase_info {

	  private int idx;
	    private String user_id;
	    private int product_idx;
	    private int count;
	    private int price;
	    private Timestamp purchase_date;

	    public int getIdx() {
	        return idx;
	    }

	    public void setIdx(int idx) {
	        this.idx = idx;
	    }

	    public String getUser_id() {
	        return user_id;
	    }

	    public void setUser_id(String user_id) {
	        this.user_id = user_id;
	    }

	    public int getProduct_idx() {
	        return product_idx;
	    }

	    public void setProduct_idx(int product_idx) {
	        this.product_idx = product_idx;
	    }

	    public int getCount() {
	        return count;
	    }

	    public void setCount(int count) {
	        this.count = count;
	    }

	    public int getPrice() {
	        return price;
	    }

	    public void setPrice(int price) {
	        this.price = price;
	    }

	    public Timestamp getPurchase_date() {
	        return purchase_date;
	    }

	    public void setPurchase_date(Timestamp purchase_date) {
	        this.purchase_date = purchase_date;
	    }
	}