import 'package:fitness_tracker_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'signup_sheet.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  void _showSignUpBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        builder: (BuildContext context) {
          return const SignUpBottomSheet();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: loginPageBody(),
    );
  }

  Widget loginPageBody() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              children: [
                // Welcome and TextField
                Column(
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    const Text(
                      "Hey there,",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "Welcome Back!",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: bgTextField,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.mail_outline,
                              color: black.withOpacity(0.5),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                                child: TextField(
                              decoration: const InputDecoration(
                                  labelText: "Email", border: InputBorder.none),
                              cursorColor: black.withOpacity(0.5),
                            ))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: bgTextField,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lock_outline,
                              color: black.withOpacity(0.5),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                                child: TextField(
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                  labelText: "Password",
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                      icon: Icon(_obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off_outlined))),
                              cursorColor: black.withOpacity(0.5),
                            ))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Forget Password?",
                      style: TextStyle(
                          decoration: TextDecoration.underline, fontSize: 14),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),

                // login area
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/root_app');
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [secondary, primary]),
                            borderRadius: BorderRadius.circular(30)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      children: [
                        Flexible(
                            child: Divider(
                          thickness: 0.8,
                        )),
                        SizedBox(
                          width: 8,
                        ),
                        Text("Or"),
                        SizedBox(
                          width: 8,
                        ),
                        Flexible(
                            child: Divider(
                          thickness: 0.8,
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: black.withOpacity(0.1))),
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/images/google_icon.svg",
                              width: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: black.withOpacity(0.1))),
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/images/facebook_icon.svg",
                              width: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    // ignore: prefer_const_constructors
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Do not have an account? '),
                        InkWell(
                          onTap: () {
                            _showSignUpBottomSheet();
                          },
                          child: const Text(
                            'Sign UP',
                            style: TextStyle(
                              color: primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
