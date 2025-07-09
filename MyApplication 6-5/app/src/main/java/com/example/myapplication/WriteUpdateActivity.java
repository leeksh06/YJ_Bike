package com.example.myapplication;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.ClipData;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.util.Base64;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class WriteUpdateActivity extends AppCompatActivity {

    Button back1, reg_button;

    String[] items;

    String idx, user_id, category, title, content, thum, view, selectedCategory, getTime, id, currentActivity;

    EditText title_et, content_et;
    TextView user;


    RecyclerView recyclerView;
    Button update_btnPickImage;
    ArrayList<ImageData> imageDataArrayList = new ArrayList<>();
    WriteRecyclerViewAdapter imageAdapter;
    ArrayList<String> totalImageNameArrList = new ArrayList<>();
    Date date;
    StringBuilder sbRealImage = new StringBuilder();
    StringBuilder sbTotalImage = new StringBuilder();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_write_update);


        reg_button = findViewById(R.id.reg_button);
        user = findViewById(R.id.user);
        Spinner spinner = findViewById(R.id.spinner);
        content_et = findViewById(R.id.content_et);
        title_et = findViewById(R.id.title_et);


        currentActivity = getIntent().getStringExtra("CURRENT_ACTIVITY");
        idx = getIntent().getStringExtra("idx");
        title = getIntent().getStringExtra("title");
        category = getIntent().getStringExtra("category");
        content = getIntent().getStringExtra("content");
        thum = getIntent().getStringExtra("thum");
        System.out.println("진짜 : " + thum);
        // "images/ "
        title_et.setText(title);
        content_et.setText(content);

        SharedPreferences sharedPref = getApplicationContext().getSharedPreferences("userInfo", Context.MODE_PRIVATE);
        id = sharedPref.getString("id", "");

        if (id.equals("admin")) {
            // Admin user
            items = new String[]{"자유게시판", "문의", "사용방법", "공지사항",};
        } else {
            // Regular user
            items = new String[]{"자유게시판", "문의"};
        }


        user.setText(id); //id값을 가져와서 넣기위해 사용


        long now = System.currentTimeMillis();
        date = new Date(now);
//        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
//        getTime = dateFormat.format(date);//날짜를 String으로 저장


        ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, items);
        adapter.setDropDownViewResource(
                android.R.layout.simple_spinner_dropdown_item
        );
        spinner.setAdapter(adapter);


        spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> adapterView, View view, int position, long viewId) {
                selectedCategory = "";
                if (id.equals("admin")) {
                    switch (position) {
                        case 0:
                            selectedCategory = "free";
                            break;
                        case 1:
                            selectedCategory = "ask";
                            break;
                        case 2:
                            selectedCategory = "use";
                            break;
                        case 3:
                            selectedCategory = "not";
                            break;
                    }
                } else {
                    switch (position) {
                        case 0:
                            selectedCategory = "free";
                            break;
                        case 1:
                            selectedCategory = "ask";
                            break;
                    }
                }
                // 저장하려는 String 형식의 값(selectedCategory) 사용
            }//spinner가 선택한 값을 지정

            @Override
            public void onNothingSelected(AdapterView<?> adapterView) {
                // Do nothing
            }
        });

        reg_button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (title_et.getText().toString().trim().equals("") ||
                        content_et.getText().toString().trim().equals("") ||
                        selectedCategory.trim().equals("")) {
                    Toast.makeText(WriteUpdateActivity.this, "모든 항목을 입력하세요", Toast.LENGTH_SHORT).show();
                } else {
                    for (int i = 0; i < totalImageNameArrList.size(); i++) {
                        sbTotalImage.append(totalImageNameArrList.get(i)).append(",");
                    }
                    for (int i = 0; i < imageDataArrayList.size(); i++) {
                        sbRealImage.append(imageDataArrayList.get(i).getImageName()).append(",");
                    }
                    System.out.println("전체 이미지 개수 : " + totalImageNameArrList.size());
                    System.out.println("전송할 이미지 개수 : " + imageDataArrayList.size());
                    System.out.println("삭제할 이미지 개수 : " + (totalImageNameArrList.size() - imageDataArrayList.size()));
                    System.out.println("전체 이미지 : " + sbTotalImage.toString());
                    System.out.println("진짜 이미지 : " + sbRealImage.toString());
                    sendRequest();
                }
            }
        });

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


        update_btnPickImage = findViewById(R.id.update_btnPickImage);
        recyclerView = findViewById(R.id.update_imageRecycler);

        imageAdapter = new WriteRecyclerViewAdapter(this, imageDataArrayList);
        recyclerView.setLayoutManager(new LinearLayoutManager(this, RecyclerView.HORIZONTAL, false));
        recyclerView.setAdapter(imageAdapter);

        if (thum != null && !thum.equals("")) {
            String[] tempThumArr = thum.split(" ");
            String imageFolderPath = "http://172.245.179.217:8080/";
            for (int i = 0; i < tempThumArr.length; i++) {
                String imageName = tempThumArr[i].substring(tempThumArr[i].indexOf("/") + 1);
                totalImageNameArrList.add(imageName);
                imageDataArrayList.add(new ImageData(imageName, imageFolderPath + tempThumArr[i]));
            }
        }

        update_btnPickImage.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(Intent.ACTION_PICK);
                intent.setType(MediaStore.Images.Media.CONTENT_TYPE);
                intent.putExtra(Intent.EXTRA_ALLOW_MULTIPLE, false);
                intent.setData(MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
                startActivityForResult(intent, 1);
            }
        });

        imageAdapter.setOnItemClickListener(new WriteRecyclerViewAdapter.OnItemClickListener() {
            @Override
            public void onItemClick(View v, int pos) {
                imageDataArrayList.remove(pos);
                imageAdapter.notifyItemRemoved(pos);
            }
        });
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (data != null) {
            ClipData clipData = data.getClipData();
            System.out.println("clipData getItemCount : " + clipData.getItemCount());
            for (int i = 0; i < clipData.getItemCount(); i++) {
                Uri imageUri = clipData.getItemAt(i).getUri();
                String encodingImage;
                try {
                    Bitmap bitmap = null;

                    bitmap = MediaStore.Images.Media.getBitmap(getApplicationContext().getContentResolver(), imageUri);

                    ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                    bitmap.compress(Bitmap.CompressFormat.JPEG, 100, outputStream);
                    byte[] byteArray = outputStream.toByteArray();
                    encodingImage = Base64.encodeToString(byteArray, Base64.DEFAULT).replace("\n", "");
                } catch (IOException e) {
                    System.out.println("2번에러 : " + e.getMessage());
                    throw new RuntimeException(e);
                }

                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy_MM_dd");
                dateFormat.format(date);
                UUID uuid = UUID.randomUUID();
                String path = imageUri.getPath();
                String temp = path.replace(path.substring(path.lastIndexOf("/")), "");
                String ext = temp.substring(temp.lastIndexOf("/") + 1);
                String fileName = dateFormat.format(date) + "_" + uuid + "." + ext;
                System.out.println("이름 : " + fileName);
                imageDataArrayList.add(new ImageData(fileName, String.valueOf(imageUri)));
                totalImageNameArrList.add(fileName);
                uploadImage(encodingImage, fileName);
            }
            imageAdapter.notifyDataSetChanged();
        }
    }

    public void uploadImage(String base64Image, String fileName) {
        String url = "http://172.245.179.217:8080/htdocs/cap/uploadImage.jsp";
//        String url = "http://10.0.2.2:8000/cap/uploadImage.jsp";
//        String url = "http://10.0.2.2:8080/android/uploadImage.jsp";

        StringRequest request = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {

            //응답을 잘 받았을 때 이 메소드가 자동으로 호출
            @Override
            public void onResponse(String response) {
                System.out.println(("응답 -> " + response));

            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
            }
        }) {
            @Override
            protected Map<String, String> getParams() throws AuthFailureError {
                Map<String, String> params = new HashMap<String, String>();
                params.put("base64_image", base64Image);
                params.put("fileName", fileName);

                return params;
            }
        };

        request.setShouldCache(false);
        RequestQueue queue = Volley.newRequestQueue(WriteUpdateActivity.this);
        queue.add(request);
    }

    public void sendRequest() {
        String url = "http://172.245.179.217:8080/htdocs/cap/writeUpdate.jsp";
        //String url = "http://10.0.2.2:8000/cap/writeUpdate.jsp";

        StringRequest request = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {

            //응답을 잘 받았을 때 이 메소드가 자동으로 호출
            @Override
            public void onResponse(String response) {
                System.out.println(("응답 -> " + response));
                try {
                    JSONObject jsonObject = new JSONObject(response);
                    boolean success = jsonObject.getBoolean("success");
                    if (success) {
                        Toast.makeText(getApplicationContext(), "수정 성공", Toast.LENGTH_SHORT).show();
                        Intent intent;
                        String currentActivity = getIntent().getStringExtra("CURRENT_ACTIVITY");
                        if (currentActivity.equals("PostActivity")) {
                            intent = new Intent(WriteUpdateActivity.this, PostActivity.class);
                            intent.putExtra("category", category);
                        } else if (currentActivity.equals("list5Activity")) {
                            intent = new Intent(WriteUpdateActivity.this, list5Activity.class);
                        } else {
                            intent = new Intent(WriteUpdateActivity.this, RankingActivity.class);
                        }
                        startActivity(intent);
                    } else {
                        Toast.makeText(getApplicationContext(), "수정 실패", Toast.LENGTH_SHORT).show();
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
                params.put("idx", idx);
                params.put("user_id", String.valueOf(user.getText()));//user완료
                params.put("category", String.valueOf(selectedCategory));//카테고리 완료
                params.put("title", String.valueOf(title_et.getText()));//제목 완료
                params.put("content", String.valueOf(content_et.getText()));//내용 완료

                // 전체 이미지
                params.put("total_image", sbTotalImage.toString());
                // 실제 이미지
                params.put("real_image", sbRealImage.toString());


//                System.out.println("여기\n : "
//                        + idx+ "\n"
//                        + String.valueOf(user.getText()) + "\n"
//                        + selectedCategory + "\n"
//                        + String.valueOf(title_et.getText()) + "\n"
//                        + String.valueOf(content_et.getText()) + "\n"
//                        + String.valueOf(thum) + "\n"
//                        + String.valueOf(getTime) + "\n"
//                );
                return params;
            }
        };

        request.setShouldCache(false);
        RequestQueue queue = Volley.newRequestQueue(WriteUpdateActivity.this);
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
            intent = new Intent(WriteUpdateActivity.this, PostActivity.class);
            intent.putExtra("category", category);
        } else if (currentActivity.equals("list5Activity")) {
            intent = new Intent(WriteUpdateActivity.this, list5Activity.class);
        } else {
            intent = new Intent(WriteUpdateActivity.this, RankingActivity.class);
        }
        startActivity(intent);
    }
}