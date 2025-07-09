package com.example.myapplication;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.core.widget.NestedScrollView;
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
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class PostActivity extends AppCompatActivity {
    private Button Drawer;
    private Button back1,reg_button ;

    RecyclerView recyclerView;
    MyRecyclerViewAdapter adapter;

    ArrayList<PostData> postDataArrayList = new ArrayList<>();
    String category;

    RequestQueue sendRequestQueue;

    int page = 1, limit = 10;
    ProgressBar progressBar;
    NestedScrollView nestedScrollView;

    EditText postSearchEt;
    Button postSearchBtn;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_post);

        reg_button = findViewById(R.id.reg_button);
        setPostTitle();

        SharedPreferences sharedPref = getApplicationContext().getSharedPreferences("userInfo", Context.MODE_PRIVATE);
        String id = sharedPref.getString("id", "");
        category = getIntent().getStringExtra("category");

        if (id.equals("admin")) {
            reg_button.setVisibility(View.VISIBLE);
        } else {
            if (category != null && (category.equals("not") || category.equals("use"))) {
                reg_button.setVisibility(View.GONE);
            }
        }

       //여기서 부터
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
        //여기까지 툴바



        reg_button.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                Intent intent = new Intent(PostActivity.this, WriteActivity.class);
                intent.putExtra("CURRENT_ACTIVITY", "PostActivity");
                intent.putExtra("category", category);
                startActivity(intent);
            }
        });



        recyclerView = findViewById(R.id.postRecyclerView);
        adapter = new MyRecyclerViewAdapter(this, postDataArrayList, category);
        recyclerView.setAdapter(adapter);
        recyclerView.setLayoutManager(new LinearLayoutManager(this, RecyclerView.VERTICAL, false));

        if (sendRequestQueue == null) {
            sendRequestQueue = Volley.newRequestQueue(getApplicationContext());
        }
        sendRequest(page, limit, null);

        postSearchEt = (EditText) findViewById(R.id.postSearchEt);
        postSearchBtn = (Button) findViewById(R.id.postSearchBtn);
        postSearchBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String searchWord = postSearchEt.getText().toString();
                postDataArrayList.clear();
                nestedScrollView.scrollTo(0,0);
                page = 1;
                sendRequest(page, limit, searchWord);
            }
        });

        progressBar = (ProgressBar) findViewById(R.id.progressBar);
        progressBar.setVisibility(View.GONE);
        nestedScrollView = (NestedScrollView) findViewById(R.id.postNestedScrollView);
        nestedScrollView.setOnScrollChangeListener(new NestedScrollView.OnScrollChangeListener() {
            @Override
            public void onScrollChange(@NonNull NestedScrollView v, int scrollX, int scrollY, int oldScrollX, int oldScrollY) {
                if (scrollY == v.getChildAt(0).getMeasuredHeight() - v.getMeasuredHeight()) {
                    page++;
                    progressBar.setVisibility(View.VISIBLE);
                    String searchWord = postSearchEt.getText().toString();
                    sendRequest(page, limit, searchWord);
                }
            }
        });
    }

    public void sendRequest(int page, int limit, String search) {
        String url = "http://172.245.179.217:8080/htdocs/cap/showList.jsp";
        //String url = "http://10.0.2.2:8000/cap/showList.jsp";
//        String url = "http://10.0.2.2:8080/android/showList.jsp";
        StringRequest request = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                response = response.trim();
                System.out.println(("응답 -> \n" + response));
                progressBar.setVisibility(View.GONE);
                if (!response.equals("null")) {
                    try {
                        JSONObject jsonObject = new JSONObject(response);
                        JSONArray jsonArray = jsonObject.getJSONArray("data");
                        for (int i = 0; i < jsonArray.length(); i++) {
                            JSONObject itemObject = jsonArray.getJSONObject(i);
                            int idx = Integer.parseInt(itemObject.getString("idx"));
                            String user_id = itemObject.getString("user_id");
                            String category = itemObject.getString("category");
                            String title = itemObject.getString("title");
                            String content = itemObject.getString("content");
                            String thum = itemObject.getString("thum");
                            String date = itemObject.getString("date");
                            int view = Integer.parseInt(itemObject.getString("views"));
                            int replyCount = itemObject.getInt("count");

                            if (!thum.equals("")) {
                                thum = thum.split(" ")[0];
                            }
                            postDataArrayList.add(new PostData(idx, user_id, category, title, content, thum, date, view, replyCount));

//                            System.out.println("찾아봐라" + thum);
                        }
                        adapter.notifyDataSetChanged();
                    } catch (JSONException e) {
                        e.printStackTrace();
                        System.out.println(("JSONException 에러 -> " + e.getMessage()));
                        Toast.makeText(PostActivity.this, "리스트 가져오기에 실패.", Toast.LENGTH_SHORT).show();
                    }
                }

            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                System.out.println(("VolleyError 에러 -> " + error.getMessage()));
                Toast.makeText(PostActivity.this, "리스트 가져오기에 실패.", Toast.LENGTH_SHORT).show();
            }
        }) {
            @Override
            protected Map<String, String> getParams() throws AuthFailureError {
                Map<String, String> params = new HashMap<String, String>();
                params.put("category", category);
                params.put("page", String.valueOf(page));
                params.put("limit", String.valueOf(limit));
                if (search != null) params.put("search", search);
                return params;
            }
        };
        request.setShouldCache(false);
        sendRequestQueue.add(request);
    }

    void setPostTitle(){
        Intent intent = getIntent();

        TextView tvCategory = (TextView) findViewById(R.id.tvCategory);
        String categoryTitle = "";
        if (intent.getStringExtra("category") != null) {
            category = intent.getStringExtra("category");
            switch (category) {
                case "not":
                    categoryTitle = "공지사항";
                    break;
                case "use":
                    categoryTitle = "사용방법";
                    break;
                case "free":
                    categoryTitle = "자유게시판";
                    break;
                case "ask":
                    categoryTitle = "문의게시판";
                    break;
            }
        } else {
            categoryTitle = "XXXXX";
        }
        tvCategory.setText(categoryTitle);
    }


    //여기서 부터
    public boolean onOptionsItemSelected(MenuItem item) {
        if (item.getItemId() == android.R.id.home) {
            onBackPressed();
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    public void onBackPressed() {
        Intent intent = new Intent(PostActivity.this, MainActivity.class);
        startActivity(intent);
    }
    // 여기까지 툴바바
}