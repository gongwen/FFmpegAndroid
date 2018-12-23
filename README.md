# FFmpegAndroid
一个Android环境下FFmpeg命令库


参考自：
[FFmpeg官方文档](https://ffmpeg.org/ffmpeg.html)
[FFmpeg-github](https://github.com/FFmpeg/FFmpeg)
[FFmpeg编译指南](https://trac.ffmpeg.org/wiki/CompilationGuide)
[FFmpeg configure](https://github.com/FFmpeg/FFmpeg/blob/master/configure)
[Android 集成 FFmpeg (一) 基础知识及简单调用](https://blog.csdn.net/yhaolpz/article/details/76408829)
[Android 集成 FFmpeg (二) 以命令方式调用 FFmpeg](https://blog.csdn.net/yhaolpz/article/details/77146156)
[使用Android Studio开发FFmpeg的正确姿势](https://www.jianshu.com/p/0a7f3175c1b9)
[Mac下为Android编译FFMPEG和x264 （一）](http://zheteng.me/android/2016/05/25/build-ffmpeg-for-android-with-x264/)
[https://trac.ffmpeg.org/wiki/Encode/H.264](https://trac.ffmpeg.org/wiki/Encode/H.264)
[https://github.com/guardianproject/android-ffmpeg](https://github.com/guardianproject/android-ffmpeg)
[为Android编译FFmpeg](https://www.jianshu.com/p/9f1e5d711f97)
[ffmpeg-x264](https://sites.google.com/site/linuxencoding/x264-ffmpeg-mapping)
[编译x264](https://www.jianshu.com/p/f3b2813dfa7a)
1.将ffmpeg源码拷贝进项目
2.教程：https://blog.csdn.net/yhaolpz/article/details/77146156
3.ffmpeg.h加入：int main(int argc, char **argv);
4.添加ffmpeg_hw.c