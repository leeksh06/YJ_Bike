package com.example.myapplication;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;

public class RankingRecyclerAdapter extends RecyclerView.Adapter<RankingViewHolder> {

    //리사이클러뷰에 넣을 데이터 리스트
    ArrayList<RankingData> arrayList;
    Context context;

    //생성자를 통하여 데이터 리스트 context를 받음
    public RankingRecyclerAdapter(Context context, ArrayList<RankingData> arrayList){
        this.arrayList = arrayList;
        this.context = context;
    }

    @NonNull
    @Override
    public RankingViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.ranking_data_item, parent, false);

        return new RankingViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull RankingViewHolder holder, int position) {
        String nickname = String.valueOf(arrayList.get(position).getNickname());
        String distance = String.valueOf(arrayList.get(position).getDistance());

        if (position == 0) {
            holder.ranking_num.setBackgroundResource(R.drawable.rank_first);
        } else if (position == 1) {
            holder.ranking_num.setBackgroundResource(R.drawable.rank_second);
        } else if (position == 2) {
            holder.ranking_num.setBackgroundResource(R.drawable.rank_third);
        } else {
            holder.ranking_num.setText((position+1)+"등");
        }

        holder.ranking_nickname.setText(nickname);
        holder.ranking_distance.setText(distance);

        // glide 라이브러리
        // IPv4 주소를 넣기 (cmd에서 ipconfig)
//        if (!postThum.equals("null")) {
//            Glide.with(context).load("http://localhost:8080/").into(holder.thum);
//        }
    }

    @Override
    public int getItemCount() {
        //데이터 리스트의 크기를 전달해주어야 함
        return arrayList.size();
    }
}

class RankingViewHolder extends RecyclerView.ViewHolder {
    TextView ranking_num;  // 이미지
    TextView ranking_nickname;
    TextView ranking_distance;

    public RankingViewHolder(@NonNull View itemView) {
        super(itemView);
        ranking_num = (TextView) itemView.findViewById(R.id.ranking_num);
        ranking_nickname = (TextView) itemView.findViewById(R.id.ranking_nickname);
        ranking_distance = (TextView) itemView.findViewById(R.id.ranking_distance);
    }
}

class RankingData {
    private String nickname;
    private String distance;

    public RankingData(String nickname, String distance) {
        this.nickname = nickname;
        this.distance = distance;
    }

    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }

    public String getDistance() { return distance; }
    public void setDistance(String distance) { this.distance = distance; }
}