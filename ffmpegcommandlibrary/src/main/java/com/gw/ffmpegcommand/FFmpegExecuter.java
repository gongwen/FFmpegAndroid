package com.gw.ffmpegcommand;

public class FFmpegExecuter {
    private FFmpegExecuter() {
    }

    private static final class Holder {
        private static final FFmpegExecuter sInstance = new FFmpegExecuter();
    }

    static {
        System.loadLibrary("ffmpeg");
    }

    public static FFmpegExecuter getInstance() {
        return Holder.sInstance;
    }

    public native int run(String[] command);

    public native String getUrlProtocolInfo();

    public native String getAvFormatInfo();

    public native String getAvCodecInfo();

    public native String getAvFilterInfo();
}
