package com.example.myapplication;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import androidx.appcompat.app.AppCompatActivity;

public class list5Activity extends AppCompatActivity {
    private Button Drawer;
    private Button back1;




    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_list5);

//        Drawer.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                // Switch to join activity
//
//
//            }
//        });



        back1 = findViewById(R.id.back);



        back1.setOnClickListener(new View.OnClickListener() {

            public void onClick(View v) {
                // Switch to join activity
                Intent intent = new Intent(list5Activity.this, MainActivity.class);
                startActivity(intent);
            }

        });
        Button reg_button = findViewById(R.id.reg_button);

        reg_button.setOnClickListener(new View.OnClickListener() {

            public void onClick(View v) {
                // Switch to join activity
                Intent intent = new Intent(list5Activity.this, payActivity.class);
                intent.putExtra("CURRENT_ACTIVITY", "list5Activity");
                startActivity(intent);
            }

        });
    }

}
