package com.example.myapplication;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
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

public class LoginActivity extends AppCompatActivity {
    private Button loginButton, joinButton;
    private EditText mId, mPass;

    private long backpressedTime = 0;
    Intent intent;



    String user_id , pass, pass2, name, home, phone;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);


        loginButton = findViewById(R.id.loginbutton);
        joinButton = findViewById(R.id.joinbutton);


        mId = findViewById(R.id.editID);
        mPass= findViewById(R.id.ediPassword);

        // 제이슨 객체를 통해 리스폰의 들어갈 값들을 비교 후 계산

        loginButton.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {
                sendRequest();
            }

        });
        joinButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // Switch to join activity
                Intent intent = new Intent(LoginActivity.this, JoinActivity.class);
                startActivity(intent);

            }
        });
    }
        public void sendRequest() {
            String url = "http://172.245.179.217:8080/htdocs/cap/loginProcess.jsp";
            //ftp://administrator@172.245.179.217/ROOT/htdocs/cap/loginProcess.jsp
            //String url = "http://10.0.2.2:8000/cap/loginProcess.jsp";
            StringRequest request = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {

                //응답을 잘 받았을 때 이 메소드가 자동으로 호출
                @Override
                public void onResponse(String response) {
                    System.out.println(("응답 -> " + response));
                    try {
                        JSONObject jsonObject = new JSONObject(response);
                        user_id = jsonObject.getString("user_id");
                        pass = jsonObject.getString("password");
                        pass2 = jsonObject.getString("password2");
                        name = jsonObject.getString("nickname");
                        home = jsonObject.getString("home_address");
                        phone = jsonObject.getString("phone_number");

                        if (user_id.equals(String.valueOf(mId.getText())) && pass.equals(String.valueOf(mPass.getText()))) {
                            intent = new Intent(LoginActivity.this, MainActivity.class);
                            SharedPreferences sp = getApplicationContext().getSharedPreferences("userInfo", Context.MODE_PRIVATE);
                            SharedPreferences.Editor editor = sp.edit();
                            editor.putString("id", user_id);
                            editor.putString("password", pass);
                            editor.putString("password2", pass2);
                            editor.putString("nickname", name);
                            editor.putString("home_address", home);
                            editor.putString("phone_number", phone);
                            editor.apply();
                            Toast.makeText(LoginActivity.this, name + "님 환영합니다.", Toast.LENGTH_SHORT).show();
                            startActivity(intent);
                        }


                    } catch (JSONException e) {
                        e.printStackTrace();
                        Toast.makeText(LoginActivity.this, "로그인에 실패.", Toast.LENGTH_SHORT).show();
                        mId.setText("");
                        mPass.setText("");
                    }
                }
            },
                    new Response.ErrorListener() {
                        @Override //에러 발생시 호출될 리스너 객체
                        public void onErrorResponse(VolleyError error) {
                            System.out.println(("서버에러 -> " + error.getMessage()));
                        }
                    }
            ) {
                @Override
                protected Map<String, String> getParams() throws AuthFailureError {
                    Map<String, String> params = new HashMap<String, String>();
                    params.put("user_id", String.valueOf(mId.getText()));
                    params.put("password", String.valueOf(mPass.getText()));
                    //params.put("password2", String.valueOf(mUserPwd2.getText()));
                    //params.put("nickname",String.valueOf(mUserName.getText()));
                    //params.put("home_address",String.valueOf(mUserHome.getText()));
                    //params.put("phone_number",String.valueOf(mUserPhone.getText()));
                    return params;
                }
            };

            request.setShouldCache(false);
            RequestQueue queue = Volley.newRequestQueue(LoginActivity.this);
            queue.add(request);


        }
    public void onBackPressed() {
        if (System.currentTimeMillis() > backpressedTime + 2000) {
            backpressedTime = System.currentTimeMillis();
            Toast.makeText(this, "\'뒤로\' 버튼을 한번 더 누르시면 종료됩니다.", Toast.LENGTH_SHORT).show();
        } else {
            finishAffinity(); // 현재 액티비티를 포함하여 모든 액티비티 종료
            System.exit(0); // 앱 프로세스 종료
        }
    }

}