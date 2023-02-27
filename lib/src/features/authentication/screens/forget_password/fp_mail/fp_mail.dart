import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../fp_otp/otp_screen.dart';

class FpMail extends StatelessWidget {
  const FpMail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: Icon(Icons.fmd_bad_rounded),
        title: Text("Forgot Password"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Column(
            children: [
              LottieBuilder.asset("assets/lottie/forgot_password.json"),
              SizedBox(height: 20,),
              Text("Enter your E-mail below.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),),
              SizedBox(height: 20,),
              Form(
                child: TextFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      labelText: "Email",
                      hintText: "Email",
                      border: OutlineInputBorder()
                  ),
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => OtpScreen()));
                  },
                  child: Text("Next"),
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Colors.lightBlueAccent),
                      padding: EdgeInsets.symmetric(vertical: 15)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
