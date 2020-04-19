package com.example.practiceappble_2;

import androidx.appcompat.app.AppCompatActivity;

import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothGatt;
import android.bluetooth.BluetoothGattCallback;
import android.bluetooth.BluetoothGattCharacteristic;
import android.bluetooth.BluetoothGattDescriptor;
import android.bluetooth.BluetoothGattService;
import android.bluetooth.BluetoothProfile;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.text.method.CharacterPickerDialog;
import android.util.Log;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.TextView;

import com.example.practiceappble.R;

import org.w3c.dom.Text;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.zip.Inflater;

public class SecondActivity extends AppCompatActivity {

    // elements
    TextView textViewName;
    TextView textViewDetails;
    Button buttonConnect;
    ListView listView;

    // bluetooth
    BluetoothGatt GATT;
    BluetoothGattCallback gattCallBack;
    BluetoothDevice device;
    List<BluetoothGattService> services;
    BluetoothGattService service;

    // data storage
    ArrayList<String> infoList = new ArrayList<>();
    SimpleAdapter  arrayAdapter;
    // ArrayAdapter<String>  arrayAdapter;
    List<Map<String, String>> serviceChars = new ArrayList<>();

    // connect toggle
    boolean connectToggle = true;

    // GATT constants
    protected static final UUID notifyUUID = UUID.fromString("00002902-0000-1000-8000-00805f9b34fb");
    boolean SERVICES_DISCOVERED = false;

    /**
     * onCreate
     */
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);

        // get elements
        listView = findViewById(R.id.listViewData);
        textViewName = findViewById(R.id.deviceNameText);
        textViewDetails = findViewById(R.id.deviceDetailsText);
        buttonConnect = findViewById(R.id.connectButton);

        // get device
        Intent intent = getIntent();
        device = intent.getParcelableExtra("device");

        // change names
        // String details = "";
        // details += device.getAddress() + "\n";
        // details += device.getType() + "\n";
        textViewName.setText(device.getName());
        textViewDetails.setText(device.getAddress());

        // set up adaptor
        arrayAdapter = new SimpleAdapter(
                this,
                serviceChars,
                android.R.layout.simple_list_item_2,
                new String[] {"service", "characteristic"},
                new int[] {android.R.id.text1, android.R.id.text2}
            );
        // arrayAdapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, infoList);
        listView.setAdapter(arrayAdapter);

        // set listView callback
        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                // need to clean slate
                // stop reading from characteristic of current stored service
                // change color of UI
                cleanSlate();

                // check if the current service needs to be stopped
                boolean enable = true;
                if (service == services.get(position)) {
                    enable = false;
                } else {
                    // change view UI
                    view.setBackgroundColor(Color.parseColor("#D3D3D3"));

                    // get new service
                    enable = true;
                    service = services.get(position);
                    Log.i("CONNECTION", "Service specified: " + service.getUuid().toString());
                }

                // loop through characteristic and either turn on or off notification
                List<BluetoothGattCharacteristic> characteristics = service.getCharacteristics();
                for (BluetoothGattCharacteristic characteristic : characteristics) {
                    enableCharacteristic(characteristic, enable);
                }
            }
        });
    }

    /**
     * Create menu
     */
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.menu, menu);
        return true;
    }

    /**
     * Menu option click
     */
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // handle item selection
        switch (item.getItemId()) {
            // return to home screen
            case R.id.home:
                disconnectDevice();
                Log.i("menu", "Pressed home");
                finish();
                break;

            // logout of current user
            case R.id.logout:
                break;
        }
        return true;
    }

    /**
     * Connect button callback
     */
    public void onConnect(View view) {
        // connect
        if (connectToggle) {
            Log.i("DEVICE", "Connecting device");
            connectDevice(device);
            buttonConnect.setText("DISCONNECT");

            // keep on waiting until GATT status says connected
            try {
                buttonConnect.setText("CONNECTING");
                while (SERVICES_DISCOVERED != true) {
                    Thread.sleep(1000);
                }
            } catch (InterruptedException e) {
                Log.i("CONNECTION", "Connection was interrupted\n");
                e.printStackTrace();
            }
            arrayAdapter.notifyDataSetChanged();

        }
        // disconnect
        else {
            Log.i("DEVICE", "Disconnecting device");
            disconnectDevice();
            buttonConnect.setText("CONNECT");
        }
        // if toggle is on (to be connected), negate
        connectToggle = !connectToggle;
    }

    /**
     * Connect to device
     */
    private void connectDevice(BluetoothDevice device) {
        // create gatt callback
        gattCallBack = new BluetoothGattCallback() {
            @Override
            public void onConnectionStateChange(BluetoothGatt gatt, int status, int newState) {
                super.onConnectionStateChange(gatt, status, newState);
                if (status == BluetoothGatt.GATT_FAILURE) {
                    disconnectDevice();
                    return;
                }
                else if (status != BluetoothGatt.GATT_SUCCESS) {
                    disconnectDevice();
                    return;
                }

                if (newState == BluetoothProfile.STATE_CONNECTED) {
                    Log.i("CONNECTION", "Connected");
                    GATT.discoverServices();
                }
                else if (newState == BluetoothProfile.STATE_DISCONNECTED) {
                    disconnectDevice();
                    return;
                }
            }

            @Override
            public void onServicesDiscovered(BluetoothGatt gatt, int status) {
                super.onServicesDiscovered(gatt, status);
                Log.i("CONNECTION", "Discovering services");

                // loop through services
                services = GATT.getServices();
                for (BluetoothGattService service: services) {
                    String characteristicString = "";
                    List<BluetoothGattCharacteristic> characteristics = service.getCharacteristics();
                    Map<String, String> item = new HashMap<>();
                    item.put("service", service.getUuid().toString());

                    // loop through characteristics
                    for (BluetoothGattCharacteristic characteristic : characteristics) {
                        characteristicString += "\t\t\t" + characteristic.getUuid().toString() + "\n";
                    }

                    // store characteristic in item
                    item.put("characteristic", characteristicString);

                    // store data to be presented into listView
                    serviceChars.add(item);
                    infoList.add(characteristicString);
                }

                // set connected to true, all information has been found
                SERVICES_DISCOVERED = true;
            }

            @Override
            public void onCharacteristicChanged(BluetoothGatt gatt, BluetoothGattCharacteristic characteristic) {
                super.onCharacteristicChanged(gatt, characteristic);
                readCharacteristic(characteristic);
            }

            @Override
            public void onCharacteristicRead(BluetoothGatt gatt, BluetoothGattCharacteristic characteristic, int status) {
                super.onCharacteristicRead(gatt, characteristic, status);
                readCharacteristic(characteristic);
            }
        };

        // connect device
        GATT = device.connectGatt(this, false, gattCallBack);
    }

    /**
     * Disconnect device
     */
    private void disconnectDevice() {
        GATT.disconnect();
        GATT.close();
    }

    /**
     * Enable characteristic notification read
     */
    private void enableCharacteristic(BluetoothGattCharacteristic characteristic, boolean toggle) {
        GATT.setCharacteristicNotification(characteristic, toggle);
        BluetoothGattDescriptor descriptor = characteristic.getDescriptor(notifyUUID);
        if (descriptor != null) {
            if (toggle) {
                descriptor.setValue(BluetoothGattDescriptor.ENABLE_INDICATION_VALUE);
                Log.i("CONNECTION", "Enabling characteristic notification");
            } else {
                descriptor.setValue(BluetoothGattDescriptor.DISABLE_NOTIFICATION_VALUE);
                Log.i("CONNECTION", "Disabling characteristic notification");
            }
            GATT.writeDescriptor(descriptor);
        }
    }

    /**
     * Read characteristics
     */
    private String readCharacteristic(BluetoothGattCharacteristic characteristic) {
        byte[] b = characteristic.getValue();
        String s = null;
        try {
            s = new String(b, "UTF-8");
            Log.i("DATA", s);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return s;
    }

    /**
     * Clean slate
     * Remove any connections and put UI back to original state
     */
    public void cleanSlate() {
        // remove any coloring
        Log.i("MISC", "listView: " + listView.getChildCount());
        Log.i("MISC", "arrayAdaptor: " + arrayAdapter.getCount());

        for (int i = 0; i < arrayAdapter.getCount(); i++) {
            View view = arrayAdapter.getView(i, null, null);
            view.setBackgroundColor(Color.parseColor("#FFFFFF"));
        }
        arrayAdapter.notifyDataSetChanged();

        // disconnect from current service, if there is even one connected
        if (service != null) {
            List<BluetoothGattCharacteristic> characteristics = service.getCharacteristics();
            for (BluetoothGattCharacteristic characteristic : characteristics) {
                enableCharacteristic(characteristic, false);
            }
        }
    }
}
