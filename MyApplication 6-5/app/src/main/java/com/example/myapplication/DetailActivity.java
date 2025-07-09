package com.example.myapplication;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.constraintlayout.widget.ConstraintLayout;
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

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

public class DetailActivity extends AppCompatActivity {

    TextView date_tv, title_tv, content_tv;
    String idx;
    String user_id, category, title, content, date, id, currentActivity, findcategory;

    Button change_button, del_button, back;

    Intent intent;

    String thum;
    RecyclerView recyclerView, imageRecyclerview;
    ReplyRecyclerViewAdapter adapter;
    WriteRecyclerViewAdapter imageAdapter;

    ArrayList<ReplyData> replyDataArrayList = new ArrayList<>();
    ArrayList<ImageData> imageDataArrayList = new ArrayList<>();

    RequestQueue sendRequestQueue;
    Button replyWrite_button;
    EditText replyWrite_et;

    LinearLayout replyrap;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);

        title_tv = (TextView) findViewById(R.id.title_tv);
        date_tv = (TextView) findViewById(R.id.date_tv);
        content_tv = (TextView) findViewById(R.id.content_tv);
        change_button = (Button) findViewById(R.id.change_button);
        del_button = (Button) findViewById(R.id.del_button);
        replyWrite_button = (Button) findViewById(R.id.replyWrite_button);
        replyWrite_et = new EditText(getApplicationContext());
        ConstraintLayout detail_btnBox = (ConstraintLayout) findViewById(R.id.detail_btnBox);
        replyrap = (LinearLayout) findViewById(R.id.replyrap);

        currentActivity = getIntent().getStringExtra("CURRENT_ACTIVITY");
        category = getIntent().getStringExtra("category");
        idx = getIntent().getStringExtra("idx");

        imageRecyclerview = (RecyclerView) findViewById(R.id.detail_image_recyclerview);

        imageAdapter = new WriteRecyclerViewAdapter(this, imageDataArrayList, "detail");
        imageRecyclerview.setLayoutManager(new LinearLayoutManager(this, RecyclerView.HORIZONTAL, false));
        imageRecyclerview.setAdapter(imageAdapter);
        sendRequest();

        findcategory = category;

        SharedPreferences sharedPref = getApplicationContext().getSharedPreferences("userInfo", Context.MODE_PRIVATE);
        id = sharedPref.getString("id", "");

        System.out.println("게시판 아이디 : " + getIntent().getStringExtra("user_id"));
        System.out.println("쉐어드 아이디 : " + id);
        if (id.equals(getIntent().getStringExtra("user_id"))) {
            change_button.setVisibility(View.VISIBLE);
            del_button.setVisibility(View.VISIBLE);
        } else if (id.equals("admin")) {
            change_button.setVisibility(View.GONE);
            del_button.setVisibility(View.VISIBLE);
        } else {
            change_button.setVisibility(View.GONE);
            del_button.setVisibility(View.GONE);
        }
        if (category != null && (category.equals("not") || category.equals("use"))) {
            replyrap.setVisibility(View.GONE);
        }
        /*back.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                Intent intent2;

                if (currentActivity.equals("PostActivity")) {
                    intent2 = new Intent(DetailActivity.this, PostActivity.class);
                    intent2.putExtra("category", category);
                }
                else if (currentActivity.equals("list5Activity")) {
                    intent2 = new Intent(DetailActivity.this, list5Activity.class);
                }
                else {
                    intent2 = new Intent(DetailActivity.this, list6Activity.class);
                }
                startActivity(intent2);
            }
        });*/


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
        del_button.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                open(v);
            }
        });

        change_button.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                intent = new Intent(DetailActivity.this, WriteUpdateActivity.class);
                intent.putExtra("CURRENT_ACTIVITY", "PostActivity");
                intent.putExtra("idx", idx);
                intent.putExtra("title", title);
                intent.putExtra("category", category);
                intent.putExtra("content", content);
                intent.putExtra("thum", thum);
                startActivity(intent);

            }
        });

        recyclerView = findViewById(R.id.replyRecyclerView);
        adapter = new ReplyRecyclerViewAdapter(this, replyDataArrayList);
        recyclerView.setAdapter(adapter);
        recyclerView.setLayoutManager(new LinearLayoutManager(this, RecyclerView.VERTICAL, false));

        if (sendRequestQueue == null) {
            sendRequestQueue = Volley.newRequestQueue(getApplicationContext());
        }
        sendReplyRequest();

        replyWrite_button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(DetailActivity.this);
                builder.setTitle("댓글 작성");

                if (replyWrite_et.getParent() != null)
                    ((ViewGroup) replyWrite_et.getParent()).removeView(replyWrite_et);
                replyWrite_et.setText("");
                builder.setView(replyWrite_et);
                builder.setPositiveButton("작성하기", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        replyWriteRequest(idx, replyWrite_et.getText().toString());
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


    public void open(View view) {
        AlertDialog.Builder builder = new AlertDialog.Builder(DetailActivity.this);
        builder.setMessage("삭제하시겠습니까?");


        builder.setPositiveButton("아니요", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int id) {
            }
        });

        builder.setNegativeButton("예", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int id) {
                DelsendRequest();

                Intent intent2;
                if (currentActivity.equals("PostActivity")) {
                    intent2 = new Intent(DetailActivity.this, PostActivity.class);
                    intent2.putExtra("category", category);
                } else if (currentActivity.equals("list5Activity")) {
                    intent2 = new Intent(DetailActivity.this, list5Activity.class);
                } else {
                    intent2 = new Intent(DetailActivity.this, RankingActivity.class);
                }
                startActivity(intent2);

            }
        });

        builder.create();
        builder.show();

    }

    public void sendRequest() {
        String url = "http://172.245.179.217:8080/htdocs/cap/showDetail.jsp";
        //String url = "http://10.0.2.2:8000/cap/showDetail.jsp";

        String imageFolderPath = "http://172.245.179.217:8080/";
        StringRequest request = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {

            //응답을 잘 받았을 때 이 메소드가 자동으로 호출
            @Override
            public void onResponse(String response) {
                System.out.println(("DetailActivity | sendRequest : 응답 -> " + response.trim()));
                try {
                    JSONObject jsonObject = new JSONObject(response);
                    user_id = jsonObject.getString("user_id");
                    category = jsonObject.getString("category");
                    title = jsonObject.getString("title");
                    content = jsonObject.getString("content");
                    date = jsonObject.getString("date");
                    thum = jsonObject.getString("thum");

                    System.out.println("디테일 thum : " + thum);

                    title_tv.setText(title);
                    date_tv.setText(date);
                    content_tv.setText(content);
                    System.out.println("thum=" + thum);
                    if (!thum.equals("")) {
                        String[] tempThumArr = thum.split(" ");
                        for (int i = 0; i < tempThumArr.length; i++) {
                            String imageName = tempThumArr[i].substring(tempThumArr[i].indexOf("/") + 1);
                            imageDataArrayList.add(new ImageData(imageName, imageFolderPath + tempThumArr[i]));
                        }
                        imageAdapter.notifyDataSetChanged();
                    }


//                    System.out.println("여기\n"
//                            +"user_id : " + user_id + "\n"
//                            +"category : " + category + "\n"
//                            +"title : " + title + "\n"
//                            +"content : " + content + "\n"
//                            +"date : " + date + "\n"
//                    );

                } catch (JSONException e) {
                    e.printStackTrace();
                    Toast.makeText(DetailActivity.this, "로그인에 실패.", Toast.LENGTH_SHORT).show();
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
                params.put("idx", idx);

//                System.out.println("파라미터 : " + params);
                return params;
            }
        };

        request.setShouldCache(false);
        RequestQueue queue = Volley.newRequestQueue(DetailActivity.this);
        queue.add(request);
    }

    public void DelsendRequest() {
        String url = "http://172.245.179.217:8080/htdocs/cap/delProcess.jsp";
        //String url = "http://10.0.2.2:8000/cap/delProcess.jsp";
        StringRequest request = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {

            //응답을 잘 받았을 때 이 메소드가 자동으로 호출
            @Override
            public void onResponse(String response) {
                System.out.println(("응답 -> " + response.trim()));
                try {
                    JSONObject jsonObject = new JSONObject(response);


                } catch (JSONException e) {
                    e.printStackTrace();
                    Toast.makeText(DetailActivity.this, "삭제 실패.", Toast.LENGTH_SHORT).show();
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
                params.put("idx", idx);

//                System.out.println("파라미터 : " + params);
                return params;
            }
        };

        request.setShouldCache(false);
        RequestQueue queue = Volley.newRequestQueue(DetailActivity.this);
        queue.add(request);
    }

    public void sendReplyRequest() {
//        String url = "http://10.0.2.2:8000/cap/showReply.jsp";
        String url = "http://172.245.179.217:8080/htdocs/cap/showReply.jsp";
        StringRequest request = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {

            //응답을 잘 받았을 때 이 메소드가 자동으로 호출
            @Override
            public void onResponse(String response) {
                System.out.println(("DetailActivity | sendReplyRequest 응답 -> \n" + response.trim()));
                try {
                    JSONObject jsonObject = new JSONObject(response);
                    JSONArray jsonArray = jsonObject.getJSONArray("replyData");
                    System.out.println("jsonArray 크기 = "+jsonArray.length());
                    for (int i = 0; i < jsonArray.length(); i++) {
                        JSONObject itemObject = jsonArray.getJSONObject(i);
                        int replyIdx = itemObject.getInt("idx");
                        String replyUser_id = itemObject.getString("user_id");
                        String replyContent = itemObject.getString("content");
                        String replyDate = itemObject.getString("date");
                        int replyRef = itemObject.getInt("ref");
                        int replyRe_step = itemObject.getInt("re_step");
                        int replyRe_level = itemObject.getInt("re_level");
//                        int replyPost_idx = itemObject.getInt("post_idx");


                        replyDataArrayList.add(new ReplyData(replyIdx, replyUser_id, replyContent, replyDate, replyRef, replyRe_step, replyRe_level, replyRef));
                    }
                    adapter.notifyDataSetChanged();
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        },
                new Response.ErrorListener() {
                    @Override //에러 발생시 호출될 리스너 객체
                    public void onErrorResponse(VolleyError error) {
                        System.out.println(("댓글 에러 -> " + error.getMessage()));
                    }
                }
        ) {
            @Override
            protected Map<String, String> getParams() throws AuthFailureError {
                Map<String, String> params = new HashMap<String, String>();
                params.put("idx", idx);

                System.out.println("파라미터 : " + params);
                return params;
            }
        };

        request.setShouldCache(false);
        sendRequestQueue.add(request);
    }


    public void replyWriteRequest(String post_idx, String content) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, 0);
        String now = dateFormat.format(cal.getTime());

        String url = "http://172.245.179.217:8080/htdocs/cap/replyWrite.jsp";
        StringRequest request = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
            //응답을 잘 받았을 때 이 메소드가 자동으로 호출
            @Override
            public void onResponse(String response) {
                System.out.println(("댓글작성 응답 -> " + response.trim()));
                if (!response.trim().equals("false")) {
                    try {
                        JSONObject jsonObject = new JSONObject(response);
                        JSONArray jsonArray = jsonObject.getJSONArray("replyData");
                        for (int i = 0; i < jsonArray.length(); i++) {
                            JSONObject itemObject = jsonArray.getJSONObject(i);
                            int idx = Integer.parseInt(itemObject.getString("idx"));
                            String user_id = itemObject.getString("user_id");
                            String content = itemObject.getString("content");
                            String date = itemObject.getString("date");
                            int ref = Integer.parseInt(itemObject.getString("ref"));
                            int re_step = Integer.parseInt(itemObject.getString("re_step"));
                            int re_level = Integer.parseInt(itemObject.getString("re_level"));
                            int post_idx = Integer.parseInt(itemObject.getString("post_idx"));

                            ReplyData data = new ReplyData(idx, user_id, content, date, ref, re_step, re_level, post_idx);
                            replyDataArrayList.add(data);
                        }
                        adapter.notifyItemInserted(replyDataArrayList.size());
                    } catch (JSONException e) {
                        e.printStackTrace();
                        System.out.println(("JSONException 에러 -> " + e.getMessage()));
                    }
                }
            }
        },
                new Response.ErrorListener() {
                    @Override //에러 발생시 호출될 리스너 객체
                    public void onErrorResponse(VolleyError error) {
                        System.out.println(("댓글 작성 실패 에러 -> " + error.getMessage()));
                    }
                }
        ) {
            @Override
            protected Map<String, String> getParams() throws AuthFailureError {
                Map<String, String> params = new HashMap<String, String>();
                params.put("user_id", id);
                params.put("post_idx", post_idx);
                params.put("content", content);
                params.put("date", now);

                return params;
            }
        };

        request.setShouldCache(false);
        RequestQueue queue = Volley.newRequestQueue(DetailActivity.this);
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
        String category = getIntent().getStringExtra("category");
        Intent intent;
        String currentActivity = getIntent().getStringExtra("CURRENT_ACTIVITY");
        if (currentActivity.equals("PostActivity")) {
            intent = new Intent(DetailActivity.this, PostActivity.class);
            intent.putExtra("category", category);
        } else if (currentActivity.equals("list5Activity")) {
            intent = new Intent(DetailActivity.this, list5Activity.class);
        } else {
            intent = new Intent(DetailActivity.this, RankingActivity.class);
        }
        startActivity(intent);
    }
}