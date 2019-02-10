#include <jni.h>
#include <string>

extern "C" JNIEXPORT jstring

JNICALL
Java_jonathan_p2_12048_MainActivity_stringFromJNI(
        JNIEnv *env,
        jobject /* this */) {
    std::string hello = "Hello from C++";
    return env->NewStringUTF(hello.c_str());
}
