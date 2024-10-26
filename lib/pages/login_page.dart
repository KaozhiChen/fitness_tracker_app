import 'package:fitness_tracker_app/models/user.dart';
import 'package:fitness_tracker_app/pages/forget_password_sheet.dart';
import 'package:fitness_tracker_app/services/database_helper.dart';
import 'package:fitness_tracker_app/theme/colors.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/user_provider.dart';
import 'signup_sheet.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

  void _showForgetPasswordSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.25,
          maxChildSize: 0.7,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: const ForgetPasswordSheet(),
              ),
            );
          },
        );
      },
    );
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
                              Icons.account_box_outlined,
                              color: black.withOpacity(0.5),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                                child: TextField(
                              controller: _usernameController,
                              decoration: const InputDecoration(
                                  labelText: "Username",
                                  border: InputBorder.none),
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
                              controller: _passwordController,
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
                    GestureDetector(
                      onTap: () {
                        _showForgetPasswordSheet(context);
                      },
                      child: const Text(
                        "Forget Password?",
                        style: TextStyle(
                            decoration: TextDecoration.underline, fontSize: 14),
                      ),
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
                      onTap: () async {
                        final messenger = ScaffoldMessenger.of(context);
                        final navigator = Navigator.of(context);
                        String username = _usernameController.text;
                        String password = _passwordController.text;
                        // verify
                        User? user = await DatabaseHelper()
                            .validateLogin(username, password);
                        if (user != null) {
                          // login successfully
                          // save userId to local storage
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setInt('userId', user.id!);

                          // use Provider manage user data
                          Provider.of<UserProvider>(context, listen: false)
                              .updateUser(user);
                          navigator.pushNamed('/root_app');
                        } else {
                          messenger.showSnackBar(
                            const SnackBar(
                                content: Text('Invalid username or password')),
                          );
                        }
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
                        // Text("Or"),
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
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       width: 50,
                    //       height: 50,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(12),
                    //           border:
                    //               Border.all(color: black.withOpacity(0.1))),
                    //       child: Center(
                    //         child: SvgPicture.asset(
                    //           "assets/images/google_icon.svg",
                    //           width: 20,
                    //         ),
                    //       ),
                    //     ),
                    //     const SizedBox(
                    //       width: 12,
                    //     ),
                    //     Container(
                    //       width: 50,
                    //       height: 50,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(12),
                    //           border:
                    //               Border.all(color: black.withOpacity(0.1))),
                    //       child: Center(
                    //         child: SvgPicture.asset(
                    //           "assets/images/facebook_icon.svg",
                    //           width: 20,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
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
