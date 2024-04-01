import 'package:flutter/material.dart';
import 'package:seouldata/src/binding/register_binding.dart';
import 'package:seouldata/auth_handler.dart';
import 'package:seouldata/src/ui/register.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class LoginController extends GetxController {
  final RxBool _isLoading = false.obs;

  final _email = TextEditingController();
  final _password = TextEditingController();

  bool get isLoading => _isLoading.value;

  TextEditingController get email => _email;
  TextEditingController get password => _password;

  void validate() {
    if (_email.value.text.trim().isEmpty ||
        _password.value.text.trim().isEmpty) {
      return;
    }
    _isLoading(true);
    AuthHandler.signIn(_email.value.text.trim(), password.value.text.trim())
        .then((_) {
      _isLoading(false);
      Get.dialog(_accept());
      Future.delayed(const Duration(seconds: 2)).then((_) {
        Get.back();
      });
    });
  }

  void moveToRegister() {
    Get.to(() => const Resister(), binding: RegisterBinding());
  }

  Widget _accept() {
    return const SizedBox(
        width: 100,
        height: 100,
        child: RiveAnimation.asset('asset/riveasset/check_icon.riv'));
  }
}