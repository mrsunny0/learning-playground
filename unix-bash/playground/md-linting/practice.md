# Android OS 

android packages: https://android-arsenal.com/tag/40

<!-- -------------------------------------------------------- -->
<!-- LOADING DEVICES -->
<!-- -------------------------------------------------------- -->
## Programming :white_check_mark:

<!-- -------- -->
<!-- Emulator -->
<!-- -------- -->
### Emulator :white_check_mark:
[Documentation](https://developer.android.com/studio/run/emulator)
- Install emulator manager on the SKD manager
- Install emulator using the AVD manager

<!-- ------- -->
<!-- Android -->
<!-- ------- -->
### Android Debugging :white_check_mark:
1. Settings
2. About phone (all the way at the bottom)
3. Build number, tap 7 times
4. Developer options
    - USB debugging
    - No sleep

```

<!-- -------------------------------------------------------- -->
<!-- PERMISSIONS -->
<!-- -------------------------------------------------------- -->
## Permission settings :white_check_mark:

### Manifest :white_check_mark:

| Normal                                 | Dangerous                |
|----------------------------------------|--------------------------|
| `ACCESS_LOCATION_EXTRA_COMMANDS`       | `READ_CALENDAR`          |
| `ACCESS_NETWORK_STATE`                 | `WRITE_CALENDAR`         |
| `ACCESS_NOTIFICATION_POLICY`           | `CAMERA`                 |
| `ACCESS_WIFI_STATE`                    | `READ_CONTACTS`          |
| `BLUETOOTH`                            | `WRITE_CONTACTS`         |
| `BLUETOOTH_ADMIN`                      | `GET_ACCOUNTS`           |
| `BROADCAST_STICKY`                     | `ACCESS_FINE_LOCATION`   |
| `CHANGE_NETWORK_STATE`                 | `ACCESS_COARSE_LOCATION` |
| `CHANGE_WIFI_MULTICAST_STATE`          | `RECORD_AUDIO`           |
| `CHANGE_WIFI_STATE`                    | `READ_PHONE_STATE`       |
| `DISABLE_KEYGUARD`                     | `READ_PHONE_NUMBERS`     |
| `EXPAND_STATUS_BAR`                    | `CALL_PHONE`             |
| `GET_PACKAGE_SIZE`                     | `ANSWER_PHONE_CALLS`     |
| `INSTALL_SHORTCUT`                     | `READ_CALL_LOG`          |
| `INTERNET`                             | `WRITE_CALL_LOG`         |
| `KILL_BACKGROUND_PROCESSES`            | `ADD_VOICEMAIL`          |
| `MODIFY_AUDIO_SETTINGS`                | `USE_SIP`                |
| `NFC`                                  | `PROCESS_OUTGOING_CALLS` |
| `READ_SYNC_SETTINGS`                   | `BODY_SENSORS`           |
| `READ_SYNC_STATS`                      | `SEND_SMS`               |
| `RECEIVE_BOOT_COMPLETED`               | `RECEIVE_SMS`            |
| `REORDER_TASKS`                        | `READ_SMS`               |
| `REQUEST_IGNORE_BATTERY_OPTIMIZATIONS` | `RECEIVE_WAP_PUSH`       |
| `REQUEST_INSTALL_PACKAGES`             | `RECEIVE_MMS`            |
| `SET_ALARM`                            | `READ_EXTERNAL_STORAGE`  |
| `SET_TIME_ZONE`                        | `WRITE_EXTERNAL_STORAGE` |
| `SET_WALLPAPER`                        |                          |
| `SET_WALLPAPER_HINTS`                  |                          |
| `TRANSMIT_IR`                          |                          |
| `UNINSTALL_SHORTCUT`                   |                          |
| `USE_FINGERPRINT`                      |                          |
| `VIBRATE`                              |                          |
| `WAKE_LOCK`                            |                          |
| `WRITE_SYNC_SETTINGS`                  |                          |

Example permission manifest `manifests > AndroidManifest.xml`

```xml
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.BLUETOOTH"/>
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
```

### Activity Class :white_check_mark:

Creating a list of permissions to request
```java
String permissionList[] = {
        Manifest.permission.ACCESS_FINE_LOCATION,
        Manifest.permission.ACCESS_COARSE_LOCATION,
        Manifest.permission.INTERNET,
        Manifest.permission.BLUETOOTH,
        Manifest.permission.BLUETOOTH_ADMIN,
        Manifest.permission.READ_EXTERNAL_STORAGE,
};
```

General permission function
```java
ActivityCompat.requestPermissions(this, 
    new String[]{
        Manifest.permission.ACCESS_FINE_LOCATION, 
        Manifest.permission.ACCESS_COARSE_LOCATION,
        ...
        permissionList[N]
    }, 
    requestCode); // request code can be any number, used in request permissio callback
```

Check to see if permission has already been granted. Note that there are several options

- The permissions can be requested all in one go, meaning this if statement needs to catch all possible boolean statements
- Permissiosn are done in a for loop (e.g. `for (String permission : permissionList) ...`); however, each loop needs its own `requestCode` that needs to be tracked
- Call when appropriate, and keep track of `requestCode`

```java
if (checkSelfPermission(Manifest.permission.<PERMISSION>) != PackageManager.PERMISSION_GRANTED) {
    // request permission from ^above code
} else {
    // action if permission has already been granted
}
```

Create callback to handle permission when asked, several optiosn to handle.

- Multiple requests came in with one request code, therefore create a `switch/case` statement to handle the events individually
- Use if statements to handle request one at a time, meaning that `String[] permissions` and `int[] grantResults` have a length of 1

```java
@Override
public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
    super.onRequestPermissionsResult(requestCode, permissions, grantResults);

    // check specific requests
    if (requestCode == rqCode) {
        if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
            // perform action, 
            // store permission OK to global variable, 
            // or call callback when approved
        }
    }

    // OR

    // check by case
    switch (requestCode) {
        case 0:
            // handle permission associated to request code 0
            break;
        case 1:
            // handle permission associated to request code 0
            break;
        // ...
    }

}
```

<!-- -------------------------------------------------------- -->
<!-- HARDWARE -->
<!-- -------------------------------------------------------- -->
## Hardware

<!-- --- -->
<!-- GPS -->
<!-- --- -->
### GPS :white_check_mark:

**Getting started**
- Request an API key
  - https://console.cloud.google.com/google/maps-apis/overview
  - `APIs & Services > Credentials`
  - `APIs` sidebar
  - Click on Maps SDK for Android 
  - Go to `Credentials` top tab
  - Copy and past credential
- For playground and sandboxing applications. On the same page where the credential key is found, go to: 
  - Application restrictions= None
  - API restrictions = None

In the app
- Request for `ACCESS_FINE_LOCATION` permission
- Or use the default Map Activity for a template (permission should already be stated in manifest)
- Add the Maps API key to `google_maps_api.xml`

**Permission**
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```

**Setting Up Location Managers**
```java
// in body
public LocationManager locationManager;
public LocationListener locationListener;

...

// update current location
locationManager = (LocationManager) this.getSystemService(Context.LOCATION_SERVICE);
locationListener = new LocationListener() {
    @Override
    public void onLocationChanged(Location location) {
        // mMap.clear();
        LatLng userLocation = new LatLng(location.getLatitude(), location.getLongitude());
        mMap.addMarker(new MarkerOptions().position(userLocation).title("Your current location"));
        mMap.moveCamera(CameraUpdateFactory.newLatLngZoom(userLocation, 12));
    }

    @Override
    public void onStatusChanged(String provider, int status, Bundle extras) {}

    @Override
    public void onProviderEnabled(String provider) {}
    
    @Override
    public void onProviderDisabled(String provider) {}
};
```

**Listen to position changes**

Note, both `GPS_PROVIDER` and `NETWORK_PROVIDER` must be enabled 
```java
// both GPS and NETWORK providers are needed to listen on
// frequency is every 0 seconds and 0 distance
locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 0, 0, locationListener);
locationManager.requestLocationUpdates(LocationManager.NETWORK_PROVIDER, 0, 0, locationListener);
```

**Managing clicks and response**
```java
// set up onMap long click listener to get positions
mMap.setOnMapLongClickListener(new GoogleMap.OnMapLongClickListener() {
    @Override
    public void onMapLongClick(LatLng latLng) {
        // play default sound
        audioManager.playSoundEffect(SoundEffectConstants.CLICK);

        // store data
        arrayList.add(latLng);

        // put new marker
        mMap.addMarker(new MarkerOptions().position(latLng).title("new location")
            .icon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_YELLOW)));
    }
});
```

**Get last known location**
```java
Location lastKnownLocation = locationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER))
```

**GeoEncoder**

Get specific location from longitude and latitude
```java
// get more data from geoencoder
Geocoder geocoder = new Geocoder(getApplicationContext(), Locale.getDefault());
try {
    // limit to 1 address
    List<Address> listAddresses = geocoder.getFromLocation(latLng.latitude, latLng.longitude, 1);

    // get geocoder information
    if (listAddresses != null && listAddresses.size() > 0) {
        Log.i("Geolocation", listAddresses.get(0).toString());
        String address = "";
        if (listAddresses.get(0).getAdminArea() != null) {
            address += listAddresses.get(0).getAdminArea() + " ";
        }
        if (listAddresses.get(0).getLocality() != null) {
            address += listAddresses.get(0).getLocality() + " ";
        }
        if (listAddresses.get(0).getThoroughfare() != null) {
            address += listAddresses.get(0).getThoroughfare() + " ";
        }
        if (listAddresses.get(0).getPostalCode() != null) {
            address += listAddresses.get(0).getPostalCode() + " ";
        }
    }
} catch (Exception e) {
    e.printStackTrace();
}
```

An example would look like this
```
Address[addressLines=[0:"185 St Marks Ave, Brooklyn, NY 11238, USA"],feature=185,admin=New York,sub-admin=Kings County,locality=null,thoroughfare=Saint Marks Avenue,postalCode=11238,countryCode=US,countryName=United States,hasLatitude=true,latitude=40.679071,hasLongitude=true,longitude=-73.9698219,phone=null,url=null,extras=null]
```

**Bound Markers**

Having multiple markers

```java
LatLngBounds.Builder builder = new LatLngBounds.Builder();
builder.include(new LatLng(...))
builder.include(new LatLng(...))
builder.include(new LatLng(...))
LatLngBounds bounds = builder.buld();
LatLng center = bounds.getCenter();
```

<!-- --------- -->
<!-- Bluetooth -->
<!-- --------- -->
### Bluetooth

**Permission**
```xml
<uses-permission android:name="android.permission.BLUETOOTH" />
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" /> 
<!-- not necessary for Android < 9 -->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```

Permissions using intents
```java
Intent discoverableIntent = new Intent(BluetoothAdapter.ACTION_REQUEST_DISCOVERABLE);
discoverableIntent.putExtra(BluetoothAdapter.EXTRA_DISCOVERABLE_DURATION, 300);
startActivity(discoverableIntent);
```

Permissions using backend requests
```java
ActivityCompat.requestPermissions(this,new String[]{Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.ACCESS_COARSE_LOCATION}, 1); // arbitrary request code
```

Checking if permission has already been granted
```java
if (checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && checkSelfPermission(Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
    // request permission from ^above code
} else {
    // action if permission has already been granted
}
```

Call back for when permission request is returned
```java
// callback for permission access
@Override
public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
    super.onRequestPermissionsResult(requestCode, permissions, grantResults);
    if (requestCode == 1) // this should match the request code from requestPermissions 
    {
        // check to see if the new String[] of permissions provided by requestPermission
        // have been granted by indexing the grantResults array
        if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED && grantResults[1] == PackageManager.PERMISSION_GRANTED) {
            // action if permission has already been granted
        }
    }
}
```

**Discovery** <br>
Set up bluetooth adapter and create intents and actions
```java
// set up adaptor
BluetoothAdapter bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();

// set up intent filter
// and register actions to the receiver
IntentFilter intentFilter = new IntentFilter();
intentFilter.addAction(BluetoothAdapter.ACTION_STATE_CHANGED);
intentFilter.addAction(BluetoothDevice.ACTION_FOUND);
intentFilter.addAction(BluetoothAdapter.ACTION_DISCOVERY_STARTED);
intentFilter.addAction(BluetoothAdapter.ACTION_DISCOVERY_FINISHED);
registerReceiver(broadcastReceiver, intentFilter);

// discover
bluetoothAdapter.startDiscovery();
```

Create a broadcast receiver to handle action states
```java
// create a broadcast receiver
private final BroadcastReceiver broadcastReceiver = new BroadcastReceiver() {
    @Override
    public void onReceive(Context context, Intent intent) {
        String action = intent.getAction();
        switch (action) {
            case BluetoothDevice.ACTION_FOUND:
                // device is found, store 
                break;
        }
    }
};
```

**Connecting To A Device**
```java
fffe
```

**Notification permission**
```java
protected static final UUID CHARACTERISTIC_UPDATE_NOTIFICATION_DESCRIPTOR_UUID = UUID.fromString("00002902-0000-1000-8000-00805f9b34fb");

public boolean setCharacteristicNotification(BluetoothDevice device, UUID serviceUuid, UUID characteristicUuid,
        boolean enable) {
    if (IS_DEBUG)
        Log.d(TAG, "setCharacteristicNotification(device=" + device.getName() + device.getAddress() + ", UUID="
                + characteristicUuid + ", enable=" + enable + " )");
    BluetoothGatt gatt = mGattInstances.get(device.getAddress()); //I just hold the gatt instances I got from connect in this HashMap
    BluetoothGattCharacteristic characteristic = gatt.getService(serviceUuid).getCharacteristic(characteristicUuid);
    gatt.setCharacteristicNotification(characteristic, enable);
    BluetoothGattDescriptor descriptor = characteristic.getDescriptor(CHARACTERISTIC_UPDATE_NOTIFICATION_DESCRIPTOR_UUID);
    descriptor.setValue(enable ? BluetoothGattDescriptor.ENABLE_NOTIFICATION_VALUE : new byte[] { 0x00, 0x00 });
    return gatt.writeDescriptor(descriptor); //descriptor write operation successfully started? 
}
```

<!-- ----------- -->
<!-- Motion Data -->
<!-- ----------- -->
### Motion Data

<!-- ------- -->
<!-- Camera -->
<!-- ------- -->
### Camera


<!-- -------------------------------------------------------- -->
<!-- DATA MANAGEMENT -->
<!-- -------------------------------------------------------- -->
## Data Management
Overview of data management options: https://stackoverflow.com/questions/4878159/whats-the-best-way-to-share-data-between-activities

<!-- ------- -->
<!-- Intents -->
<!-- ------- -->
### Static Methods :white_check_mark:

Warning, this is not a recommended method to pass data between ativities. Variables or classes ([singletons](https://stackoverflow.com/questions/16517702/singleton-in-android)) are declared as static and can be accessed from the Activity class itself. Data persists when going between activities.

`MainActivity.java`
```java
public static ArrayList<string> arrayList = new ArrayList<>();
```

`SecondActivity.java`
```java
String sharedValue = MainActivity.arrayList.get(0);
```

### Intents :white_check_mark:

**Transition between activities**

Sending an intent
```java
Intent intent = new Intent(getApplicationContext(), SecondActivity.class);
intent.putExtra(name, value);
startActivity(intent)
```

Receiving an intent and getting values
```java
Intent intent = getIntent();
String string = intent.getStringExtra(name);
Int int = intent.getIntExtra(name, defaultValue);
```

**Sending an intent for a result**

Sending an intent
```java
startActivityForResult(intent, code);

@Override  
protected void onActivityResult(int requestCode, int resultCode, Intent data) {  
    super.onActivityResult(requestCode, resultCode, data);  
    if(requestCode == code) {  
        // get some data from intent data
    }  
    // or 
    swtich (requestCode) {
        case 0:
            break;
        case 1:
            break;
        ...
    }
}  
```

Returning intent with result code
```java
Intent intent = new Intent(this, FirstActivity.class);
setResult(RESULT_OK, intent);
```


**Intent filters**
```java
```

**Intent flags**
```java
intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP |
                Intent.FLAG_ACTIVITY_CLEAR_TASK | 
                Intent.FLAG_ACTIVITY_NEW_TASK);
```
<!-- ------------------ -->
<!-- Shared Preferences -->
<!-- ------------------ -->
### Shared Preferences

**Serialize** <br>
[ObjectSerializer](http://androiddevcourse.com/ObjectSerializer.html) Class, written by AndroidDevCourse

```java
// create your serialized string
String serializedString = ObjectSerializer.serialize(new ArrayList<>());

// initialize shared preferences
SharedPreferences sharedPreferences = this.getSharedPreferences(
    "com.example.APP_NAME", 
    Context.MODE_PRIVATE);

// store in shared preferences
sharedPreferences.edit().putString("label", serializedString).apply();

// retrieve from shared preferences
String username = sharedPreferences.getString("label", "default");
```

Note that serializable can only serialize List like arrays. So Arraylist works.

**HashSet**<br>
[HashSet](https://www.javatpoint.com/java-hashset), for efficient transfer of data

```java
// create a hashset
HashSet<String> set = new HashSet<>(new ArrayList<>());

// put hashset directly into sharedPreferences
sharedPreferences.edit().putStringSet("label", set);

// receive the hashset directly from getStringSet
(HashSet<>) sharedPreferences.getStringSet("label", null);
```

<!-- ------ -->
<!-- SQLite -->
<!-- ------ -->
### SQLite

```java
SQLiteDatabase dataBase = this.openOrCreateDatabase("Users", MODE_PRIVATE, null);

dataBase.execSQL("CREATE TABLE IF NOT EXISTS users (name VARCHAR, age INT(3))");

dataBase.execSQL("INSERT INTO users (name, age) VALUES ('name', 28)");
dataBase.execSQL("INSERT INTO users (name, age) VALUES ('newname', 34)");
```


Check for existing database
```java
private boolean checkForTableExists(SQLiteDatabase db, String table){
   String sql = "SELECT name FROM sqlite_master WHERE type='table' AND name='"+table+"'";
   Cursor mCursor = db.rawQuery(sql, null);
   if (mCursor.getCount() > 0) {
      return true;
   }
   mCursor.close();
   return false;
}
```

Create cursor and scan
```java
Cursor c = dataBase.rawQuery("SELECT * FROM users WHERE <ABC>", null);

int nameIndex = c.getColumnIndex("name");
int ageIndex = c.getColumnIndex("age");

c.moveToFirst();

while (!c.isAfterLast()) {
    Log.i("name", c.getString(nameIndex));
    Log.i("age", c.getString(ageIndex));
    c.moveToNext();
}
```

Loading queries/statements
```java
String sql = "INSERT INTO news (name, url, json, idx) VALUES (?, ?, ?, ?)";
SQLiteStatement statement = database.compiledStatement(sql);
statement.bind(1, "X");
statement.bind(2, "X");
statement.bind(3, "X");
statement.bind(3, "X");
```


<!-- ------ -->
<!-- Parser -->
<!-- ------ -->
### Parser DB

**Useful Links**
- [Parse open source database](https://parseplatform.org/)
- [Recent Parser version](https://jitpack.io/#parse-community/Parse-SDK-Android)
- https://stackoverflow.com/questions/16624745/how-to-find-a-user-in-a-parseuser-object
- https://www.back4app.com/docs/android/parse-android-sdk

There are three main ParseObjects
- ParseFile (images, etc.)
- ParseObject (generic text tables)
- ParseUser (user authentication)

**Setup Parse Package** 
- [Installing Parse SDK](https://www.back4app.com/docs/android/parse-android-sdk)
- Update gradle.build (Modules)
- Make sure target SDK >= 27, and then run gradle.sync
- SSH into Parse server and go to `stack/parse-dashboard/config.json` to find credentials
  - app ID
  - app key
  - server URI

Adding dependencies to `gradle.build` (Modules)
```xml
dependencies {
    ...

    implementation "com.github.parse-community.Parse-SDK-Android:parse:latest.version.number"
}

repositories {
    mavenCentral()
    jcenter()
    maven { url 'https://jitpack.io' }
}
```

**Enable Parser**
```java
// set up Parser database
Parse.initialize(new Parse.Configuration.Builder(this)
        .applicationId(getString(R.string.app_id))
        .clientKey(getString(R.string.client_key))
        .server(getString(R.string.server_url))
        .build()
);
```

**Create DB**
```java
// access database
ParseObject score = new ParseObject("Score");
score.put("username", "b");
score.put("score", 101);
score.saveInBackground(new SaveCallback() {
    @Override
    public void done(ParseException e) {
        if (e == null) {
            // OK
            Log.i("Success", "We saved the score");
        } else {
            e.printStackTrace();
        }
    }
});
```

**Query DB**
```java
// can set multiple query initial conditions
// query.whereEqualTo(<field>, x)
// query.whereNotEqualTo(<field>, x)
// query.orderByAscending(<field)>)
// query.setLimit(20);
ParseQuery<ParseObject> query = ParseQuery.getQuery("Score");


query.getInBackground("K9Js2FKYGh", new GetCallback<ParseObject>() {
    @Override
    public void done(ParseObject object, ParseException e) {
        if (e == null && object != null) {
            String usn = object.getString("username");
            int scr = object.getInt("score");
            Log.i("username", usn);
            Log.i("score", Integer.toString(scr));

            // update information
            object.put("anotherfield", 120398);
            object.saveInBackground();

        }
    }
});
ParseQuery<ParseObject> parseQuery = ParseQuery.getQuery("DB");
```

**User DB**
```java
// user specific database 
ParseUser.enableAutomaticUser();
ParseUser user = new ParseUser();

// query
ParseQuery<ParseUser> query = ParseUser.getQuery();
query.whereEqualTo("username", user);
query.findInBackground(new FindCallback<ParseUser>() {
  public void done(List<ParseUser> objects, ParseException e) {
    if (e == null) {
        // The query was successful.
    } else {
        // The query failed
        Log.i("error", e.getMessage());
        e.printStackTrace();
    }
  }
});
```

**Get Current User**
```java
ParseUser user = ParseUser.getCurrentUser();
if (user != null) {
    // do something, or skip login
} else {
    // go to login
}
```

**Logging in**
```java
ParseUser.logInInBackground(username, password, new LogInCallback() {
    @Override
    public void done(ParseUser user, ParseException e) {
        if (e == null) {
            Toast.makeText(getApplicationContext(), "Signed up successfully, " + username, Toast.LENGTH_SHORT).show();
            goToNextActivity(username);
        } else {
            Toast.makeText(getApplicationContext(), "Failed to login", Toast.LENGTH_SHORT).show();
            e.printStackTrace();
        }
    }
});
```

**Signing up**
```java
ParseQuery<ParseUser> query = ParseUser.getQuery();

// search through each row in parse object
query.whereEqualTo("username", username);

Log.i("debug", password);

// now search, if any
query.findInBackground(new FindCallback<ParseUser>() {
    @Override
    public void done(List<ParseUser> objects, ParseException e) {
        if (e == null) {
            // no records found, unique, allow to sign up
            if (objects.size() == 0) {
                user.setUsername(username);
                user.setPassword(password);
                user.signUpInBackground(new SignUpCallback() {
                    @Override
                    public void done(ParseException e) {
                        if (e == null) {
                            Toast.makeText(getApplicationContext(), "You signed up!", Toast.LENGTH_SHORT).show();
                            goToNextActivity(username);
                        } else {
                            e.printStackTrace();
                        }
                    }
                });
            }
            // record found, do not sign up
            else {
                Toast.makeText(getApplicationContext(), "username already exists", Toast.LENGTH_SHORT).show();
            }
        } else {
            e.printStackTrace();
        }
    }
});
```

**Handling Exceptions**
[Exception Codes](https://parseplatform.org/Parse-SDK-Android/api/com/parse/ParseException.html)

As an example
```java
@Override
public void done(ParseUser user, ParseException e) {
    if (e == null) {
        // do something
    } else {
        // list out cases for exceptions
        switch (e.getCode()) {
            case ParseException.USERNAME_TAKEN:
                // do something
                break;
            case ParseException.USERNAME_MISSING:
                // to something
                break;
            case ParseException.PASSWORD_MISSING:
                // do something
                break;
        }
    }
```

**Saving images**
```java
// get bitmap (from stored gallery, most likely)
Bitmap bitmap = MediaStore.Images.Media.getBitmap(this.getContentResolver(), selectedImage);

// store image
// compress image and send to Parser
ByteArrayOutputStream stream = new ByteArrayOutputStream();
bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream);
byte[] byteArray = stream.toByteArray();
ParseFile file = new ParseFile("image.png", byteArray);

// Create a parse object and store values in a new row in DB
ParseObject object = new ParseObject("Image");
object.put("image", file);
object.put("username", ParseUser.getCurrentUser().getUsername());
object.saveInBackground(new SaveCallback() {
    @Override
    public void done(ParseException e) {
        if (e == null) {
            Toast.makeText(getApplicationContext(), "Image was saved", Toast.LENGTH_SHORT).show();
        } else {
            e.printStackTrace();
        }
    }
});
```

<!-- -------- -->
<!-- Firebase -->
<!-- -------- -->
### Firebase

**Setting up** <br>
[Documentation](https://firebase.google.com/docs/android/setup)
- Go to android project view
- Download and add `google-services.json`


Gradle files `build.gradle (app)`
```xml
dependencies {
    ...

    // firebase standard
    implementation 'com.google.firebase:firebase-analytics:17.2.2'

    // authentication
    implementation 'com.google.firebase:firebase-auth:19.3.0'

    // storage
    implementation 'com.google.firebase:firebase-storage:19.1.1'

    // database
    implementation 'com.google.firebase:firebase-database:19.2.1'

}
```


**Authentication** <br>
[Documentation](https://firebase.google.com/docs/auth)

```java
// initialize
private FirebaseAuth mAuth;
mAuth = FirebaseAuth.getInstance();

// check to see if there exist an already login'd user
if (mAuth.getCurrentUser() != null) {
    logIn();
}
```

Login
```java
// check if we can log in the user
mAuth.signInWithEmailAndPassword(email, password)
        .addOnCompleteListener(this, new OnCompleteListener<AuthResult>() {
            @Override
            public void onComplete(@NonNull Task<AuthResult> task) {
                // login
                if (task.isSuccessful()) {
                    // do something
                } else {
                    Log.i("SigningUp", "Failed to sign in existing user");
                }
            }
        });
```

Signup
```java
// setup database (if needed)
FirebaseDatabase database = FirebaseDatabase.getInstance();

// create new user if not login'ed
mAuth.createUserWithEmailAndPassword(email, password)
        .addOnCompleteListener(this, new OnCompleteListener<AuthResult>() {
            @Override
            public void onComplete(@NonNull Task<AuthResult> task) {
                if (task.isSuccessful()) {
                    // do something

                    // such as loading into a database
                    database.getReference("users")
                            .child(task.getResult().getUser().getUid())
                            .child("email")
                                .setValue(task.getResult().getUser().getEmail());
                    return;
                } else {
                    Log.i("CreatingUser", "Failed to create new user");
                }
            }
        });
```

**Storage**

Saving assets
```java
FirebaseStorage storage = FirebaseStorage.getInstance();
StorageReference storageReference = storage.getReference(); // store in root directory
StorageReference store = storageReference.child("folder").child("file.text");
UploadTask uploadTask = store.putBytes(data);
```

Set callback on upload completion
```java
// upload callbacks
uploadTask.addOnFailureListener(new OnFailureListener() {
    @Override
    public void onFailure(@NonNull Exception e) {
        Toast.makeText(getApplicationContext(), "Upload failed", Toast.LENGTH_SHORT).show();
    }
}).addOnSuccessListener(new OnSuccessListener<UploadTask.TaskSnapshot>() {
    @Override
    public void onSuccess(UploadTask.TaskSnapshot taskSnapshot) {
        Toast.makeText(getApplicationContext(), "Upload succeeded", Toast.LENGTH_SHORT).show();

        // log URL of storage location
        String url = taskSnapshot.getUploadSessionUri().toString();
        Log.i("URL", url);
    }
});
```

Delete storage file
```java
FirebaseStorage.getInstance().getReference().child("folder").child("file.text").delete();
```

**Database** (realtime) 

Store values
```java
FirebaseDatabase database = FirebaseDatabase.getInstance();
database.getReference("users")
        .child("first child")
        .child("secocnd child")
        .setValue("contents");
```

Set callback on database change
```java
// create database listener
database.getReference("users").addChildEventListener(new ChildEventListener() {
    @Override
    public void onChildAdded(@NonNull DataSnapshot dataSnapshot, @Nullable String s) {}
   
    @Override
    public void onChildChanged(@NonNull DataSnapshot dataSnapshot, @Nullable String s) {}
   
    @Override
    public void onChildRemoved(@NonNull DataSnapshot dataSnapshot) {}
   
    @Override
    public void onChildMoved(@NonNull DataSnapshot dataSnapshot, @Nullable String s) {}
   
    @Override
    public void onCancelled(@NonNull DatabaseError databaseError) {}});
```

Deleting data
```java
FirebaseDatabase.getInstance().getReference("users").child("first child").removeValue();
```

<!-- --- -->
<!-- AWS -->
<!-- --- -->
### AWS

Cognito

<!-- -------------------------------------------------------- -->
<!-- BACKEND -->
<!-- -------------------------------------------------------- -->
## Backend

### Routines

```java
Handler mainHandler = new Handler(context.getMainLooper());
```

```java
mainHandler.post(new Runnable() {

    @Override
    public void run() {
        // run code
    }
});
```

Check which thread you are on
```java
Log.i("TAG", Thread.currentThread().getName());
```

<!-- ------ -->
<!-- Alerts -->
<!-- ------ -->
### Arrays & Lists

**Getter/Setters**
```java
ArrayList.get(int position);
ArrayList.set(int position, item);
```

**Checking for duplicates**
```java
ArrayList<>.contains(<>)
```

**Looping**
```java
for (<Obj> obj : ArrayList<>) {}
```

<!-- ---- -->
<!-- JSON -->
<!-- ---- -->
### JSON

<!-- ------ -->
<!-- Alerts -->
<!-- ------ -->
### Runners

Use a handler to call a runnable every X milliseconds. This will call only once.

```java
handler.postDelayed(new Runnable() {
    @Override
    public void run() {
        // Toast.makeText(getApplicationContext(), "HELLO", Toast.LENGTH_SHORT).show();
        Log.i("RUN", "HELLO");
    }
}, 1000);
```

This will loop the delay, at a specified interval in the runnerable class.

```java
private Runnable runnableCode = new Runnable() {
    @Override
    public void run() {
      // Do something here on the main thread
      Log.d("Handlers", "Called on main thread");
      // Repeat this the same runnable code block again another 2 seconds
      // 'this' is referencing the Runnable object
      handler.postDelayed(this, 2000);
    }
};
// Start the initial runnable task by posting through the handler
handler.post(runnableCode);
```

And then stop the delay by removing the callback

```java
handler.removeCallbacks(runnableCode);
```

<!-- ------ -->
<!-- Alerts -->
<!-- ------ -->
### Async Tasks
```java
private class AsyncTaskRunner extends AsyncTask<String, String, String> {

        private String resp;
        ProgressDialog progressDialog;

        @Override
        protected String doInBackground(String... params) {
            publishProgress("Sleeping..."); // Calls onProgressUpdate()
            try {
                int time = Integer.parseInt(params[0])*1000;

                Thread.sleep(time);
                resp = "Slept for " + params[0] + " seconds";
            } catch (InterruptedException e) {
                e.printStackTrace();
                resp = e.getMessage();
            } catch (Exception e) {
                e.printStackTrace();
                resp = e.getMessage();
            }
            return resp;
        }


        @Override
        protected void onPostExecute(String result) {
            // execution of result of Long time consuming operation
            progressDialog.dismiss();
            finalResult.setText(result);
        }


        @Override
        protected void onPreExecute() {
            progressDialog = ProgressDialog.show(MainActivity.this,
                    "ProgressDialog",
                    "Wait for "+time.getText().toString()+ " seconds");
        }


        @Override
        protected void onProgressUpdate(String... text) {
            finalResult.setText(text[0]);
            
        }
    }
```

<!-- ------ -->
<!-- Alerts -->
<!-- ------ -->
### Timers
```java
// example of using a timer to set the progress on a seekbar
new Timer().scheduleAtFixedRate(new TimerTask() {
    @Override
    public void run() {
        scrubControl.setProgress(mediaPlayer.getCurrentPosition());
    }
}, 0, 300);
```

<!-- ------ -->
<!-- Alerts -->
<!-- ------ -->
### String Matching

<!-- ------------------- -->
<!-- Downloading content -->
<!-- ------------------- -->
### Downloading Content :white_check_mark:

**Downloading HTML**

Create async task to handle download
```java
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
```

Create task and download HTML
```java
DownloadURL downloadURL = new DownloadURL();
try {
    String html = downloadURL.execute(url).get();
    Log.i("HTML", html);
} catch (Exception e) {
    e.printStackTrace();
}
```

**Downloading image**

Like downloading HTMLs, create an async task
```java
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
```

Execute task
```java
DownloadImage downloadImage = new DownloadImage();
try {
    Bitmap bitmap = downloadImage.execute(img).get();
    imageView.setImageBitmap(bitmap);
} catch (Exception e) {
    e.printStackTrace();
}
```

<!-- -------------------------------------------------------- -->
<!-- FRONT END -->
<!-- -------------------------------------------------------- -->
## Front end

<!-- ------------- -->
<!-- Interactivity -->
<!-- ------------- -->
### Interactivity

**Activity click listener**
```java
public class MyActivity extends Activity implements View.OnClickListener {
    // class code
    // ... 

    // set click listeners to this
    view.setOnClickListener(this);

    // override onClick function for class
    // use switch/case statements to capture what is being clicked
    @Override
    public void onClick(View view) {
        switch(view.getId){
            case R.id.buttonX: 
            // Do something
    }
}
```



<!-- -------- -->
<!-- Listview -->
<!-- -------- -->
### ListView

**Basic List**
```java
// create an array type object
ArrayList<Object> arrayList = new ArrayList<>();

// create adaptor
arrayAdapter = new ArrayAdapter(this, android.R.layout.simple_expandable_list_item_1, arrayList);
listView.setAdapter(arrayAdapter);
```

**Simple List**
```java
// set up list of hashsets
List<Map<String,String>> data = new ArrayList<>();

// generating fake data
for (int i=0; i<5; i++) {
    Map<String,String> info = new HashMap<>();
    info.put("key1", "value1");
    info.put("key2", "value2");

    // add the key value pairs to the List
    data.add(info);
}

// create array adaptor
// note: android.R.layout.simple_list_item_2 has only two text positions, text1 and text2,
// even if the Map object has more than 2 keys 
SimpleAdapter simpleAdapter = new SimpleAdapter(getApplicationContext(), 
    data, 
    android.R.layout.simple_list_item_2, 
    new String[] {"key1", "key2"}, // <- important, these are the keys in your hashmap
    new int[] {android.R.id.text1, android.R.id.text2});
listView.setAdapter(simpleAdapter);
```

**Checked list**
```java
listView.setChoiceMode(AbsListView.CHOICE_MODE_MULTIPLE);
arrayAdapter = new ArrayAdapter(this, android.R.layout.simple_list_item_checked, arrayList);

// class of items in listView are CheckedTextView
listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        // caste to CheckTextView
        CheckedTextView checkedTextView = (CheckedTextView) view;
        if (checkedTextView.isChecked()) {
            Toast.makeText(getApplicationContext(), "CHECKED " + checkedTextView.getText().toString(), Toast.LENGTH_SHORT).show();
        } else {
            Toast.makeText(getApplicationContext(), "UNCHECKED " + checkedTextView.getText().toString(), Toast.LENGTH_SHORT).show();
        }
    }
});
```

**ListView Listeners**
```java
listView.setOnItemClickListener(new OnItemClickListener(){   
    @Override
    public void onItemClick(AdapterView<?> adapter, View v, int position){
        // do something based on the view and position
        // of the returning callback
    }
});
```

**Notify and Update Changes**
```java
// notify arrayAdapter change, from changes in arrayList
arrayList.add(<item>);
arrayList.remove(i);
arrayAdapter.notifyDataSetChanged();
```

### RecyclerViews

More advanced ListViews

Google documentation: https://developer.android.com/guide/topics/ui/layout/recyclerview

### Custom Adaptors
https://medium.com/mindorks/custom-array-adapters-made-easy-b6c4930560dd

XML
- Create a new `Resource Layout File`
- Populate the resource fill with the XML, each element with a unique ID to reference
- Give this resource layout file an ID name, this will be referenced in the adaptor

Adaptor
- Create a normal java file that references the XML file.
- VERY IMPORTANT: the override `getView` function must either convert or create a `converView` which passes
  to the function, and inflate the custom XML file, which will be referened through R.layout.<name>
- return this inflated view
- (OPTIONAL) create a model method which handles the getter/setters that is given to the adaptor
  and held within the arrays

```java
// extend the ArrayAdapter Class
public class ItemAdaptor extends ArrayAdapter<Items> {
    private Context mContext;
    private List<Items> itemList;

    // standard constructor
    public ItemAdaptor(@NonNull Context context, ArrayList<Items> list) {
        super(context, 0, list);
        mContext = context;
        itemList = list;
        Log.i("ADAPTOR", list.toString());
    }

    // manage how the item should be populated
    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        // get current element
        Items currentItem = itemList.get(position);

        // expand View
        View listItem = convertView;
        if (listItem == null) {
            listItem = LayoutInflater.from(mContext).inflate(R.layout.item_list, parent, false);
        }

        // // update elements
        TextView textView = listItem.findViewById(R.id.buttonItem);
        Button button = listItem.findViewById(R.id.buttonItem);

        // update
        textView.setText(currentItem.text);
        button.setText(currentItem.button);

        return listItem;
    }
}
```

ListView
- Setup the listview as normal

<!-- ------- -->
<!-- Layouts -->
<!-- ------- -->
### Layouts

**Linear Layout**
```java
LinearLayout linLayout = findViewById(R.id.linLayout);

// for example, adding an image
ImageView imageView = new ImageView(getApplicationContext());

imaveView.setLayoutParams(new ViewGroup.LayoutParams(
    ViewGroup.LayoutParams.MATCH_PARENT,
    ViewGroup.LayoutParams.WRAP_CONTENT
))

imageView.setImageDrawable(getResources().getDrawable(R.drawable.instagram));

lineLayout.addView(imageView);

```

**Gridlayout**

<!-- ------- -->
<!-- Fragments -->
<!-- ------- -->
### Fragments

Very useful tutorial: https://www.youtube.com/watch?v=i22INe14JUc
Another tutorial on fragments: https://www.youtube.com/watch?v=-vAI7RSPxOA

Note
- On the fragment xml resource file, make sure the height (and/or width) is set to wrap content, so it doesn't take an entire screen to manage the elements
- onCreate -> onCreateView
- need to inflate view using inflater
- this = getActivity(), because it will be called by the main activity holding the fragment
- Need to implement and interface which will be extended by the activity that uses the fragment
- Need to also create onAttach()

Create a new fragment by `ctrl+N` new Fragment, beneath the option for choosing a new Activity.

In the fragment code
```java
public interface FragmentListener {
    void onInputSent();
}
```

The full fragment code, which includes the interface which the activity will use

```java
public class FragmentX extends Fragment {
    // initialize listener
    private FragmentListener listener;
    
    // initialize elements
    View widget;

    // create interface
    public interface FragmentListener {
        void onInputSent();
    }

    // note that there is onCreate -> onCreateView
    @Nullable
    @Override
    public View onCreateView(LayoutInflator inflator, @Nullable Viewgroup container, @Nullable Bundle savedInstanceState) {
        // inflate layout
        View view = inflater.inflate(R.layout.<fragment_name>, container, false);

        // all instances to widgets need the view
        widget = view.findViewById(<R.id>);

        // fragment context
        // this = getActivity() 

        return view
    }

    @Override
    public void onVoidCreated(...) {
        // all views have been created, they are now accessible
    }
}
```

Need to attach fragment to the activity

```java
@Override
public void onAttach(Context context) {
    super.onAttach(context);
    if (context instanceof FragmentListener) {
        lister = (FragmentListener) context;
    } else {
        throw new RuntimeException(context.toString());
    }
}

@Override
public void onDetach() {
    super.onDetach();
    listener = null;
}
```

On the main activity hosting the fragment

```java
{
    // create intsance of the fragments
    FragmentX fragmentX = new FragmentX();
    ...

    // add in the fragment to the container in the activity
    getSupportFragmentManager().beginTransaction()
        .replace(R.id.container_x, fragmentX)
        .commit();
}
```


// ```java
// {
//     viewPager = findViewById(R.id.container);
//     setupViewPager(viewPager);

//     // set pager section
//     viewPager.setCurrentItem(2);
// }   

// private void setupViewPager(ViewPager viewPager) {
//     SectionsStatePageAdapter adapter = new ...
// }

// ```

<!-- ------ -->
<!-- Videos -->
<!-- ------ -->
### Videos :white_check_mark:

Create a `raw` subdirectory in the `res` folder and copy-past the resource file. <br>
_Warning_: file names must be all lower case with no special punctation, `_` are allowed.


```java
// creating video and manager
VideoView videoView = (VideoView) findViewById(R.id.videoView);

// media controller provides UI handles to scroll and adjust the 
// video playback
MediaController mediaController = new MediaController(this);

// create raw folder in res and add in video
String path = "android.resource://" + getPackageName() + "/" +  R.raw.nameOfVideo;

// parse and set video to VideoView
Uri uri = Uri.parse(path);
videoView.setVideoURI(uri);

// anchor media and video controller together
mediaController.setAnchorView(vid);
videoView.setMediaController(m);
videoView.start();
```

<!-- ----- -->
<!-- Sound -->
<!-- ----- -->
### Sound :white_check_mark: 

Create a `raw` subdirectory in the `res` folder and copy-past the resource file. <br>
_Warning_: file names must be all lower case with no special punctation, `_` are allowed.

```java
// create media player
MediaPlayer mediaPlayer = MediaPlayer.create(this, R.raw.nameOfMedia);

// play media
mediaPlayer.start();
```

```java
// create seekbar to control volume or duration
final AudioManager audioManager = (AudioManager) getSystemService(AUDIO_SERVICE);
int maxVolume = audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC);
int duration = audioManager.getDuration(); // units in msec
int currentVolume = audioManager.getStreamVolume(AudioManager.STREAM_MUSIC);

seekBarVolume.setMax(maxVolume);
seekBarVolume.setProgress(currentVolume);
seekBarVolume.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
    @Override
    public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
        audioManager.setStreamVolume(AudioManager.STREAM_MUSIC, progress, 0);
    }

    @Override
    public void onStartTrackingTouch(SeekBar seekBar) {
        mediaPlayer.pause();
    }

    @Override
    public void onStopTrackingTouch(SeekBar seekBar) {
        mediaPlayer.start()
    }
});
```

Release resource when audio is done
```java
// release any resources if media is done playing
mediaPlayer.setOnCompletionListener(new MediaPlayer.OnCompletionListener() {
    public void onCompletion(MediaPlayer mp) {
        mp.release()
    }
});
```

<!-- ------ -->
<!-- Images -->
<!-- ------ --> 
### Images :white_check_mark:
**Converting Images to Bitmap**

```java
// retrieve bitmap from imageView
BitmapDrawable bitmapDrawable = (BitmapDrawable) imageView.getDrawable();
Bitmap bitmap = bitmapDrawable.getBitmap();

// convert bitmap to jpg
ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
bitmap.compress(Bitmap.CompressFormat.JPEG, 100, byteArrayOutputStream);
byte[] data = byteArrayOutputStream.toByteArray();
```

**Retreiving saved images**

Ask for permission in Manifest, and set up code to request for permission in Activity
```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
```

Create intent
```java
// initialize the intent
Intent intent = new Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
startActivityForResult(intent, 1);
```

Receive Intent
```java
// return results
@Override
protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
    super.onActivityResult(requestCode, resultCode, data);

    if (requestCode == 1 && resultCode == RESULT_OK && data != null) {
        try {
            Bitmap bitmap = MediaStore.Images.Media.getBitmap(this.getContentResolver(), selectedImage);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```

<!-- ------- -->
<!-- Key pad -->
<!-- ------- -->
### Keypad :white_check_mark:

**Useful links**
- https://stackoverflow.com/questions/4165414/how-to-hide-soft-keyboard-on-android-after-clicking-outside-edittext


**Hiding keypad when not clicked**

Add this to the activity xml (not the elements). <br>
```xml
android:clickable="true" 
android:focusableInTouchMode="true" 
```

Implement hideKeyboard()
```java
public void hideKeyboard(View view) {
    InputMethodManager inputMethodManager =(InputMethodManager)getSystemService(Activity.INPUT_METHOD_SERVICE);
    inputMethodManager.hideSoftInputFromWindow(view.getWindowToken(), 0);
}
```

When active element is not in focus, hide the keypad. The opposite can be true if the activity is in focus (clicking off screen), and then hiding the keypad.
```java
editText.setOnFocusChangeListener(new View.OnFocusChangeListener() {
    @Override
    public void onFocusChange(View v, boolean hasFocus) {
        if (!hasFocus) {
            hideKeyboard(v);
        }
    }
});
```

**Submitting input on enter**
```java
@Override
public boolean onKey(View v, int keyCode, KeyEvent event) {
    if (keyCode == KeyEvent.KEYCODE_ENTER && event.getAction() == KeyEvent.ACTION_DOWN) {
        // action
        // hide keypad
    }
    return false;
}
```

<!-- ---- -->
<!-- Menu -->
<!-- ---- -->
### Menu :white_check_mark:

Links:
- [Documentation](https://developer.android.com/guide/topics/ui/menus)
 
1. Add a menu directory in the `res` folder
2. Highlight the new `menu` folder in `res`
3. On the `File` menu, add a `New > Menu Resource File`
4. Name the menu file, and this will add the xml in the new folder under menu. 

Add names and ids to menu options 
```xml
<?xml version="1.0" encoding="utf-8"?>
<menu xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:title="Settings" android:id="@+id/settings"></item>
    <item android:title="Help" android:id="@+id/help"></item>
</menu>
```

Inflate menu option onto activity, and set on item click listeners
```java
@Override
public boolean onCreateOptionsMenu(Menu menu) {
    MenuInflater menuInflater = getMenuInflater();
    menuInflater.inflate(R.menu.main_menu, menu);
    return super.onCreateOptionsMenu(menu);
}

// check which menu option is clicked by its id
@Override
public boolean onOptionsItemSelected(MenuItem item) {
    super.onOptionsItemSelected(item);

    switch (item.getItemId()) {
        case R.id.item1:
            // do something
            break;
        case R.id.item1:
            // do something
            break;
        default:
            break;
    }
}
```

Long click listeners are enabled individually by getting the menu elements themselves
```java
@Override
public boolean onCreateOptionsMenu(Menu menu) {
    MenuInflater menuInflater = getMenuInflater();
    menuInflater.inflate(R.menu.main_menu, menu);

    // get selected elements
    MenuItem item = menu.findItem(R.id.item1);
    item.getActionView.setOnLongClickListener(new View.OnLongClickListener() {
        @Override
        public boolean onLongClick(View view) {
            // do something
            return true
        }
    })
    return super.onCreateOptionsMenu(menu);
}
```


<!-- ------- -->
<!-- WebView -->
<!-- ------- -->
### WebView

```java
// access webview from xml
WebView webView = (WebView) findViewById(R.id.webView);

// enable javascript
webView.getSettings().setJavaScriptEnabled(true);

// load URL in webview, not another browser
webView.setWebViewClient(new WebViewClient());
webView.loadUrl("http://www.google.com");

// load raw URL
webView.loadData("<HTML TEXT>", "text/html", "UTF-8");
```

<!-- ------ -->
<!-- Alerts -->
<!-- ------ -->
### Alerts
```java
new AlertDialog.Builder(this)
    .setIcon(android.R.drawable.ic_dialog_alert)
    .setTitle("Are you sure?")
    .setMessage("THIS IS A MESSAGE")
    .setPositiveButton("Yes", new DialogInterface.OnClickListener() {
        @Override
        public void onClick(DialogInterface dialog, int which) {
            Toast.makeText(MainActivity.this, "It's done", Toast.LENGTH_SHORT).show();
            dialog.cancel();
        }
    })
    .setNegativeButton("No", new DialogInterface.OnClickListener() {
        @Override
        public void onClick(DialogInterface dialog, int which) {
            Toast.makeText(MainActivity.this, "Not done", Toast.LENGTH_SHORT).show();
            dialog.cancel();
        }
    })
    .show();
```

### Action Bar

Use `getSupportActionBar()` to get current instance of action bar

For a full screen app.

```java
onCreate() {
    getSupportActionBar().hide();
}
```

### Extra UX

**Images and Icons**
in mipmap > ic_launcher.xml change which background and images it points to

```xml
android:roundIcon="@mipmap/ic_launcher"
```

Then in the android manifest, point to this ic_launcher 

**Fonts**

New > Android Resource Directory
- Directory name = font
- Resource type = font
- Add file .tff or others
- Synchronize fonts by right clicking

More > Add fonts, by downloading its xml file

The fonts are accessible @fonts/<name> or R.fonts.<name>

Note that names must be lowercase with underscore, since these can be declared as variables

**Autocomplete**

Insert an AutoCompleteView

set an ArrayAdapter to the autocomplete text view
```java
ArrayAdapter<String> arrayAdapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, friends);
autoCompleteTextView.setAdapter(arrayAdapter);

// set number of letters before suggestion
autoCompleteTextView.setThreshold(2);
```

**Autofill**

Go to the edit text XML and edit, useful for credentials or password manager
```xml
android:autofillHints="AUTOFILL_HINT_USERNAME"
android:autofillHints="AUTOFILL_HINT_PASSWORD"
android:autofillHints="AUTOFILL_HINT_EMAIL"
```

**Picture in a picture**

Enable in manifest
```xml
<activity android:name=".MainActivity"
            android:resizeableActivity="true"
            android:supportsPictureInPicture="true"
            android:configChanges="screenSize|smallestScreenSize|screenLayout|orientation">
```

Execute in thread
```java
// enable
enterPictureInPictureMode();

// change contents when transitioning
// remove activity bar on the top
@Override
public void onPictureInPictureModeChanged(boolean isInPictureInPictureMode, Configuration newConfig) {
    super.onPictureInPictureModeChanged(isInPictureInPictureMode, newConfig);

    if (isInPictureInPictureMode) {
        // going into PIP
        getSupportActionBar().hide();
    } else {
        // going out of PIP
        getSupportActionBar().show();
    }
}
```

## Organizing Code

### Organizing Packages

Organizing code: https://dev.to/miguelrodoma95/tips-to-keep-your-android-app-project-organized-361n

Coding guidelines: https://github.com/ribot/android-guidelines/blob/master/project_and_code_guidelines.md <br>

Structuring: https://github.com/ribot/android-guidelines/blob/master/architecture_guidelines/android_architecture.md 

- Create packages
  - activities - the activities that manage the views
  - models - holds data, or data that goes into creating adaptors
  - adaptors - custom adaptor code on how to visualize the ListViews

### Organizing Res XML files

View files in different subfolders: https://medium.com/mindorks/how-to-put-android-layout-files-in-subfolders-1f7cf07ff48f

Should look like
- res
  - layouts
    - activities
      - **layout** (<- must be named like this!>) 
        - file1.xml
        - file2.xml
        - file3.xml
    - adaptors
      - **layout** (<- must be named like this!>) 
        - file1.xml
        - file2.xml

To link this new structure to the code, modify the gradle.app (user side, not package side), which is within
the android {} braces. 

```xml
android {
    compileSdkVersion 28
    buildToolsVersion "29.0.3"

    ...

    // linking view xml files
    sourceSets {
        main {
            res.srcDirs = [
                    file("src/main/res/layouts/").listFiles(),
                    "src/main/res/layouts",
                    "src/main/res"
            ]
        }
    }
}
```

### 3rd Party Packages

**Plotting**
https://stackoverflow.com/questions/9741300/charts-for-android
https://github.com/PhilJay/MPAndroidChart

## Android Studio

### Hotkeys
- `ctrl + I` = auto fill required methods
- `ctrl + space` = see what arguments are needed
- `ctrl + p` = get information about variable

### Renaming Project
1. Close Android Studio
2. Change project root directory name
3. Open Android Studio
4. Open the project (not from local history but by browsing to it)
5. Clean project

Found here: https://stackoverflow.com/questions/18276872/change-project-name-on-android-studio

Open source android projects: https://github.com/pcqpcq/open-source-android-apps 

### Gradle

If you exceed 64K references and calls in an app

```xml
defaultConfig {
    multiDexEnabled true
}

...

dependencies {
    ...
    compile: 'com.android.support:multidex:1.0.1'
}
