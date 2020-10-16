package com.example.peoplecounter

import android.os.Bundle
import android.support.wearable.activity.WearableActivity
import android.view.View
import android.widget.TextView

class MainActivity : WearableActivity() {

    private lateinit var textView: TextView
    private var count = 0

    fun plusOne(view: View) {
       count += 1
        textView.text = count.toString()
    }

    fun reset(view: View) {
        count = 0
        textView.text = count.toString()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        textView = findViewById(R.id.text)
        // textView.text = "NEW"

        // Enables Always-on
        setAmbientEnabled()
    }
}
