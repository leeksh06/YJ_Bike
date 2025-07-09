package com.example.myapplication;


import android.annotation.SuppressLint;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONException;
import org.json.JSONObject;

import java.text.BreakIterator;
import java.util.HashMap;
import java.util.Map;

public class JoinActivity extends AppCompatActivity {
    private Button Back2, Submit;
    private EditText mUserId, mUserPwd, mUserPwd2, mUserName, mUserHome, mUserPhone;
    private String UserId, UserPwd, UserPwd2, UserName, UserHome, UserPhone;



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_join);


        Submit = findViewById(R.id.submit);
        Back2 = findViewById(R.id.back2);

        mUserId = findViewById(R.id.User_Id);
        mUserPwd = findViewById(R.id.User_Pwd);
        mUserPwd2 = findViewById(R.id.User_Pwd2);
        mUserName = findViewById(R.id.User_Name);
        mUserHome = findViewById(R.id.User_Home);
        mUserPhone = findViewById(R.id.User_Phone);
        // 제이슨 객체를 통해 리스폰의 들어갈 값들을 비교 후 계산



        Submit.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {

                if (mUserId.getText().toString().trim().equals("") ||
                        mUserPwd.getText().toString().trim().equals("") ||
                        mUserPwd2.getText().toString().trim().equals("") ||
                        mUserName.getText().toString().trim().equals("") ||
                        mUserHome.getText().toString().trim().equals("") ||
                        mUserPhone.getText().toString().trim().equals("")) {
                    Toast.makeText(JoinActivity.this, "모든 항목을 입력하세요", Toast.LENGTH_SHORT).show();
                } else if (!mUserPwd.getText().toString().equals(mUserPwd2.getText().toString())) {
                    Toast.makeText(JoinActivity.this, "비밀번호 확인하세요", Toast.LENGTH_SHORT).show();
                    mUserPwd.setText("");
                    mUserPwd2.setText("");
                } else {
                    sendRequest();
                }
            }
        });


        Back2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // Switch to join activity
                Intent intent = new Intent(JoinActivity.this, LoginActivity.class);
                startActivity(intent);
            }
        });

        
    }

    public void sendRequest() {
        String url = "http://172.245.179.217:8080/htdocs/cap/joinProcess.jsp";
        //String url = "http://10.0.2.2:8000/cap/joinProcess.jsp";
        StringRequest request = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {

            //응답을 잘 받았을 때 이 메소드가 자동으로 호출
            @Override
            public void onResponse(String response) {
                System.out.println(("응답 -> " + response));
                try {
                    JSONObject jsonObject = new JSONObject(response);
                    boolean success = jsonObject.getBoolean("success");
                    if (success) {
                        Toast.makeText(getApplicationContext(), "회원가입 성공", Toast.LENGTH_SHORT).show();
                        Intent intent = new Intent(JoinActivity.this, LoginActivity.class);
                        startActivity(intent);
                    }
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                error.printStackTrace();
            }
        }) {
            @Override
            protected Map<String, String> getParams() throws AuthFailureError {
                Map<String, String> params = new HashMap<String, String>();
                params.put("user_id", String.valueOf(mUserId.getText()));
                params.put("password", String.valueOf(mUserPwd.getText()));
                params.put("password2", String.valueOf(mUserPwd2.getText()));
                params.put("nickname",String.valueOf(mUserName.getText()));
                params.put("home_address",String.valueOf(mUserHome.getText()));
                params.put("phone_number",String.valueOf(mUserPhone.getText()));
                return params;
            }
        };

        request.setShouldCache(false);
        RequestQueue queue = Volley.newRequestQueue(JoinActivity.this);
        queue.add(request);

    }

}

