import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instaclone_again/pages/signup_page.dart';

import '../services/auth_service.dart';
import '../services/prefs_service.dart';
import '../services/utils_service.dart';
import 'home_page.dart';

class SignInPage extends StatefulWidget {
  static const String id = "singin_page";
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var isLoading = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  _callSignUpPage() {
    Navigator.pushReplacementNamed(context, SignUpPage.id);
  }
  _callHomePage(){
    Navigator.pushReplacementNamed(context, HomePage.id);
  }
  _doSignIn() async{
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();

    _callHomePage();

    if(email.isEmpty || password.isEmpty){
      Utils.fireToast("Check your email or password");
      return;
    }

    setState(() {
      isLoading = true;
    });

    User? firebaseUser = await AuthService.signInUser(context, email, password);
    if(firebaseUser != null){
      await Prefs.saveUserId(firebaseUser.uid);
      _callHomePage();
    }else{
      Utils.fireToast("Check your email or password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Container(
  width: MediaQuery.of(context).size.width,
  padding: EdgeInsets.all(30),
  decoration: const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(193, 53, 132, 1),
            Color.fromRGBO(131, 58, 180, 1),
          ]),),
  child: Stack(
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
         Expanded(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               const Text(
                 "Instagram",
                 style: TextStyle(
                     color: Colors.white,
                     fontSize: 45,
                     fontFamily: "Billabong"),
               ),

               //#email
               Container(
                 margin: const EdgeInsets.only(top: 10),
                 height: 50,
                 padding: const EdgeInsets.only(left: 10, right: 10),
                 decoration: BoxDecoration(
                     color: Colors.white.withOpacity(0.2),
                     borderRadius: BorderRadius.circular(7)),
                 child: TextField(
                   controller: emailController,
                   style: const TextStyle(color: Colors.white),
                   decoration: const InputDecoration(
                       hintText: "Email",
                       border: InputBorder.none,
                       hintStyle:
                       TextStyle(fontSize: 17, color: Colors.white54)),
                 ),
               ),

               //#password
               Container(
                 margin: const EdgeInsets.only(top: 10),
                 height: 50,
                 padding: const EdgeInsets.only(left: 10, right: 10),
                 decoration: BoxDecoration(
                     color: Colors.white.withOpacity(0.2),
                     borderRadius: BorderRadius.circular(7)),
                 child: TextField(
                   controller: passwordController,
                   style: const TextStyle(color: Colors.white),
                   obscureText: true,
                   decoration: const InputDecoration(
                       hintText: "Password",
                       border: InputBorder.none,
                       hintStyle:
                       TextStyle(fontSize: 17, color: Colors.white54)),
                 ),
               ),

               //#signin
               GestureDetector(
                 onTap: () {
                   _doSignIn();
                 },
                 child: Container(
                   margin: EdgeInsets.only(top: 10),
                   height: 50,
                   padding: EdgeInsets.only(left: 10, right: 10),
                   decoration: BoxDecoration(
                       color: Colors.white.withOpacity(0.2),
                       borderRadius: BorderRadius.circular(7)),
                   child: const Center(
                     child: Text(
                       "Sign In",
                       style:
                       TextStyle(color: Colors.white, fontSize: 17),
                     ),
                   ),),
               ),
             ],
           ),
         ),

          //#footer
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don`t have an account?",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                  onTap: () {
                    _callSignUpPage();
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ],
      ),
      isLoading? Center(child: CircularProgressIndicator(),):SizedBox.shrink(),
    ],
  ),
),
    );
  }
}
