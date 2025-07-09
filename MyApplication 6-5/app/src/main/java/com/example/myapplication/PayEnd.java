package com.example.myapplication;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

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

public class PayEnd  extends AppCompatActivity {

    Button checking;

    TextView edidText, edusraddress,edphoneNumber,edmoney;

    String home, phone;

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_payend);

        checking = findViewById(R.id.checking);
        edidText = findViewById(R.id.edidText);

        edusraddress = findViewById(R.id.edusraddress);

        edphoneNumber = findViewById(R.id.edphoneNumber);

        edmoney = findViewById(R.id.edmoney);

        int currentValue = getIntent().getIntExtra("payMoney", 0);

        edmoney.setText(String.valueOf(currentValue));


        SharedPreferences sharedPref = getApplicationContext().getSharedPreferences("userInfo", Context.MODE_PRIVATE);
        String id = sharedPref.getString("id", "");

        edidText.setText(id);



        checking.setOnClickListener(new View.OnClickListener() {

            public void onClick(View v) {
                // Switch to join activity
                Intent intent = new Intent(PayEnd.this, MainActivity.class);
                startActivity(intent);
            }


        });

        sendRequest();
    }


    public void sendRequest() {

        String url = "http://172.245.179.217:8080/htdocs/cap/payEnd.jsp";
        // String url = "http://10.0.2.2:8000/cap/payEnd.jsp";
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
                    phone = jsonObject.getString("phone_number");
                    edusraddress.setText(home);
                    edphoneNumber.setText(phone);


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
                params.put("user_id", String.valueOf(edidText.getText()));
                return params;
            }
        };

        request.setShouldCache(false);
        RequestQueue queue = Volley.newRequestQueue(PayEnd.this);
        queue.add(request);
    }
}
