import 'package:fitness_tracker_app/theme/colors.dart';
import 'package:flutter/material.dart';

class SignUpBottomSheet extends StatefulWidget {
  const SignUpBottomSheet({super.key});

  @override
  State<SignUpBottomSheet> createState() => _SignUpBottomSheetState();
}

class _SignUpBottomSheetState extends State<SignUpBottomSheet> {
  // form state
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String? _seletedGender;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.8,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24.0),
            ),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 36,
            right: 36,
            top: 24,
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),

                // form area
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      //username
                      TextFormField(
                        controller: _usernameController,
                        cursorColor: labelColor,
                        decoration: const InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(color: labelColor),
                            floatingLabelStyle: TextStyle(color: labelColor),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primary))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // email
                      TextFormField(
                        controller: _emailController,
                        cursorColor: labelColor,
                        decoration: const InputDecoration(
                            labelText: 'E-mail',
                            labelStyle: TextStyle(color: labelColor),
                            floatingLabelStyle: TextStyle(color: labelColor),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primary))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      //password
                      TextFormField(
                        controller: _passwordController,
                        cursorColor: labelColor,
                        decoration: const InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: labelColor),
                            floatingLabelStyle: TextStyle(color: labelColor),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primary))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: 'Gender',
                                labelStyle: TextStyle(color: labelColor),
                              ),
                              value: _seletedGender,
                              items: ['Male', 'Female', 'Other']
                                  .map((gender) => DropdownMenuItem(
                                      value: gender, child: Text(gender)))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _seletedGender = value;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select your gender';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _ageController,
                              cursorColor: labelColor,
                              decoration: const InputDecoration(
                                  labelText: 'Age',
                                  labelStyle: TextStyle(color: labelColor),
                                  floatingLabelStyle:
                                      TextStyle(color: labelColor),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: primary))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Age';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Sign Up Button
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/root_app');
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient:
                            const LinearGradient(colors: [secondary, primary]),
                        borderRadius: BorderRadius.circular(30)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 16,
                              color: white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
