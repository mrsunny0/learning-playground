package com.example.practiceappdownloadcontent;

import androidx.appcompat.app.AppCompatActivity;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class MainActivity extends AppCompatActivity {

    ImageView imageView;
    Button button;

    String url = "http://www.google.com";
    String img = "https://community.cadence.com/resized-image/__size/940x0/__key/communityserver-blogs-components-weblogfiles/00-00-00-01-06/4544.kitten.jpg";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // get elements
        imageView = findViewById(R.id.imageView);
        button = findViewById(R.id.button);
    }

    // on click, get contents
    public void onClick(View view) {

        // download URL
        DownloadURL downloadURL = new DownloadURL();
        try {
            String html = downloadURL.execute(url).get();
            Log.i("HTML", html);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // download image
        DownloadImage downloadImage = new DownloadImage();
        try {
            Bitmap bitmap = downloadImage.execute(img).get();
            imageView.setImageBitmap(bitmap);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    // download async task HTML
    public class DownloadURL extends AsyncTask<String, Void, String> {
        @Override
        protected String doInBackground(String... urls) {
            String html = "";
            try {
                // initiate connection
                URL url = new URL(urls[0]);
                HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                InputStream inputStream = connection.getInputStream();
                InputStreamReader reader = new InputStreamReader(inputStream);

                // bit by bit, loop through
                int data = reader.read();
                while (data != -1) {
                    html += (char) data;
                    data = reader.read();
                }

                // return result
                return html;

            } catch (Exception e) {
                e.printStackTrace();
                return "";
            }
        }
    }

    // download async task image
    public class DownloadImage extends AsyncTask<String, Void, Bitmap> {
        @Override
        protected Bitmap doInBackground(String... urls) {
            try {
                URL url = new URL(urls[0]);
                HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                connection.connect();
                InputStream inputStream = connection.getInputStream();
                Bitmap bitmap = BitmapFactory.decodeStream(inputStream);
                return bitmap;
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        }
    }
}
