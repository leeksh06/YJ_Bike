package carduser;

public class User {
    private String user_id;
    private String password;
    private String nickname;
    private String home_address;
    private String phone_number;

    public String getUser_id() { return user_id; }
    public void setUser_id(String user_id) { this.user_id = user_id; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }

    public String getHome_address() { return home_address; }
    public void setHome_address(String home_address) { this.home_address = home_address; }

    public String getPhone_number() { return phone_number; }
    public void setPhone_number(String phone_number) { this.phone_number = phone_number; }
}