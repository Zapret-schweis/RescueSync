// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'package:alarm/alarm.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:real_volume/real_volume.dart';

class PlaySOS {
  void setAlarmSettings(String username, int id,
      [int time = 30,
      String title = 'ACİL DURUM ÇAĞRISI',
      String body = ' Kullanıcısı tarafından çağrılıyorsunuz!',
      bool loopAudio = false,
      bool vibrate = true,
      double volume = 1.0,
      String assetAudioPath = 'assets/alarm/alarm.mp3',
      double fadeDuration = 5.0,
      bool androidFullScreenIntent = true,
      bool volumeEnforced = true,
      String dateTime = 'now']) {
    // ignore: unnecessary_null_comparison
    if (username == null || id == null) {
      throw ArgumentError('username ve id parametreleri null olamaz.');
    }

    if (dateTime == 'now') {
      final alarmSettings = AlarmSettings(
        id: id,
        volume: volume,
        vibrate: vibrate,
        loopAudio: loopAudio,
        fadeDuration: fadeDuration,
        androidFullScreenIntent: androidFullScreenIntent,
        warningNotificationOnKill: Platform.isAndroid,
        dateTime: DateTime.now(),
        assetAudioPath: assetAudioPath,
        volumeEnforced: volumeEnforced,
        notificationSettings: NotificationSettings(
          title: title,
          body: username + body,
          icon: 'android/app/src/main/res/drawable/ic_launcher.png',
        ),
      );

      Alarm.set(alarmSettings: alarmSettings);

      Timer(Duration(seconds: time), () async {
        await Alarm.stop(id);
      });
    }
  }

  Future<void> playMp3InBackground() async {
  final AudioPlayer audioPlayer = AudioPlayer()
    ..setAudioContext(AudioContext(
        android: const AudioContextAndroid(
            isSpeakerphoneOn: true,
            stayAwake: true,
            contentType: AndroidContentType.music,
            usageType: AndroidUsageType.media)));

  // ignore: unused_local_variable
  Timer? volumeControlTimer;

  try {
    bool? isPermissionGranted = await RealVolume.isPermissionGranted();

    if (!isPermissionGranted!) {
      // Opens Do Not Disturb Access settings to grant the access
      await RealVolume.openDoNotDisturbSettings();
    }
    // Ses dosyasını asset'ten yükle
    await audioPlayer.setSourceAsset('alarm/alarm.mp3');

    // Ses seviyesini maksimuma çek

    // 30 saniye boyunca ses seviyesi kontrolü
    volumeControlTimer =
        Timer.periodic(const Duration(milliseconds: 500), (timer) async {
      await RealVolume.setVolume(1.0,
          showUI: false, streamType: StreamType.MUSIC);
    });

    // Çalmayı başlat ve loop moduna alc
    await audioPlayer.resume();
    await audioPlayer.setReleaseMode(ReleaseMode.loop);

    // 30 saniye sonra durdur
    Timer(const Duration(seconds: 30), () async {
      await audioPlayer.stop();
      print('Alarm durduruldu');
    });
  } catch (e) {
    print("Hata: ${e.toString()}");
  }
}
}

