import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sign_up/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import 'forget_password/fp_mail/fp_mail.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: Icon(Icons.hail),
        title: Text("Login Screen"),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LottieBuilder.asset("assets/lottie/login_lottie.json", width: width * 0.8, height: height * 0.2,),
              const SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome Back,", style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),),
                  Text("Make it work, make it right, make it fast!", style: Theme.of(context).textTheme.bodyMedium,),
                  Container(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person_outline_sharp),
                              labelText: "Email",
                              hintText: "Email",
                              border: OutlineInputBorder()
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextField(
                          controller: _passwordController,
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.fingerprint),
                            labelText: "Password",
                            hintText: "Password",
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
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Align(alignment: Alignment.centerRight, child: InkWell(
                  onTap: () {
                    showModalBottomSheet(context: context,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                        builder: (context) => Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Make Selection!
                                  //Select one of the options given below to reset your password.
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 20,),
                                      Text("Make Selection!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                      Text("Select one of the options given below to reset your password.", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10),),
                                    ],
                                  ),
                                  const SizedBox(height: 30,),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => FpMail()));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade200,
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.mail_outline_outlined, size: 60,),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("E-mail", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),),
                                              Text("Reset via mail verification.", style: TextStyle(fontWeight: FontWeight.w200, fontSize: 11),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  GestureDetector(
                                    onTap: () {

                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade200,
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.mobile_friendly_outlined, size: 60,),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Phone No", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),),
                                              Text("Reset via Phone verification.", style: TextStyle(fontWeight: FontWeight.w200, fontSize: 11),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]
                            )));
                  },
                  child: Text("Forgot Password?",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 11, fontWeight: FontWeight.bold),

                  ))),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    AuthenticationRepository ar = AuthenticationRepository();
                    ar.loginWithEmailAndPassword(_emailController.text, _passwordController.text);
                  },
                  child: Text("Login"),
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
                  Text("Don't have an account? Signup", style: TextStyle(color: Colors.blueGrey, fontSize: 12, fontWeight: FontWeight.bold),)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



