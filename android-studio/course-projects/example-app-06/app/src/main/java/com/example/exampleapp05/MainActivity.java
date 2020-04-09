package com.example.exampleapp05;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;

public class MainActivity extends AppCompatActivity {

    public void onClickFade(View view) {
        Log.i("click", "image tapped");

        ImageView im = (ImageView) findViewById(R.id.imageView);

        im.setAlpha(1);
        im.setScaleX(0.5f);
        im.setScaleY(0.5f);
        im.animate()
                .rotation(100)
                .scaleX(2)
                .alpha(1)
                .setDuration(2000);

    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }
}
