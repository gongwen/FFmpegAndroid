package com.gw.ffmpeg;

import android.Manifest;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AppCompatActivity;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.gw.ffmpegcommand.FFmpegExecuter;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {
    private static final String TAG = "MainActivity";
    private static final int permissionRequestCode = 0x10;

    private EditText editView;
    private Button executeCommandBtnView;
    private TextView contentView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        editView = findViewById(R.id.editView);
        executeCommandBtnView = findViewById(R.id.executeCommandBtnView);
        contentView = findViewById(R.id.contentView);
        findViewById(R.id.protocolBtn).setOnClickListener(this);
        findViewById(R.id.codecBtn).setOnClickListener(this);
        findViewById(R.id.formatBtn).setOnClickListener(this);
        findViewById(R.id.filterBtn).setOnClickListener(this);

        executeCommandBtnView.setOnClickListener(this);
        contentView.setText(FFmpegExecuter.getInstance().getUrlProtocolInfo());
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.executeCommandBtnView:
                if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_EXTERNAL_STORAGE) == PackageManager.PERMISSION_GRANTED
                        && ContextCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE) == PackageManager.PERMISSION_GRANTED) {
                    executeFFmpegCommand(editView.getText());
                } else {
                    ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.READ_EXTERNAL_STORAGE, Manifest.permission.WRITE_EXTERNAL_STORAGE}, permissionRequestCode);
                }
                break;
            case R.id.protocolBtn:
                contentView.setText(FFmpegExecuter.getInstance().getUrlProtocolInfo());
                break;
            case R.id.codecBtn:
                contentView.setText(FFmpegExecuter.getInstance().getAvCodecInfo());
                break;
            case R.id.formatBtn:
                contentView.setText(FFmpegExecuter.getInstance().getAvFormatInfo());
                break;
            case R.id.filterBtn:
                contentView.setText(FFmpegExecuter.getInstance().getAvFilterInfo());
                break;
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == permissionRequestCode) {
            if (grantResults[0] == PackageManager.PERMISSION_GRANTED && grantResults[1] == PackageManager.PERMISSION_GRANTED) {
                executeFFmpegCommand(editView.getText());
            } else {
                Toast.makeText(MainActivity.this, "PermissionGroup storage got failed.", Toast.LENGTH_SHORT).show();
            }
        }
    }

    private void executeFFmpegCommand(CharSequence command) {
        if (TextUtils.isEmpty(command)) {
            Toast.makeText(MainActivity.this, "The ffmpeg command must be not null.", Toast.LENGTH_SHORT).show();
        } else {
            new Thread(() -> {
                long cur = System.currentTimeMillis();
                final int result = FFmpegExecuter.getInstance().run(command.toString().split(" "));
                Log.e(TAG, String.format("Costs %d ms for %s.", System.currentTimeMillis() - cur, command.toString()));
                runOnUiThread(() -> Toast.makeText(MainActivity.this, result == 0 ? "Success" : "Fail", Toast.LENGTH_SHORT).show());
            }).start();
        }
    }
}
