package com.example.practiceapp_media;

import androidx.appcompat.app.AppCompatActivity;

import android.media.AudioManager;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.MediaController;
import android.widget.SeekBar;
import android.widget.Toast;
import android.widget.VideoView;

import java.net.URI;

public class MainActivity extends AppCompatActivity {

    // videos
    MediaController mediaController;
    VideoView videoView;

    // audio
    MediaPlayer mediaPlayer;
    AudioManager audioManager;

    // seek bar for video
    SeekBar scrubBar;

    // variables
    int maxVolume;
    boolean toggle = true;

    public void playMedia(View view) {
        if (toggle) {
            videoView.start();
            mediaPlayer.start();
            toggle = false;
        } else {
            videoView.pause();
            mediaPlayer.pause();
            toggle = true;
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // initialize video
        mediaController = new MediaController(this);
        videoView = (VideoView) findViewById(R.id.videoView);
        String path = "android.resource://" + getPackageName() + "/" + R.raw.video;
        videoView.setVideoURI(Uri.parse(path));
        mediaController.setAnchorView(videoView);
        videoView.setMediaController(mediaController);

        // initialize sound
        mediaPlayer = MediaPlayer.create(this, R.raw.sound);
        audioManager = (AudioManager) getSystemService(AUDIO_SERVICE);
        maxVolume = audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC);

        // create scrubBar
        scrubBar = (SeekBar) findViewById(R.id.scrubBar);
        scrubBar.setMax(10000);
        scrubBar.setProgress(0);
        Toast.makeText(this, Integer.toString(mediaPlayer.getDuration()), Toast.LENGTH_SHORT).show();

        scrubBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                videoView.seekTo(progress);
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {
                videoView.pause();
                mediaPlayer.pause();
            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {
                videoView.start();
                mediaPlayer.start();
            }
        });

    }
}
