package com.example.myapplication;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
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

public class userActivity extends AppCompatActivity {
    private Button submit, back2, deleteUser;

    String id, pass, name, home, phone, pass2;

    private EditText idEdit, passEdit, passEdit2, usrname, usraddress, phoneNumber;

    Intent intent;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_userchange);

        submit = findViewById(R.id.submit);
        deleteUser = findViewById(R.id.deleteUser);
        back2 = findViewById(R.id.back2);
        //del = findViewById(R.id.del);
        idEdit = findViewById(R.id.idEdit);
        passEdit = findViewById(R.id.passEdit);
        passEdit2 = findViewById(R.id.passEdit2);
        usrname = findViewById(R.id.usrname);
        usraddress = findViewById(R.id.usraddress);
        phoneNumber = findViewById(R.id.phoneNumber);

        submit.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {

                /*if (passEdit.getText().toString().equals(passEdit2.getText().toString())) {
                    sendRequest();
                } else {
                    Toast.makeText(userActivity.this, "비밀번호 확인하세요", Toast.LENGTH_SHORT).show();
                    passEdit.setText("");
                    passEdit2.setText("");
                }*/
                if (idEdit.getText().toString().trim().equals("") ||
                        passEdit.getText().toString().trim().equals("") ||
                        passEdit2.getText().toString().trim().equals("") ||
                        usrname.getText().toString().trim().equals("") ||
                        usraddress.getText().toString().trim().equals("") ||
                        phoneNumber.getText().toString().trim().equals("")) {
                    Toast.makeText(userActivity.this, "모든 항목을 입력하세요", Toast.LENGTH_SHORT).show();
                } else if (!passEdit.getText().toString().equals(passEdit2.getText().toString())) {
                    Toast.makeText(userActivity.this, "비밀번호 확인하세요", Toast.LENGTH_SHORT).show();
                    passEdit.setText("");
                    passEdit2.setText("");
                } else {
                    sendRequest();
                }
            }

        });

        deleteUser.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                new AlertDialog.Builder(userActivity.this)
                        .setMessage("탈퇴하시겠습니까?")
                        .setPositiveButton("예", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {
                                sendRequestDeleteUser();
                            }
                        })
                        .setNegativeButton("아니요", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {
                            }
                        })
                        .create().show();
            }
        });

        back2.setOnClickListener(new View.OnClickListener() {

            public void onClick(View v) {
                // Switch to join activity
                Intent intent = new Intent(userActivity.this, MainActivity.class);
                startActivity(intent);
            }


        });

        SharedPreferences sharedPref = getApplicationContext().getSharedPreferences("userInfo", Context.MODE_PRIVATE);
        String id = sharedPref.getString("id", "");
        idEdit.setText(id);

    }

    public void sendRequest() {
        String url = "http://172.245.179.217:8080/htdocs/cap/userupdate.jsp";
        // String url = "http://10.0.2.2:8000/cap/userupdate.jsp";
        StringRequest request = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {

            //응답을 잘 받았을 때 이 메소드가 자동으로 호출
            @Override
            public void onResponse(String response) {
                System.out.println(("응답 -> " + response));
                try {
                    JSONObject jsonObject = new JSONObject(response);
                        /*id = jsonObject.getString("id");
                        pass = jsonObject.getString("password");
                        pass2 = jsonObject.getString("password2");
                        name = jsonObject.getString("nickname");
                        home = jsonObject.getString("home_address");
                        phone = jsonObject.getString("phone_number");*/

                        /*if (id.equals(String.valueOf(mId.getText())) && pass.equals(String.valueOf(mPass.getText()))) {
                            intent = new Intent(userActivity.this, MainActivity.class);
                            SharedPreferences sp = getApplicationContext().getSharedPreferences("userInfo", Context.MODE_PRIVATE);
                            SharedPreferences.Editor editor = sp.edit();
                            editor.putString("id", id);
                            editor.putString("pass", pass);
                            editor.putString("name", name);
                            editor.putString("home", home);
                            editor.putString("phone", phone);
                            editor.apply();
                            startActivity(intent);
                        }*/


                    boolean success = jsonObject.getBoolean("success");
                    if (success) {
                        Toast.makeText(getApplicationContext(), "회원수정 성공", Toast.LENGTH_SHORT).show();
                        Intent intent = new Intent(userActivity.this, MainActivity.class);
                        startActivity(intent);
                    } else {
                        Toast.makeText(getApplicationContext(), "닉네임 중복", Toast.LENGTH_SHORT).show();
                        usrname.setText("");

                    }
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
                //params.put("id", "5555");
                //params.put("pass","5555");
                params.put("user_id", String.valueOf(idEdit.getText()));
                params.put("password", String.valueOf(passEdit.getText()));
                params.put("password2", String.valueOf(passEdit2.getText()));
                params.put("nickname", String.valueOf(usrname.getText()));
                params.put("home_address", String.valueOf(usraddress.getText()));
                params.put("phone_number", String.valueOf(phoneNumber.getText()));
                return params;
            }
        };

        request.setShouldCache(false);
        RequestQueue queue = Volley.newRequestQueue(userActivity.this);
        queue.add(request);
    }



    public void sendRequestDeleteUser() {
        String url = "http://172.245.179.217:8080/htdocs/cap/deleteUser.jsp";

        StringRequest request = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
            //응답을 잘 받았을 때 이 메소드가 자동으로 호출
            @Override
            public void onResponse(String response) {
                System.out.println(("응답 -> " + response));
                try {
                    JSONObject jsonObject = new JSONObject(response);
                    boolean success = jsonObject.getBoolean("success");

                    if (success) {
                        Toast.makeText(getApplicationContext(), "회원탈퇴 성공", Toast.LENGTH_SHORT).show();
                        Intent intent = new Intent(userActivity.this, LoginActivity.class);
                        startActivity(intent);
                    } else {
                        Toast.makeText(getApplicationContext(), "회원탈퇴 실패", Toast.LENGTH_SHORT).show();
                    }
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
        RequestQueue queue = Volley.newRequestQueue(userActivity.this);
        queue.add(request);
    }
}