import 'package:get/get.dart';

import '../../../globals.dart' as globals;
import '../../../validatorsAuth/Validator.dart' as validator;
import '../../../validatorsAuth/Validator.dart';

import 'package:flutter/material.dart';
import '../../../validatorsAuth/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLogin extends StatefulWidget {
  MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailResetPass = TextEditingController();
  final authController = Get.find<AuthController>();

  bool _obscureText = true;
  bool _isRememberMeChecked = false;
  bool isLoading = true;

  void _savePreference(bool isChecked) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', isChecked);
  }

  Future<void> _loadPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool rememberMe = prefs.getBool('rememberMe') ?? false;
    setState(() {
      _isRememberMeChecked = rememberMe;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPreference().then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.03,
                    top: MediaQuery.of(context).size.width * 0.03),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.35,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/logo.png'),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 35, right: 35),
                        child: Column(
                          children: [
                            // const Text(
                            //   "Login",
                            //   style: TextStyle(
                            //       fontSize: 27, fontWeight: FontWeight.w700),
                            // ),
                            const SizedBox(height: 30),
                            // Align(
                            //   alignment: Alignment.centerLeft,
                            //   child: const Text("Email",
                            //       style: TextStyle(fontSize: 15)),
                            // ),
                            TextFormField(
                              controller: _emailController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: (text) {
                                FireError.userNotFoundError = false;
                              },
                              key: globals.emailLoginKey,
                              validator: (email) =>
                                  validator.emailValidatro(email!),
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            // const Text("Password",
                            //     style: TextStyle(fontSize: 18)),
                            TextFormField(
                              controller: _passwordController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: (text) {
                                FireError.wrongPassError = false;
                              },
                              key: globals.passLoginKey,
                              validator: (pass) =>
                                  validator.passwordValidator(pass!),
                              style: const TextStyle(),
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                              ),
                            ),
                            // const SizedBox(
                            //   height: 25,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      value: _isRememberMeChecked,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      activeColor: const Color(0xff4c505b),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isRememberMeChecked = value!;
                                          _savePreference(value);
                                        });
                                      },
                                    ),
                                    const Text(
                                      "Keep me signed in",
                                      style: TextStyle(
                                          color: Color(0xff4c505b),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.defaultDialog(
                                        title: 'Enter your email',
                                        content: TextFormField(
                                          validator: (email) =>
                                              validator.emailValidatro(email!),
                                          controller: _emailResetPass,
                                          decoration: InputDecoration(),
                                        ),
                                        confirm: MaterialButton(
                                          child: Text('Submit'),
                                          onPressed: () async {
                                            Get.snackbar(
                                                await authController
                                                    .resetPassword(
                                                        email: _emailResetPass
                                                            .text),
                                                '');
                                            _emailResetPass.clear();
                                          },
                                        ));
                                  },
                                  child: const Text(
                                    "Forgot password?",
                                    style: TextStyle(
                                        color: Color(0xff4c505b), fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            ElevatedButton(
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(Size(
                                    double.infinity,
                                    50)), // makes the button full width
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff4c505b)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                authController.onLogin();
                              },
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 20),
                            //add OR
                            const Text(
                              'OR',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff4c505b),
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 20),
                            OutlinedButton(
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    Size(double.infinity, 50)),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                authController.signInWithGoogle();
                              },
                              child: const Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image(
                                      image:
                                          AssetImage("assets/google_logo.png"),
                                      height: 35.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Sign in with Google',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            //const SizedBox(height: 25),

                            TextButton(
                              onPressed: () {
                                Get.offNamed("/register");
                              },
                              child: const Text(
                                "Don't have an account? Register",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  //decoration: TextDecoration.underline,
                                  color: Color(0xff4c505b),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}


// class MyLogin extends StatelessWidget {
//   MyLogin({Key? key}) : super(key: key);

//   final TextEditingController _emailResetPass = TextEditingController();
//   final authController = Get.find<AuthController>();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//             image: AssetImage('assets/login.png'), fit: BoxFit.cover),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Stack(
//           children: [
//             Container(
//               padding: EdgeInsets.only(
//                   left: MediaQuery.of(context).size.width * 0.03,
//                   top: MediaQuery.of(context).size.width * 0.03),
//               child: Container(
//                 height: MediaQuery.of(context).size.height * 0.2,
//                 width: MediaQuery.of(context).size.width * 0.35,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/logo.png'),
//                   ),
//                 ),
//               ),
//             ),
//             SingleChildScrollView(
//               child: Container(
//                 padding: EdgeInsets.only(
//                     top: MediaQuery.of(context).size.height * 0.3),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.only(left: 35, right: 35),
//                       child: Column(
//                         children: [
//                           TextFormField(
//                             autovalidateMode:
//                                 AutovalidateMode.onUserInteraction,
//                             onChanged: (text) {
//                               FireError.userNotFoundError = false;
//                             },
//                             key: globals.emailLoginKey,
//                             validator: (email) =>
//                                 validator.emailValidatro(email!),
//                             style: const TextStyle(color: Colors.black),
//                             decoration: InputDecoration(
//                                 fillColor: Colors.grey.shade100,
//                                 filled: true,
//                                 hintText: "Email",
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 )),
//                           ),
//                           const SizedBox(
//                             height: 30,
//                           ),
//                           TextFormField(
//                             autovalidateMode:
//                                 AutovalidateMode.onUserInteraction,
//                             onChanged: (text) {
//                               FireError.wrongPassError = false;
//                             },
//                             key: globals.passLoginKey,
//                             validator: (pass) =>
//                                 validator.passwordValidator(pass!),
//                             style: const TextStyle(),
//                             obscureText: true,
//                             decoration: InputDecoration(
//                                 fillColor: Colors.grey.shade100,
//                                 filled: true,
//                                 hintText: "Password",
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 )),
//                           ),
//                           const SizedBox(
//                             height: 25,
//                           ),
//                           const Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Remember Me",
//                                 style: const TextStyle(color: Colors.black),
//                               ),
//                               // Checkbox(
//                               //  ),

//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text(
//                                 'Sign in',
//                                 style: TextStyle(
//                                     fontSize: 27, fontWeight: FontWeight.w700),
//                               ),
//                               CircleAvatar(
//                                 radius: 30,
//                                 backgroundColor: const Color(0xff4c505b),
//                                 child: IconButton(
//                                     color: Colors.white,
//                                     onPressed: () {
//                                       authController.onLogin();

//                                     },
//                                     icon: const Icon(
//                                       Icons.arrow_forward,
//                                     )),
//                               )
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           OutlinedButton(
//                             style: ButtonStyle(
//                               backgroundColor:
//                                   MaterialStateProperty.all(Colors.white),
//                               shape: MaterialStateProperty.all(
//                                 RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(40),
//                                 ),
//                               ),
//                             ),

//                             onPressed: () {
//                               authController.signInWithGoogle();
//                             },

//                             child: const Padding(
//                               padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: <Widget>[
//                                   Image(
//                                     image: AssetImage("assets/google_logo.png"),
//                                     height: 35.0,
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.only(left: 10),
//                                     child: Text(
//                                       'Sign in with Google',
//                                       style: TextStyle(
//                                         fontSize: 20,
//                                         color: Colors.black54,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 25,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               TextButton(
//                                 onPressed: () {
//                                   Get.offNamed("/register");

//                                 },
//                                 style: const ButtonStyle(),

//                                 child: const Text(
//                                   'Sign Up',
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(
//                                       decoration: TextDecoration.underline,
//                                       color: Color(0xff4c505b),
//                                       fontSize: 18),
//                                 ),
//                               ),
//                               TextButton(

//                                   onPressed: () {
//                                     Get.defaultDialog(
//                                         title: 'Enter your email',
//                                         content: TextFormField(
//                                           validator: (email) =>
//                                               validator.emailValidatro(email!),
//                                           controller: _emailResetPass,
//                                           decoration: InputDecoration(),
//                                         ),
//                                         confirm: MaterialButton(
//                                           child: Text('Submit'),
//                                           onPressed: () async {
//                                             Get.snackbar(
//                                                 await authController
//                                                     .resetPassword(
//                                                         email: _emailResetPass
//                                                             .text),
//                                                 '');
//                                             _emailResetPass.clear();
//                                           },
//                                         ));
//                                   },


//                                   child: const Text(
//                                     'Forgot Password',
//                                     style: TextStyle(
//                                       decoration: TextDecoration.underline,
//                                       color: Color(0xff4c505b),
//                                       fontSize: 18,
//                                     ),
//                                   )),
//                             ],
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
