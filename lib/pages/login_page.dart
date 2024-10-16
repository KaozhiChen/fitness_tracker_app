import 'package:fitness_tracker_app/theme/colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
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
                const Text(
                  "Hey there,",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Welcome Back!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}