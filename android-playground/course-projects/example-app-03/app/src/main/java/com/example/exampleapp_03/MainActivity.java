package com.example.exampleapp_03;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    public void convertCurrency(View view) {
        Log.i("clicked", "clicked");

        EditText currency = (EditText) findViewById(R.id.editTextCurrency);
        String text_currency = currency.getText().toString();
        if (text_currency.matches("")) {
            Toast.makeText(this, "You did not put anything", Toast.LENGTH_SHORT).show();
        } else {
            int number = Integer.parseInt(text_currency);
            Toast.makeText(this, "New Currency: " + 2*number + "!", Toast.LENGTH_SHORT).show();
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }
}
