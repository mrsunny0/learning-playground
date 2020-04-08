package com.example.exampleapp_01;

import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    public void clickFunction(View view) {
        EditText nameEditText = (EditText) findViewById(R.id.editTextName);
        String name = nameEditText.getText().toString();

        Log.i("Pressed", "Clicked");
        Log.i("Pressed", name);

        Toast.makeText(this, "Hello, " + name, Toast.LENGTH_LONG).show();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }
}
