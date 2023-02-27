import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sign_up/main.dart';
import 'package:flutter_sign_up/src/features/authentication/screens/welcome_screen.dart';
import 'package:flutter_sign_up/src/repository/authentication_repository/exceptions/signup_email_pass_failure.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());

    ever(firebaseUser, _setInitialScreen);
  }


  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          if(e.code == 'invalid-phone-number') {
            Get.snackbar('Error', 'The provided phone number is not valid.');
          } else {
            Get.snackbar('Error', 'Something went wrong.');
          }
        },
        codeSent: (verificationId, resendToken) {
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId.value = verificationId;
        }
    );
  }

  Future<bool> verifyOtp(String otp) async {
    var credentials = await _auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  _setInitialScreen(User? callback) {
    callback == null ? Get.offAll(() => const WelcomeScreen()) : Get.offAll(() => const AppHome());
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth .createUserWithEmailAndPassword(email: email, password: password);

      firebaseUser.value!= null ? Get.offAll(() => const AppHome()) : Get.to(() => const WelcomeScreen());

    } on FirebaseAuthException catch(e) {
      final ex = SignUpEmailPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    } catch(_) {
      const ex = SignUpEmailPasswordFailure();
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    }

  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth .signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value!= null ? Get.offAll(() => const AppHome()) : Get.to(() => const WelcomeScreen());
    } on FirebaseAuthException catch(e) {

    } catch(_) {}
  }

  Future<void> logout() async => await _auth.signOut();
}