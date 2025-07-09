package com.example.myapplication;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.recyclerview.widget.RecyclerView;

import com.bumptech.glide.Glide;

import java.util.ArrayList;

public class MyRecyclerViewAdapter extends RecyclerView.Adapter<MyViewHolder> {

    //리사이클러뷰에 넣을 데이터 리스트
    ArrayList<PostData> arrayList;
    Context context;
    String currentCategory;

    //생성자를 통하여 데이터 리스트 context를 받음
    public MyRecyclerViewAdapter(Context context, ArrayList<PostData> arrayList, String currentCategory) {
        this.arrayList = arrayList;
        this.context = context;
        this.currentCategory = currentCategory;
    }

    @NonNull
    @Override
    public MyViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.post_data_item, parent, false);

        return new MyViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull MyViewHolder holder, int position) {
        String idx = String.valueOf(arrayList.get(position).getIdx());
        String user_id = arrayList.get(position).getUser_id();
        String postCategory = arrayList.get(position).getCategory();
        String postTitle = arrayList.get(position).getTitle();
        String postDate = arrayList.get(position).getDate();
        String postViews = String.valueOf(arrayList.get(position).getView());
        String postThum = arrayList.get(position).getThum();
        String replyCount = String.valueOf(arrayList.get(position).getReplyCount());

        holder.postIdx.setText(idx);
        holder.postUserId.setText(user_id);
        holder.postCategory.setText(postCategory);
        holder.postTitle.setText(postTitle);
        holder.postDate.setText(postDate);
        holder.postViews.setText(postViews);
        holder.postReplyCount.setText(replyCount);

        if (currentCategory.equals("not") || currentCategory.equals("use")) {
            holder.postReplyCount_wrap.setVisibility(View.GONE);
        }

        // glide 라이브러리
        // IPv4 주소를 넣기 (cmd에서 ipconfig)
        if (!postThum.equals("null")) {
            Glide.with(context).load("http://172.245.179.217:8080/" + postThum)
                    .error(R.drawable.image_error).into(holder.postThum);
        }

        holder.constraintLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (currentCategory.equals("ask") && !(holder.login_id.equals(user_id) || holder.login_id.equals("admin"))) {
                    Toast.makeText(context, "본인이 작성한 글만 확인할 수 있습니다.", Toast.LENGTH_SHORT).show();
                } else {
                    Toast.makeText(context, "인덱스:" + idx + "번의 레이아웃 클릭", Toast.LENGTH_SHORT).show();
                    Intent intent = new Intent(context, DetailActivity.class);
                    intent.putExtra("CURRENT_ACTIVITY", "PostActivity");
                    intent.putExtra("category", postCategory);
                    intent.putExtra("idx", idx);
                    intent.putExtra("user_id", user_id);
                    context.startActivity(intent);
                }
            }
        });
    }

    @Override
    public int getItemCount() {
        //데이터 리스트의 크기를 전달해주어야 함
        return arrayList.size();
    }
}

class MyViewHolder extends RecyclerView.ViewHolder {
    TextView postIdx, postCategory;

    ConstraintLayout constraintLayout;
    ImageView postThum;
    TextView postTitle;
    TextView postUserId;
    TextView postDate;
    TextView postViews;
    TextView postReplyCount;
    String login_id;

    LinearLayout postReplyCount_wrap;

    public MyViewHolder(@NonNull View itemView) {
        super(itemView);
        postIdx = (TextView) itemView.findViewById(R.id.postIdx);
        postCategory = (TextView) itemView.findViewById(R.id.postCategory);

        constraintLayout = (ConstraintLayout) itemView.findViewById(R.id.constraintLayout1);
        postThum = (ImageView) itemView.findViewById(R.id.postThum);
        postTitle = (TextView) itemView.findViewById(R.id.postTitle);
        postUserId = (TextView) itemView.findViewById(R.id.postUserId);
        postDate = (TextView) itemView.findViewById(R.id.postDate);
        postViews = (TextView) itemView.findViewById(R.id.postViews);
        postReplyCount = (TextView) itemView.findViewById(R.id.postReplyCount);
        postReplyCount_wrap = (LinearLayout) itemView.findViewById(R.id.postReplyCount_wrap);

        SharedPreferences sharedPref = itemView.getContext().getSharedPreferences("userInfo", Context.MODE_PRIVATE);
        login_id = sharedPref.getString("id", "");
    }
}

class PostData {
    private int idx;
    private String user_id;
    private String category;
    private String title;
    private String content;
    private String thum;
    private String date;
    private int view;
    private int replyCount;

    public PostData(int idx, String user_id, String category, String title, String content, String thum, String date, int view, int replyCount) {
        this.idx = idx;
        this.user_id = user_id;
        this.category = category;
        this.title = title;
        this.content = content;
        this.thum = thum;
        this.date = date;
        this.view = view;
        this.replyCount = replyCount;
    }

    public int getIdx() { return idx; }
    public void setIdx(int idx) { this.idx = idx; }

    public String getUser_id() { return user_id; }
    public void setUser_id(String user_id) { this.user_id = user_id; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getThum() { return thum; }
    public void setThum(String thum) { this.thum = thum; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    public int getView() { return view; }
    public void setView(int view) { this.view = view; }

    public int getReplyCount() { return replyCount; }
    public void setReplyCount(int replyCount) { this.replyCount = replyCount; }
}