package com.example.myapplication;

import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class RankingActivity extends AppCompatActivity {
    private Button Drawer;
    private Button back1;

    RecyclerView rankingRecyclerView;
    RankingRecyclerAdapter rankingAdapter;
    ArrayList<RankingData> rankingDataArrayList = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_ranking);

        rankingRecyclerView = (RecyclerView) findViewById(R.id.ranking_recycler);

//        Drawer.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                // Switch to join activity
//
//            }
//        });

        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        getSupportActionBar().setDisplayShowHomeEnabled(true);
        getSupportActionBar().setDisplayShowTitleEnabled(false);
        toolbar.setNavigationOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onBackPressed();
            }
        });


        rankingAdapter = new RankingRecyclerAdapter(this, rankingDataArrayList);
        rankingRecyclerView.setLayoutManager(new LinearLayoutManager(this, RecyclerView.VERTICAL, false));
        rankingRecyclerView.setAdapter(rankingAdapter);
        request();
    }

    public void request() {
        String url = "http://172.245.179.217:8080/htdocs/cap/Ranking.jsp";
//        String url = "http://10.0.2.2:8000/cap/Ranking.jsp";
//        String url = "http://10.0.2.2:8080/android/Ranking.jsp";

        StringRequest request = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {

            //응답을 잘 받았을 때 이 메소드가 자동으로 호출
            @Override
            public void onResponse(String response) {
                System.out.println("랭킹 -> " + response);
                if (!response.trim().equals("")) {
                    try {
                        JSONObject jsonObject = new JSONObject(response);
                        JSONArray jsonArray = jsonObject.getJSONArray("ranking");
                        for (int i = 0; i < jsonArray.length(); i++) {
                            JSONObject itemObject = jsonArray.getJSONObject(i);
                            String nickname = itemObject.getString("nickname");
                            String distance = itemObject.getString("distance");

                            rankingDataArrayList.add(new RankingData(nickname, distance));
                        }
                        rankingAdapter.notifyDataSetChanged();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                } else {
                    System.out.println("빈값");
                }
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
            }
        }) {
            @Override
            protected Map<String, String> getParams() throws AuthFailureError {
                Map<String, String> params = new HashMap<String, String>();
//                params.put("fileName", fileName);

                return params;
            }
        };

        request.setShouldCache(false);
        RequestQueue queue = Volley.newRequestQueue(RankingActivity.this);
        queue.add(request);
    }

    public boolean onOptionsItemSelected(MenuItem item) {
        if (item.getItemId() == android.R.id.home) {
            onBackPressed();
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    public void onBackPressed() {
        Intent intent = new Intent(RankingActivity.this, MainActivity.class);
        startActivity(intent);
    }

}