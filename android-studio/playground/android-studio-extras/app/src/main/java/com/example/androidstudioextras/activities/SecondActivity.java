package com.example.androidstudioextras.activities;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;

import com.example.androidstudioextras.R;

// personal modules
import com.example.androidstudioextras.adaptors.ItemAdaptor;
import com.example.androidstudioextras.model.Items;
import com.example.androidstudioextras.model.DataModel;

import java.util.ArrayList;

public class SecondActivity extends AppCompatActivity {

    DataModel dataModel = new DataModel();
    ArrayList<Items> items;
    ArrayAdapter<Items> arrayAdapter;
    ListView listView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);

        // work with model package
        dataModel.setA(100000);
        TextView textView = findViewById(R.id.textViewItem);
        textView.setText(Integer.toString(dataModel.getA()));

        // custom list views
        listView = findViewById(R.id.listView);
        items = new ArrayList();
        arrayAdapter = new ItemAdaptor(this, items);
        listView.setAdapter(arrayAdapter);
    }


    public void update(View view) {
        items.add(new Items("1", "hello"));
        items.add(new Items("1", "dea"));
        items.add(new Items("1", "fea"));
        arrayAdapter.notifyDataSetChanged();
    }

}
