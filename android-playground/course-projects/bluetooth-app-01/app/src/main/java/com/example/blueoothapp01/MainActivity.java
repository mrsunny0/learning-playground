package com.example.blueoothapp01;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;

import android.Manifest;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothProfile;
import android.bluetooth.BluetoothSocket;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;

import java.io.IOException;
import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    ListView listView;
    TextView statusTextView;
    Button searchButton;
    ArrayList<String> bluetoothDevices = new ArrayList<>();
    ArrayAdapter arrayAdapter;
    BluetoothAdapter bluetoothAdapter;


    private final BroadcastReceiver broadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            // Log.i("Action", action);

            // re-enable button when discovery is finished
            if (BluetoothAdapter.ACTION_DISCOVERY_FINISHED.equals(action)) {
                statusTextView.setText("Finished");
                searchButton.setEnabled(true);
            } else if (BluetoothDevice.ACTION_FOUND.equals(action)) {
                BluetoothDevice device = intent.getParcelableExtra(BluetoothDevice.EXTRA_DEVICE);
                String name = device.getName();
                String address = device.getAddress();
                String rssi = Integer.toString(intent.getShortExtra(BluetoothDevice.EXTRA_RSSI, Short.MIN_VALUE));
                String deviceString = "";
                if (name != null) {
                    Log.i("Device Found", "Name: " + name + " Address: " + address + " RSSI: " + rssi);
                    deviceString = "Name: " + name + "\tRSSI: " + rssi + "dBm";
                    if (!bluetoothDevices.contains(deviceString)) {
                        bluetoothDevices.add(deviceString);
                    }
                    arrayAdapter.notifyDataSetChanged();

//                    connect to device
//                    if (name.equals("NTEST-TEST")) {
//                        Log.i("clicked", "CONNECTED");
//                        device.createBond();
//                    }
                }
            }
        }
    };

//    private class ConnectThread extends Thread {
//        private final BluetoothSocket mmSocket;
//        private final BluetoothDevice mmDevice;
//
//        public ConnectThread(BluetoothDevice device) {
//            BluetoothSocket tmp = null;
//            mmDevice = device;
//        }
//
//        try {
//            tmp = mmDevice.createRfcommSocketToServiceRecord();
//        } catch (IOException e) {
//            Log.e("error", "Sockets create method failed", e);
//        }
//        mmSocket = tmp;
//
//        public void run() {
//
//        }
//    }

    public void searchClicked(View view) {
        statusTextView.setText("Searching...");
        searchButton.setEnabled(false);
        bluetoothDevices.clear();
        bluetoothAdapter.startDiscovery();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // ask for permission
        ActivityCompat.requestPermissions(this,new String[]{Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.ACCESS_COARSE_LOCATION}, 1001); //Any number

        // set up variables
        listView = findViewById(R.id.listView);
        statusTextView = findViewById(R.id.statusTextView);
        searchButton = findViewById(R.id.searchButton);

        // set up view
        arrayAdapter = new ArrayAdapter(this, android.R.layout.simple_list_item_1, bluetoothDevices);
        listView.setAdapter(arrayAdapter);

        // set up bluetooth
        bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction(BluetoothAdapter.ACTION_STATE_CHANGED);
        intentFilter.addAction(BluetoothDevice.ACTION_FOUND);
        intentFilter.addAction(BluetoothAdapter.ACTION_DISCOVERY_STARTED);
        intentFilter.addAction(BluetoothAdapter.ACTION_DISCOVERY_FINISHED);
        intentFilter.addAction(BluetoothDevice.ACTION_NAME_CHANGED);
        registerReceiver(broadcastReceiver, intentFilter);

        // set up service routine
//        private BluetoothProfile.ServiceListener profileListener = new BluetoothProfile.ServiceListener() {
//            @Override
//            public void onServiceConnected(int profile, BluetoothProfile proxy) {
//
//            }
//
//            @Override
//            public void onServiceDisconnected(int profile) {
//
//            }
//        }

    }
}
