package reply;

public class Reply {
    private int idx;
    private String user_id;
    private String content;
    private java.util.Date date;
    private int ref;
    private int reStep;
    private int reLevel;

    // idx getter and setter
    public int getIdx() {
        return idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

    // user_id getter and setter
    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    // content getter and setter
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    // date getter and setter
    public java.util.Date getDate() {
        return date;
    }

    public void setDate(java.util.Date date) {
        this.date = date;
    }

    // ref getter and setter
    public int getRef() {
        return ref;
    }

    public void setRef(int ref) {
        this.ref = ref;
    }

    // re_step getter and setter
    public int getReStep() {
        return reStep;
    }

    public void setReStep(int reStep) {
        this.reStep = reStep;
    }

    // re_level getter and setter
    public int getReLevel() {
        return reLevel;
    }

    public void setReLevel(int reLevel) {
        this.reLevel = reLevel;
    }
}
