import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:seouldata/firebase_options.dart';
import 'package:seouldata/src/controller/login_controller.dart';
import 'package:seouldata/src/ui/login.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(LoginController()); // LoginController 초기화
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(focusColor: Colors.blueAccent),
      home: const Login(),
    );
  }
}