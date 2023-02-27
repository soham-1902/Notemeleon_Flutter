import 'package:flutter/material.dart';
import 'package:flutter_sign_up/src/features/authentication/controllers/signup_controller.dart';
import 'package:flutter_sign_up/src/features/authentication/screens/forget_password/fp_otp/otp_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  static final _formKey = GlobalKey<FormState>();
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final controller = Get.put(SignUpController());

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: Icon(Icons.hail),
        title: Text("Signup Screen"),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LottieBuilder.asset("assets/lottie/signup_lottie.json", width: width * 0.8, height: height * 0.2,),
              const SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Get On Board!", style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),),
                  Text("Create your profile to start your journey.", style: Theme.of(context).textTheme.bodyMedium,),
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: controller.fullName,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person_outline_sharp),
                                labelText: "Full Name",
                                hintText: "Full Name",
                                border: OutlineInputBorder()
                            ),
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            controller: controller.email,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined),
                              labelText: "Email",
                              hintText: "Email",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            controller: controller.phoneNo,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                labelText: "Phone No",
                                hintText: "+91xxxxxxxxxx",
                                border: OutlineInputBorder()
                            ),
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            controller: controller.password,
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.fingerprint),
                              labelText: "Create Password",
                              hintText: "Create Password",
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      //SignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());
                      SignUpController.instance.phoneAuthentication(controller.phoneNo.text.trim());
                      Get.to(() => const OtpScreen());
                    }
                  },
                  child: Text("Sign Up"),
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Colors.lightBlueAccent),
                      padding: EdgeInsets.symmetric(vertical: 15)
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "OR", style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(

                      onPressed: () {},
                      label: Text(" Sign-In with Google"),
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.black),
                          padding: EdgeInsets.symmetric(vertical: 15)
                      ),
                      icon: SvgPicture.asset("assets/logo/google_svg.svg", height: 20,),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Already have an account? Login", style: TextStyle(color: Colors.blueGrey, fontSize: 12, fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
