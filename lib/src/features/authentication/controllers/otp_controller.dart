import 'package:flutter_sign_up/src/repository/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';

import '../../../../main.dart';

class OtpController extends GetxController {
  static OtpController get instance => Get.find();

  void verifyOtp(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOtp(otp);
    isVerified ? Get.offAll(const AppHome()) : Get.back();
  }
}