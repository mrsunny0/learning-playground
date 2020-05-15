package com.example.androidstudioextras.activities;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.res.Configuration;
import android.graphics.Typeface;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;
import android.widget.Button;
import android.widget.TextView;

import com.example.androidstudioextras.R;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        AutoCompleteTextView autoCompleteTextView = findViewById(R.id.autoCompleteTextView);

        String[] friends = {
                "Nick",
                "Rick",
                "Sara",
                "James",
                "Nina", "Nanny", "Noel"
        };

        // set autocomplete suggestions
        ArrayAdapter<String> arrayAdapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, friends);
        autoCompleteTextView.setAdapter(arrayAdapter);
        autoCompleteTextView.setThreshold(2);
    }

    public void goPIP(View view) {
        // enter picture and picture
        enterPictureInPictureMode();
    }

    public void next(View view) {
        Intent intent = new Intent(this, SecondActivity.class);
        startActivity(intent);
    }

    @Override
    public void onPictureInPictureModeChanged(boolean isInPictureInPictureMode, Configuration newConfig) {
        super.onPictureInPictureModeChanged(isInPictureInPictureMode, newConfig);

        AutoCompleteTextView autoCompleteTextView = findViewById(R.id.autoCompleteTextView);
        Button pipButton = findViewById(R.id.pipButton);

        if (isInPictureInPictureMode) {
            // going into PIP
            autoCompleteTextView.setVisibility(View.INVISIBLE);
            pipButton.setVisibility(View.INVISIBLE);
            getSupportActionBar().hide();
        } else {
            // going out of PIP
            autoCompleteTextView.setVisibility(View.VISIBLE);
            pipButton.setVisibility(View.VISIBLE);
            getSupportActionBar().show();
        }
    }
}
