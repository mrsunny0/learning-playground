package com.example.exampleapp_02;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    int counter = 0;
    public void changeImage(View view) {
        Log.i("click", "button clicked");
        ImageView im = findViewById(R.id.imageView);
        if (counter % 2 == 0) {
            im.setImageResource(R.drawable.download_2);
        } else {
            im.setImageResource(R.drawable.download);
        }
        counter++;
        Toast.makeText(this, String.valueOf(im.getId()), Toast.LENGTH_SHORT).show();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }
}
