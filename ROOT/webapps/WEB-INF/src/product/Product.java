package product;

public class Product {
    private int idx;
    private String product_name;
    private String product_photo;
    private int price;

 
    public int getIdx() {
        return idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public String getProduct_photo() {
        return product_photo;
    }

    public void setProduct_photo(String product_photo) {
        this.product_photo = product_photo;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }
}
