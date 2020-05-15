package com.example.practiceappmedia2;

import androidx.appcompat.app.AppCompatActivity;

import android.media.AudioManager;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.MediaController;
import android.widget.SeekBar;
import android.widget.VideoView;

public class MainActivity extends AppCompatActivity {

    VideoView videoView;
    MediaPlayer mediaPlayer;
    Button button;
    SeekBar seekBarVolume;
    SeekBar seekBarPlayer;
    Boolean toggle = true;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // get elements
        videoView = findViewById(R.id.videoView);
        button = findViewById(R.id.buttonPlay);
        seekBarVolume = findViewById(R.id.seekBarVolume);
        seekBarPlayer= findViewById(R.id.seekBarPlayer);

        // create media controller
        MediaController mediaController = new MediaController(this);

        // path to video resource
        String pathToVideo = "android.resource://" + getPackageName() + "/" + R.raw.sample_video;

        // get URI to video
        Uri uri = Uri.parse(pathToVideo);
        videoView.setVideoURI(uri);

        // anchor video and media player
        mediaController.setAnchorView(videoView); // provides control to video when hovered
        videoView.setMediaController(mediaController);

        // start audio
        mediaPlayer = MediaPlayer.create(this, R.raw.sample_music);

        // set callbacks for volume control
        final AudioManager audioManager = (AudioManager) getSystemService(AUDIO_SERVICE);
        int maxVolume = audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC);
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
                // togglePause();
            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {
                // toggleOn();
            }
        });

        // set callback for media player
        int timeSpan = mediaPlayer.getDuration();
        seekBarPlayer.setMax(timeSpan);
        seekBarPlayer.setProgress(0);
        seekBarPlayer.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                mediaPlayer.seekTo(progress);
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {
                // togglePause();
            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {
                // toggleOn();
            }
        });
    }

    public void onClick(View view) {
        // play video
        if (toggle) {
            button.setText("Pause");
            toggleOn();
            toggle = false;
        } else {
            button.setText("Play");
            togglePause();
            toggle = true;
        }
    }

    public void toggleOn() {
        videoView.start();
        mediaPlayer.start();
    }

    public void togglePause() {
        videoView.pause();
        mediaPlayer.pause();
    }

}
