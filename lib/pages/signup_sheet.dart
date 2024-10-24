// import 'dart:convert';
import 'package:fitness_tracker_app/models/user.dart';
import 'package:fitness_tracker_app/services/database_helper.dart';
import 'package:fitness_tracker_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  String? _seletedGender;
  String _selectedGoal = 'lose weight';

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
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
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _heightController,
                              cursorColor: labelColor,
                              decoration: const InputDecoration(
                                labelText: 'Height (cm)',
                                labelStyle: TextStyle(color: labelColor),
                                floatingLabelStyle:
                                    TextStyle(color: labelColor),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: primary),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your height';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _weightController,
                              cursorColor: labelColor,
                              decoration: const InputDecoration(
                                labelText: 'Weight (kg)',
                                labelStyle: TextStyle(color: labelColor),
                                floatingLabelStyle:
                                    TextStyle(color: labelColor),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: primary),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your weight';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Goal',
                          labelStyle: TextStyle(color: labelColor),
                        ),
                        value: _selectedGoal,
                        items: ['lose weight', 'maintain weight', 'gain weight']
                            .map((goal) => DropdownMenuItem(
                                value: goal, child: Text(goal)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedGoal = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Sign Up Button
                InkWell(
                  onTap: () async {
                    final messeger = ScaffoldMessenger.of(context);
                    final navigator = Navigator.of(context);
                    if (_formKey.currentState!.validate()) {
                      try {
                        // create User and insert to database
                        User newUser = User(
                          username: _usernameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          gender: _seletedGender!,
                          age: int.parse(_ageController.text),
                          height: double.parse(_heightController.text),
                          weight: double.parse(_weightController.text),
                          goal: _selectedGoal,
                        );

                        // get userId
                        int userId = await DatabaseHelper().insertUser(newUser);

                        // save userId to SharedPreferences
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setInt('userId', userId);

                        // query all users
                        // List<User> allUsers =
                        //     await DatabaseHelper().getAllUsers();

                        // String jsonAllUsers = jsonEncode(
                        //     allUsers.map((user) => user.toMap()).toList());
                        // print(jsonAllUsers);

                        messeger.showSnackBar(
                          const SnackBar(
                              content: Text('Registration Successful')),
                        );
                        navigator.pop();
                      } catch (e) {
                        messeger.showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    }
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
