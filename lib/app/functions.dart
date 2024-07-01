import 'dart:io';
import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:form_without_connection/domain/models/device_info.dart';

const _androidIdPlugin = AndroidId();



Future<DeviceInfo> getDeviceInfo() async {
  String name = 'Unknown device';
  String identifier = 'Unknown identifier';
  String version = 'Unknown version';

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      // return android device info
      final String? androidId = await _androidIdPlugin.getId();
      var build = await deviceInfo.androidInfo;
      name = '${build.brand} ${build.model}';
      identifier = androidId ?? 'Unknown identifier';
      version = build.version.toString();
    } 
    if (Platform.isIOS) {
      // return ios device info
      var build = await deviceInfo.iosInfo;
      name = '${build.name} ${build.model}';
      identifier = build.identifierForVendor ?? 'Unknown identifier';
      version = build.systemVersion;
    }
    return DeviceInfo(
      name: name,
      version: version,
      identifier: identifier,
    );
  } on PlatformException {
    // return default device info
    return DeviceInfo(
      name: name,
      version: version,
      identifier: identifier,
    );
  }
}
