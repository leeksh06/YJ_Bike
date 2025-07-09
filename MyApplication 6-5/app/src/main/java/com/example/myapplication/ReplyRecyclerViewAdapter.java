package com.example.myapplication;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class ReplyRecyclerViewAdapter extends RecyclerView.Adapter<ReplyViewHolder> {

    //리사이클러뷰에 넣을 데이터 리스트
    ArrayList<ReplyData> arrayList;
    Context context;

    //생성자를 통하여 데이터 리스트 context를 받음
    public ReplyRecyclerViewAdapter(Context context, ArrayList<ReplyData> arrayList) {
        this.arrayList = arrayList;
        this.context = context;
    }

    @NonNull
    @Override
    public ReplyViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.reply_data_item, parent, false);

        return new ReplyViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ReplyViewHolder holder, int position) {
        int idx = arrayList.get(position).getIdx();
        String user_id = arrayList.get(position).getUser_id();
        String content = arrayList.get(position).getContent();
        String date = arrayList.get(position).getDate();
        int ref = arrayList.get(position).getRef();
        int re_step = arrayList.get(position).getRe_step();
        int re_level = arrayList.get(position).getRe_level();
        int post_idx = arrayList.get(position).getPost_idx();

        holder.replyUser_id.setText(user_id);
        holder.replyDate.setText(date);
        holder.replyContent.setText(content);

        if (holder.login_id.equals("admin")) {
            holder.replyBtnFix.setVisibility(View.INVISIBLE);
            holder.replyBtnDelete.setVisibility(View.VISIBLE);
        } else if (!holder.login_id.equals(user_id)) {
            holder.replyBtnDelete.setVisibility(View.INVISIBLE);
            holder.replyBtnFix.setVisibility(View.INVISIBLE);
        } else {
            // 본인이 작성한 댓글이 맞으면
            holder.replyBtnDelete.setVisibility(View.VISIBLE);
            holder.replyBtnFix.setVisibility(View.VISIBLE);
        }

        holder.replyBtnDelete.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                deleteRequest(idx, holder.getAdapterPosition());
            }
        });

        holder.replyBtnFix.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                AlertDialog.Builder builder = new AlertDialog.Builder(context);
                builder.setTitle("댓글 수정");
                holder.editText.setText(content);
                if (holder.editText.getParent() != null)
                    ((ViewGroup) holder.editText.getParent()).removeView(holder.editText);
                builder.setView(holder.editText);
                builder.setPositiveButton("수정하기", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        ReplyData data = new ReplyData(idx, user_id, holder.editText.getText().toString(), date, ref, re_step, re_level, post_idx);
                        fixRequest(idx, holder.getAdapterPosition(), data);
                    }
                });
                builder.setNegativeButton("취소", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {

                    }
                });
                builder.show();
            }
        });
    }

    @Override
    public int getItemCount() {
        //데이터 리스트의 크기를 전달해주어야 함
        return arrayList.size();
    }

    public void deleteRequest(int replyIdx, int position) {
        String url = "http://172.245.179.217:8080/htdocs/cap/delProcess.jsp";
        StringRequest request = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {

            //응답을 잘 받았을 때 이 메소드가 자동으로 호출
            @Override
            public void onResponse(String response) {
                System.out.println(("댓글 삭제 응답 -> " + response.trim()));
                if (response.trim().equals("success")) {
                    arrayList.remove(position);
                    notifyItemRemoved(position);
                }
            }
        },
                new Response.ErrorListener() {
                    @Override //에러 발생시 호출될 리스너 객체
                    public void onErrorResponse(VolleyError error) {
                        System.out.println(("에러 -> " + error.getMessage()));
                    }
                }
        ) {
            @Override
            protected Map<String, String> getParams() throws AuthFailureError {
                Map<String, String> params = new HashMap<String, String>();
                params.put("replyIdx", String.valueOf(replyIdx));

                return params;
            }
        };

        request.setShouldCache(false);
        RequestQueue queue = Volley.newRequestQueue(context.getApplicationContext());
        queue.add(request);
    }

    public void fixRequest(int replyIdx, int position, ReplyData data) {
        String url = "http://172.245.179.217:8080/htdocs/cap/replyUpdate.jsp";
        StringRequest request = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
            //응답을 잘 받았을 때 이 메소드가 자동으로 호출
            @Override
            public void onResponse(String response) {
                System.out.println(("댓글 삭제 응답 -> " + response.trim()));
                if (response.trim().equals("success")) {
                    arrayList.set(position, data);
                    notifyItemChanged(position);
                }
            }
        },
                new Response.ErrorListener() {
                    @Override //에러 발생시 호출될 리스너 객체
                    public void onErrorResponse(VolleyError error) {
                        System.out.println(("에러 -> " + error.getMessage()));
                    }
                }
        ) {
            @Override
            protected Map<String, String> getParams() throws AuthFailureError {
                Map<String, String> params = new HashMap<String, String>();
                params.put("replyIdx", String.valueOf(replyIdx));
                params.put("content", data.getContent());

                return params;
            }
        };

        request.setShouldCache(false);
        RequestQueue queue = Volley.newRequestQueue(context.getApplicationContext());
        queue.add(request);
    }
}

class ReplyViewHolder extends RecyclerView.ViewHolder {

    TextView replyLevel;
    TextView replyUser_id;
    TextView replyDate;
    ImageButton replyBtnDelete;
    ImageButton replyBtnFix;
    TextView replyContent;
    TextView replyBtnComment;

    EditText editText;

    LinearLayout replyToolBox;

    String login_id;

    public ReplyViewHolder(@NonNull View itemView) {
        super(itemView);
        replyUser_id = (TextView) itemView.findViewById(R.id.replyUser_id);
        replyDate = (TextView) itemView.findViewById(R.id.replyDate);
        replyBtnDelete = (ImageButton) itemView.findViewById(R.id.replyBtnDelete);
        replyBtnFix = (ImageButton) itemView.findViewById(R.id.replyBtnFix);
        replyContent = (TextView) itemView.findViewById(R.id.replyContent);

        editText = new EditText(itemView.getContext());
        replyToolBox = (LinearLayout) itemView.findViewById(R.id.replyToolBox);

        SharedPreferences sharedPref = itemView.getContext().getSharedPreferences("userInfo", Context.MODE_PRIVATE);
        login_id = sharedPref.getString("id", "");
    }
}

class ReplyData {
    private int idx;
    private String user_id;
    private String content;
    private String date;
    private int ref;
    private int re_step;
    private int re_level;
    private int post_idx;

    public ReplyData(int idx, String user_id, String content, String date, int ref, int re_step, int re_level, int post_idx) {
        this.idx = idx;
        this.user_id = user_id;
        this.content = content;
        this.date = date;
        this.ref = ref;
        this.re_step = re_step;
        this.re_level = re_level;
        this.post_idx = post_idx;
    }

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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public int getRef() {
        return ref;
    }

    public void setRef(int ref) {
        this.ref = ref;
    }

    public int getRe_step() {
        return re_step;
    }

    public void setRe_step(int re_step) {
        this.re_step = re_step;
    }

    public int getRe_level() {
        return re_level;
    }

    public void setRe_level(int re_level) {
        this.re_level = re_level;
    }

    public int getPost_idx() {
        return post_idx;
    }

    public void setPost_idx(int post_idx) {
        this.post_idx = post_idx;
    }
}