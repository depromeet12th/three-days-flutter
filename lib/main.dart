import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'three_days_app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterConfig.loadEnvVariables();

  KakaoSdk.init(
    nativeAppKey: FlutterConfig.get('KAKAO_NATIVE_APP_KEY'),
  );

  runApp(const ThreeDaysApp());
}
