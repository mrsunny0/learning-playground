package com.example.practiceappble;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;

import android.Manifest;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothGatt;
import android.bluetooth.BluetoothGattCallback;
import android.bluetooth.BluetoothGattCharacteristic;
import android.bluetooth.BluetoothGattDescriptor;
import android.bluetooth.BluetoothGattService;
import android.bluetooth.BluetoothManager;
import android.bluetooth.BluetoothProfile;
import android.bluetooth.le.BluetoothLeScanner;
import android.bluetooth.le.ScanCallback;
import android.bluetooth.le.ScanFilter;
import android.bluetooth.le.ScanResult;
import android.bluetooth.le.ScanSettings;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

public class MainActivity extends AppCompatActivity {

    // elements
    ListView listView;
    Button searchButton;
    TextView statusText;
    ArrayAdapter arrayAdapter;

    // bluetooth
    BluetoothAdapter bluetoothAdapter;
    BluetoothManager bluetoothManager;
    BluetoothScanCallback bluetoothScanCallback;
    BluetoothLeScanner bluetoothLeScanner;
    BluetoothGatt GATT;
    BluetoothGattCallback gattCallBack;

    // data holder
    HashMap<String, BluetoothDevice> scanResults = new HashMap<>();
    ArrayList<BluetoothDevice> deviceList = new ArrayList<>();

    // GATT constants
    protected static final UUID notifyUUID = UUID.fromString("00002902-0000-1000-8000-00805f9b34fb");


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // get elements
        searchButton = findViewById(R.id.searchButton);
        statusText = findViewById(R.id.statusText);
        listView = findViewById(R.id.listView);

        // setup bluetooth
        bluetoothManager = (BluetoothManager) getSystemService(BLUETOOTH_SERVICE);
        bluetoothAdapter = bluetoothManager.getAdapter();

        // set up array adaptor
        arrayAdapter = new ArrayAdapter(this, android.R.layout.simple_list_item_2, android.R.id.text1, deviceList) {
            @NonNull
            @Override
            public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
                View view = super.getView(position, convertView, parent);
                TextView text1 = (TextView) view.findViewById(android.R.id.text1);
                TextView text2 = (TextView) view.findViewById(android.R.id.text2);

                BluetoothDevice device = deviceList.get(position);
                text1.setText(device.getName());
                text2.setText(device.getAddress());

                return view;
            }
        };

        // create callback for listview
        listView.setAdapter(arrayAdapter);
        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                // stop scan
                stopScan();

                // connect to bluetooth device
                BluetoothDevice device = deviceList.get(position);
                connectDevice(device);
            }
        });

    }

    /**
     * On search click
     */
    public void onSearch(View view) {
        // check if bluetooth is available
        if (bluetoothAdapter == null) {
            Log.i("BLE", "No device found, exiting");
            return;
        }

        // check if BLE is supported
        if (!getPackageManager().hasSystemFeature(PackageManager.FEATURE_BLUETOOTH_LE)) {
            Log.i("BLE", "BLE is not supported");
            return;
        }

        // enable bluetooth
        if (!bluetoothAdapter.isEnabled()) {
            Intent enableIntent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
            startActivityForResult(enableIntent, 1);
        } else {
            Log.i("BLE", "Bluetooth adaptor enabled");
        }

        // ask for permission, if not already granted
        if (checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            requestPermissions(new String[] {Manifest.permission.ACCESS_FINE_LOCATION}, 1);
        } else {
            Log.i("PERMISSION", "Permission already granted");
        }

        // change UI
        statusText.setText("Scanning...");
        searchButton.setEnabled(false);

        // start scan
        startScan();
    }

    /**
     * Start scan
     */
    private void startScan() {
        List<ScanFilter> filters = new ArrayList<>();
        ScanSettings settings = new ScanSettings.Builder()
                .setScanMode(ScanSettings.SCAN_MODE_LOW_POWER)
                .build();
        bluetoothScanCallback = new BluetoothScanCallback();
        bluetoothLeScanner = bluetoothAdapter.getBluetoothLeScanner();
        bluetoothLeScanner.startScan(filters, settings, bluetoothScanCallback);
        Log.i("SCAN", "Starting scan");
    }

    /**
     * Stop scan
     */
    private void stopScan() {
        // change text
        statusText.setText("Finished");
        searchButton.setEnabled(true);

        // stop the same callback used by startScan
        bluetoothLeScanner.stopScan(bluetoothScanCallback);
        Log.i("SCAN", "Stopping scan");
    }

    /**
     * Bluetooth scan callback
     */
    private class BluetoothScanCallback extends ScanCallback {
        @Override
        public void onScanResult(int callbackType, ScanResult result) {
            addScanResult(result);
        }

        @Override
        public void onBatchScanResults(List<ScanResult> results) {
            for (ScanResult result : results) {
                addScanResult(result);
            }
        }

        @Override
        public void onScanFailed(int errorCode) {
            Log.i("SCAN", "Failed to scan, error code: " + errorCode);
        }

        private void addScanResult(ScanResult result) {
            BluetoothDevice device = result.getDevice();

            // check for nulls
            if (device != null && device.getName() != null) {

                // check for duplicates
                if (!deviceList.contains(device)) {
                    String deviceAddress = device.getAddress();

                    // store
                    deviceList.add(device);
                    scanResults.put(deviceAddress, device);

                    // update listView
                    arrayAdapter.notifyDataSetChanged();
                }
            }
        }
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
                    Log.i("CONNECTION", "Discovery services");
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
                List<BluetoothGattService> services = GATT.getServices();
                for (BluetoothGattService service : services) {
                    Log.i("GATT", service.toString());
                    List<BluetoothGattCharacteristic> characteristics = service.getCharacteristics();
                    for (BluetoothGattCharacteristic characteristic : characteristics) {
                        Log.i("GATT", "\t" + characteristic.toString());

                        // enable notify callback
                        // for now, on all characteristics
                        GATT.setCharacteristicNotification(characteristic, true);
                        BluetoothGattDescriptor descriptor = characteristic.getDescriptor(notifyUUID);
                        if (descriptor != null) {
                            descriptor.setValue(BluetoothGattDescriptor.ENABLE_INDICATION_VALUE);
                            GATT.writeDescriptor(descriptor);
                        }
                    }
                }

            }

            @Override
            public void onCharacteristicChanged(BluetoothGatt gatt, BluetoothGattCharacteristic characteristic) {
                super.onCharacteristicChanged(gatt, characteristic);
                byte[] b = characteristic.getValue();
                String s = null;
                try {
                    s = new String(b, "UTF-8");
                    Log.i("DATA", s);
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
            }

            @Override
            public void onCharacteristicRead(BluetoothGatt gatt, BluetoothGattCharacteristic characteristic, int status) {
                super.onCharacteristicRead(gatt, characteristic, status);
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
     * Read characteristics
     */
    // private byte[] readCharacteristic(characteristic) {
    //     return
    // }

    /**
     * Permission handler
     */
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == 1) {
            if (grantResults.length > 0) {
                if (checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION) == grantResults[0]) {
                    // start scan
                    Log.i("PERMISSION", "Permission granted");
                    startScan();
                }
            }
        }
    }
}
