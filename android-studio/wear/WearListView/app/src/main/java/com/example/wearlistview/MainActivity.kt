package com.example.wearlistview

import android.os.Bundle
import android.support.wearable.activity.WearableActivity
import android.view.View
import android.widget.AdapterView
import android.widget.ArrayAdapter
import android.widget.ListView
import android.widget.Toast

class MainActivity : WearableActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val listView = findViewById<ListView>(R.id.listView)

        val friends = arrayOf(
                "Joe",
                "Ralph",
                "Sara",
                "HELLO",
                "Joe",
                "Ralph",
                "Sara",
                "HELLO"
        )

        val arrayAdapter = ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, friends)

        listView.apply {
            adapter = arrayAdapter
        }

        listView.onItemClickListener = AdapterView.OnItemClickListener { adapterView: AdapterView<*>, view1: View, i: Int, l: Long ->
            Toast.makeText(this, friends[i], Toast.LENGTH_SHORT).show()
        }

        // Enables Always-on
        setAmbientEnabled()
    }
}
