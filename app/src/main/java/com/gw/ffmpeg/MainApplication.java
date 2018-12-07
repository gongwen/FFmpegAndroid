package com.gw.ffmpeg;

import android.app.Application;

/**
 * @author Created by GongWen.
 * @date on 2018/12/9.
 */
public class MainApplication extends Application {
    private static MainApplication sInstance;

    @Override
    public void onCreate() {
        super.onCreate();
        sInstance = this;
    }

    public static MainApplication get() {
        return sInstance;
    }
}
