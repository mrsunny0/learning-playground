package com.example.practiceapppermission;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;

import android.Manifest;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    String permissionList[] = {
            Manifest.permission.ACCESS_FINE_LOCATION,
            Manifest.permission.ACCESS_COARSE_LOCATION,
            Manifest.permission.INTERNET,
            Manifest.permission.BLUETOOTH,
            Manifest.permission.BLUETOOTH_ADMIN,
            Manifest.permission.READ_EXTERNAL_STORAGE,
    };
    int N = permissionList.length;
    int rqCode = 0;

    // permission handle function
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);

        // loop through permissions
        for (int i = 0; i < permissions.length; i++) {
            String permission = permissions[i];
            int result = grantResults[i];

            // laboriously iterate through any possible request codes
            for (int j = 0; j < N; j++) {

                // check to see if its the right request code
                if (j == i) {
                    String requestedPermission = permissionList[j];

                    // check to see if request has been granted
                    if (requestedPermission.equals(permission) && result == PackageManager.PERMISSION_GRANTED) {
                        Log.i("granting", "GRANTED PERMISSION FOR " + permission);
                        Toast.makeText(this, "GRANTED PERMISSION FOR " + permission, Toast.LENGTH_SHORT).show();
                    }
                }
            }
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        for (int i = 0; i < N; i++) {
            String permission = permissionList[i];
            if (checkSelfPermission(permission) != PackageManager.PERMISSION_GRANTED) {
                Log.i("requesting", "Requesting permission for " + permission);
                ActivityCompat.requestPermissions(this, permissionList, i);
            } else {
                Log.i("approved", "Already approved request for " + permission);
            }
        }

    }
}
