#include <jni.h>
#include "ffmpeg.h"

/**
 * 执行FFmpeg命令
 */
JNIEXPORT jint JNICALL
Java_com_gw_ffmpegcommand_FFmpegExecuter_run(
        JNIEnv *env, jobject obj, jobjectArray commands) {
    int argc = (*env)->GetArrayLength(env, commands);
    char *argv[argc];

    int i = 0;
    for (; i < argc; i++) {
        jstring js = (jstring) (*env)->GetObjectArrayElement(env, commands, i);
        argv[i] = (char *) (*env)->GetStringUTFChars(env, js, 0);
    }
    return main(argc, argv);
}

JNIEXPORT jstring JNICALL
Java_com_gw_ffmpegcommand_FFmpegExecuter_getUrlProtocolInfo(JNIEnv *env, jobject obj) {
    char info[40000] = {0};
    av_register_all();

    struct URLProtocol *pup = NULL;

    struct URLProtocol **p_temp = (struct URLProtocol **) &pup;
    avio_enum_protocols((void **) p_temp, 0);

    while ((*p_temp) != NULL) {
        sprintf(info, "%sInput: %s\n", info, avio_enum_protocols((void **) p_temp, 0));
    }
    pup = NULL;
    avio_enum_protocols((void **) p_temp, 1);
    while ((*p_temp) != NULL) {
        sprintf(info, "%sInput: %s\n", info, avio_enum_protocols((void **) p_temp, 1));
    }
    return (*env)->NewStringUTF(env, info);
}


JNIEXPORT jstring JNICALL
Java_com_gw_ffmpegcommand_FFmpegExecuter_getAvFormatInfo(JNIEnv *env, jobject obj) {
    char info[40000] = {0};
    av_register_all();

    AVInputFormat *if_temp = av_iformat_next(NULL);
    AVOutputFormat *of_temp = av_oformat_next(NULL);
    while (if_temp != NULL) {
        sprintf(info, "%sInput: %s\n", info, if_temp->name);
        if_temp = if_temp->next;
    }
    while (of_temp != NULL) {
        sprintf(info, "%sOutput: %s\n", info, of_temp->name);
        of_temp = of_temp->next;
    }
    return (*env)->NewStringUTF(env, info);
}

JNIEXPORT jstring JNICALL
Java_com_gw_ffmpegcommand_FFmpegExecuter_getAvCodecInfo(JNIEnv *env, jobject obj) {
    char info[40000] = {0};
    av_register_all();

    AVCodec *c_temp = av_codec_next(NULL);

    while (c_temp != NULL) {
        if (c_temp->decode != NULL) {
            sprintf(info, "%sdecode:", info);
        } else {
            sprintf(info, "%sencode:", info);
        }
        switch (c_temp->type) {
            case AVMEDIA_TYPE_VIDEO:
                sprintf(info, "%s(video):", info);
                break;
            case AVMEDIA_TYPE_AUDIO:
                sprintf(info, "%s(audio):", info);
                break;
            case AVMEDIA_TYPE_SUBTITLE:
                sprintf(info, "%s(subtitle):", info);
                break;
            default:
                sprintf(info, "%s(other):", info);
                break;
        }
        sprintf(info, "%s[%10s]\n", info, c_temp->name);
        c_temp = c_temp->next;
    }
    return (*env)->NewStringUTF(env, info);
}

JNIEXPORT jstring JNICALL
Java_com_gw_ffmpegcommand_FFmpegExecuter_getAvFilterInfo(JNIEnv *env, jobject obj) {
    char info[40000] = {0};
    avfilter_register_all();

    AVFilter *f_temp = (AVFilter *) avfilter_next(NULL);
    while (f_temp != NULL) {
        sprintf(info, "%s%s\n", info, f_temp->name);
        f_temp = f_temp->next;
    }
    return (*env)->NewStringUTF(env, info);
}