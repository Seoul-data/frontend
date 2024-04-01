import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seouldata/src/binding/app_binding.dart';
import 'package:seouldata/src/binding/login_binding.dart';
import 'package:seouldata/src/constants/firebase_const.dart';
import 'package:seouldata/src/ui/home.dart';
import 'package:seouldata/src/ui/login.dart';
import 'package:get/get.dart';

class AuthHandler extends GetxService {
  final _user = auth.currentUser.obs;

  @override
  void onReady() {
    super.onReady();
    _user.bindStream(auth.authStateChanges());
    ever(_user, moveToPage);
  }

  moveToPage(User? user) {
    if (user == null) {
      Get.off(() => const Login(), binding: LoginBinding());
    } else {
      Get.off(() => const Home(), binding: AppBinding());
    }
  }

  static Future<void> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      debugPrint('에러');
    }
  }

  static Future<void> signUp(String email, String password) async {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint('에러');
    }
  }
}