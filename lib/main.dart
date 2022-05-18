import 'package:flaq_ui_v2/bindings.dart';
import 'package:flaq_ui_v2/services/auth.service.dart';
import 'package:flaq_ui_v2/modules/home/home.controller.dart';
import 'package:flaq_ui_v2/modules/home/home.screen.dart';
import 'package:flaq_ui_v2/modules/login/login.screen.dart';
import 'package:flaq_ui_v2/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  Future.delayed(const Duration(milliseconds: 1)).then((value) =>
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark, // bar light == text dark
      )));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.dualRing;
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Montserrat'),
      smartManagement: SmartManagement.keepFactory,
      initialBinding: AppBindings(),
      debugShowCheckedModeBanner: false,
      home: const Material(child: Root()),
      builder: EasyLoading.init(),
    );
  }
}

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return const HomeScreen();
    // return const LoginScreen();
    return SplashScreen();
  }
}

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key) {
    Get.put(AuthService());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Center(
        child: Image.asset('assets/images/Logo.png'),
      ),
    );
  }
}
