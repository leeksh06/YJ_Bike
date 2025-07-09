package com.example.myapplication;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.widget.EditText;

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

import java.util.HashMap;
import java.util.Map;


import androidx.appcompat.app.AppCompatActivity;

public class payActivity extends AppCompatActivity {

    EditText idEdit, idpayCommodity,idpaymoney,usraddress,idtext;

    String home;

    TextView count;
    Button back2,plus,minus,submit;

    int currentValue = 1;

    int payMoney = 10000;



    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_pay);

        SharedPreferences sharedPref = getApplicationContext().getSharedPreferences("userInfo", Context.MODE_PRIVATE);
        String id = sharedPref.getString("id", "");


        idEdit = findViewById(R.id.idEdit);
        usraddress = findViewById(R.id.usraddress);
        back2 = findViewById(R.id.back2);
        submit = findViewById(R.id.submit);

        idpaymoney = findViewById(R.id.idpaymoney);
        plus = findViewById(R.id.plus);
        minus = findViewById(R.id.minus);
        count = findViewById(R.id.count);

        count.setText(String.valueOf(currentValue));
        idpaymoney.setText(String.valueOf(payMoney));

        plus.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                currentValue++;
                payMoney += 10000;
                count.setText(String.valueOf(currentValue));
                idpaymoney.setText(String.valueOf(payMoney));
            }
        });

// minus 버튼 클릭 리스너
        minus.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (currentValue > 1) {
                    currentValue--;
                    payMoney -= 10000;
                    count.setText(String.valueOf(currentValue));
                    idpaymoney.setText(String.valueOf(payMoney));
                } else {
                    // 최소 한 개 이상이어야 함을 알리는 알림 표시
                    Toast.makeText(getApplicationContext(), "최소1개.", Toast.LENGTH_SHORT).show();
                }
            }
        });



        idEdit.setText(id);

        sendRequest();


        submit.setOnClickListener(new View.OnClickListener() {

            public void onClick(View v) {
                // Switch to join activity
                Intent intent = new Intent(payActivity.this, PayEnd.class);
                intent.putExtra("payMoney",payMoney);
                startActivity(intent);
            }


        });

        back2.setOnClickListener(new View.OnClickListener() {

            public void onClick(View v) {
                // Switch to join activity
                Intent intent = new Intent(payActivity.this, list5Activity.class);
                startActivity(intent);
            }


        });

    }

    public void sendRequest() {

        String url = "http://172.245.179.217:8080/htdocs/cap/payProcess.jsp";
       // String url = "http://10.0.2.2:8000/cap/payProcess.jsp";
        StringRequest request = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {

            //응답을 잘 받았을 때 이 메소드가 자동으로 호출
            @Override
            public void onResponse(String response) {
                System.out.println(("응답 -> " + response));
                try {
                    JSONObject jsonObject = new JSONObject(response);
                        //id = jsonObject.getString("id");
                        //pass = jsonObject.getString("password");
                        //pass2 = jsonObject.getString("password2");
                        //name = jsonObject.getString("nickname");
                         home = jsonObject.getString("home_address");
                        //phone = jsonObject.getString("phone_number");
                        usraddress.setText(home);


                   /* boolean success = jsonObject.getBoolean("success");
                    if (success) {
                        Toast.makeText(getApplicationContext(), "회원수정 성공", Toast.LENGTH_SHORT).show();
                        Intent intent = new Intent(payActivity.this, MainActivity.class);
                        startActivity(intent);
                    } else {
                        Toast.makeText(getApplicationContext(), "닉네임 중복", Toast.LENGTH_SHORT).show();
                        usrname.setText("");

                    }*/
                } catch (JSONException e) {
                    e.printStackTrace();
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
                params.put("user_id", String.valueOf(idEdit.getText()));
                return params;
            }
        };

        request.setShouldCache(false);
        RequestQueue queue = Volley.newRequestQueue(payActivity.this);
        queue.add(request);
    }
}
