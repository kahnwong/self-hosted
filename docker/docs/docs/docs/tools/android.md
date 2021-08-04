---
title: Android
---

## APKTool
https://ibotpeaches.github.io/Apktool/documentation/

```bash
### decompile and rebuild
$ apktool d APK.apk
$ apktool b . --use-aapt2

### signing APK
# https://stackoverflow.com/questions/10930331/how-to-sign-an-already-compiled-apk

$ keytool -genkey -v -keystore my-release-key.keystore -alias alias_name -keyalg RSA -keysize 2048 -validity 10000

$ jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore my-release-key.keystore my_application.apk alias_name
```

## ADB

### Backup & Restore
```bash
adb backup -f wallabag.ab -apk fr.gaulupeau.apps.InThePoche
adb backup -all -f backup.ab -apk -nosystem -obb 

adb backup -all -f backup.ab -apk -noshared -system  
adb restore backup.ab
```

### Misc
```bash
# extract appdata
java -jar abe.jar unpack backup.ab DATA.tar

# clear all contacts on Android
adb shell pm clear com.android.providers.contacts

# install all apks
for %f in (*.apk) do adb install "%f"
```