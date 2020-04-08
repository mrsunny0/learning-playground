package com.example.exampleapp04;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import java.util.Random;

public class MainActivity extends AppCompatActivity {

    int rand_number;
    public void generateRandomNumber() {
        Random random = new Random();
        rand_number = random.nextInt(20) + 1;
    }

    public void validateGuess(View view) {
        Log.i("click", "guess button clicked");
        Toast.makeText(this, ""+rand_number, Toast.LENGTH_LONG).show();

        // get text
        EditText guess = (EditText) findViewById(R.id.editTextGuess);
        String text = guess.getText().toString();

        // capture input number
        int value = 0;
        if (text.matches("")) {
            Toast.makeText(this, "You did not guess", Toast.LENGTH_SHORT).show();
        } else {
            value = Integer.parseInt(text);
        }

        // see if it matches
        String message = "";
        if (rand_number > value) {
            message = "HIGHER";
        } else if (rand_number < value) {
            message = "LOWER";
        } else if (rand_number == value) {
            message = "CORRECT!";
            generateRandomNumber();
        }

        // toast
        Toast.makeText(this, message, Toast.LENGTH_SHORT).show();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        generateRandomNumber();
    }
}
