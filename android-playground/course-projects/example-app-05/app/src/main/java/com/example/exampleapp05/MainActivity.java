package com.example.exampleapp05;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {


    public class Number {
        int value;

        // constructor
        public Number(int v) {
            this.value = v;
        }

        // check triangular
        public boolean isTriangular() {
            int counter = 1;
            int triangular_number = 1;
            while (triangular_number < value) {
                triangular_number = triangular_number + counter + 1;
                counter++;
            }
            if (triangular_number == value) {
                return true;
            } else {
                return false;
            }
        }

        // check square
        public boolean isSquare() {
            double sqrt = Math.sqrt(value);
            if (sqrt == Math.floor(sqrt)) {
                return true;
            } else {
                return false;
            }
        }

        // print statement
        public String print() {
            return "number is square: " + this.isSquare() + "\nnumber is triangular: " + this.isTriangular();
        }

    }

    public void checkNumber(View view) {
        EditText input = (EditText) findViewById(R.id.editTextNumber);

        int input_number = Integer.parseInt(input.getText().toString());
        Number number = new Number(input_number);

        Toast.makeText(this,
                number.print(),
                Toast.LENGTH_SHORT).show();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }
}
