package com.example.myapplication;

import androidx.appcompat.app.AppCompatActivity;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class MainActivity extends AppCompatActivity {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Button btn = findViewById(R.id.userTest);
        Button btnNot = findViewById(R.id.btnNot);
        Button btnUse = findViewById(R.id.btnUse);
        Button btnFree = findViewById(R.id.btnFree);
        Button btnAsk = findViewById(R.id.btnAsk);

        Button btnRanking = findViewById(R.id.btnRanking);
        Button logout = findViewById(R.id.logout);



        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(MainActivity.this, userActivity.class);
                startActivity(intent);
            }
        });

        // 게시판들
        Button[] btnPosts = {btnNot, btnUse, btnFree, btnAsk};
        String[] btnPostCategory = {"not", "use", "free", "ask"};
        for (int i = 0; i < btnPosts.length; i++) {
            int temp = i;
            btnPosts[temp].setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(MainActivity.this, PostActivity.class);
                    intent.putExtra("category", btnPostCategory[temp]);
                    startActivity(intent);
                }
            });
        }



        btnRanking.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(MainActivity.this, RankingActivity.class);
                intent.putExtra("category", "rank");
                startActivity(intent);
            }
        });




        logout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                open(v);
            }
        });


    }

    public void open(View view) {
        AlertDialog.Builder builder = new AlertDialog.Builder(MainActivity.this);
        builder.setMessage("로그아웃 하시겠습니까?");


        builder.setPositiveButton("아니요", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int id) {
            }
        });

        builder.setNegativeButton("예", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int id) {
                Intent intent = new Intent(MainActivity.this, LoginActivity.class);
                startActivity(intent);

            }
        });

        builder.create();
        builder.show();

    }
    @Override
    public void onBackPressed() {
        //super.onBackPressed();
    }

}