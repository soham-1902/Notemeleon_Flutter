import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sign_up/src/constants/image_strings.dart';
import 'package:flutter_sign_up/src/features/authentication/screens/login_screen.dart';
import 'package:flutter_sign_up/src/features/authentication/screens/signup_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.hiking_sharp),
        title: Text("Welcome Screen"),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(tWelcomeScreen, height: height * 0.4,),
              Column(
                children: [
                  Text("Hit Every Deadline", style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                  Text("Go paperless, create notes and reminders so nothing falls through the cracks 🤟", style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center,),
                ],
              ),
              Row(
                children: [
                  const SizedBox(width: 14,),
                  Expanded(child: OutlinedButton(onPressed: () {
                    Get.to(() => const LoginScreen());
                  }, child: Text("LOGIN"),
                    style: OutlinedButton.styleFrom(side: BorderSide(color: CupertinoColors.black), padding: EdgeInsets.symmetric(vertical: 15)),)),
                  const SizedBox(width: 10,),
                  Expanded(child: ElevatedButton(onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen()));
                  }, child: Text("SIGN UP"),
                      style: ElevatedButton.styleFrom(side: BorderSide(color: Colors.lightBlueAccent), padding: EdgeInsets.symmetric(vertical: 15)),)),
                  const SizedBox(width: 14,),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
