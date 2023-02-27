import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_sign_up/src/features/authentication/controllers/otp_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var otpController = Get.put(OtpController());
    var otp;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: Icon(Icons.hail),
        title: Text("Login Screen"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 70),
        alignment: Alignment.center,
        child: Column(
          children: [
            Text("CO\nDE", style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 80.0,
            ),),
            Text("VERIFICATION", style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),),
            SizedBox(
              height: 10,
            ),
            Text("Enter the code sent at entered mobile number", textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blueGrey, fontSize: 11, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 25,
            ),
            OtpTextField(
              numberOfFields: 6,
              filled: true,
              fillColor: Colors.black.withOpacity(0.1),
              onSubmit: (code) {
                otp = code;
                OtpController.instance.verifyOtp(otp);
              },
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    OtpController.instance.verifyOtp(otp);
                  },
                  child: Text("Next"),
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Colors.lightBlueAccent),
                      padding: EdgeInsets.symmetric(vertical: 15)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
