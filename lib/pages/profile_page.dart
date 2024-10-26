import 'package:fitness_tracker_app/widgets/user_info_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitness_tracker_app/theme/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/user_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    // loading user data
    Provider.of<UserProvider>(context, listen: false).loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              if (userProvider.user == null) {
                // display loading
                return const Center(child: CircularProgressIndicator());
              } else {
                // display user info
                final user = userProvider.user!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // profile photo
                    const Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                AssetImage("assets/images/logo.png"),
                          ),
                          // Positioned(
                          //   bottom: 0,
                          //   right: 0,
                          //   child: Container(
                          //     width: 26,
                          //     height: 26,
                          //     decoration: const BoxDecoration(
                          //       shape: BoxShape.circle,
                          //       color: secondary,
                          //     ),
                          //     child: GestureDetector(
                          //       onTap: () {},
                          //       child: const Center(
                          //         child: Icon(
                          //           Icons.camera_alt_outlined,
                          //           color: white,
                          //           size: 20,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // user name and email
                    Text(
                      'Hi,${user.username}!',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 20),

                    // user informations
                    UserInfoCard(
                      icon: Icons.person,
                      title: "Gender",
                      subtitle: user.gender,
                      onEdit: () {
                        _showEditDialog(context, "Gender", (newValue) async {
                          // create a User with new info
                          final updatedUser = user.copyWith(gender: newValue);

                          // use Provider to update UI and save new value to database
                          await userProvider.updateUserAsync(updatedUser);
                        });
                      },
                    ),
                    UserInfoCard(
                      icon: Icons.cake,
                      title: "Age",
                      subtitle: user.age.toString(),
                      onEdit: () {
                        _showEditDialog(context, "Age", (newValue) async {
                          // create a User with new info
                          final updatedUser =
                              user.copyWith(age: int.parse(newValue));

                          // use Provider to update UI and save new value to database
                          await userProvider.updateUserAsync(updatedUser);
                        });
                      },
                    ),
                    UserInfoCard(
                      icon: Icons.mail,
                      title: "Email",
                      subtitle: user.email,
                      onEdit: () {
                        _showEditDialog(context, "Email", (newValue) async {
                          // create a User with new info
                          final updatedUser = user.copyWith(email: newValue);

                          // use Provider to update UI and save new value to database
                          await userProvider.updateUserAsync(updatedUser);
                        });
                      },
                    ),
                    UserInfoCard(
                      icon: Icons.height,
                      title: "Height",
                      subtitle: user.height.toString(),
                      onEdit: () {
                        _showEditDialog(context, "Height", (newValue) async {
                          // create a User with new info
                          final updatedUser =
                              user.copyWith(height: double.parse(newValue));

                          // use Provider to update UI and save new value to database
                          await userProvider.updateUserAsync(updatedUser);
                        });
                      },
                    ),
                    UserInfoCard(
                      icon: Icons.scale,
                      title: "Weight",
                      subtitle: user.weight.toString(),
                      onEdit: () {
                        _showEditDialog(context, "Weight", (newValue) async {
                          // create a User with new info
                          final updatedUser =
                              user.copyWith(weight: double.parse(newValue));

                          // use Provider to update UI and save new value to database
                          await userProvider.updateUserAsync(updatedUser);
                        });
                      },
                    ),
                    UserInfoCard(
                      icon: Icons.flag,
                      title: "Goal",
                      subtitle: user.goal.toString(),
                      onEdit: () {
                        _showEditGoalDialog(context, user.goal.toString(),
                            (newGoal) async {
                          final updatedUser = user.copyWith(goal: newGoal);
                          await userProvider.updateUserAsync(updatedUser);
                        });
                      },
                    ),

                    // change password
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        _showChangePasswordDialog(context);
                      },
                      child: const Text(
                        'Change password',
                        style: TextStyle(
                            color: primary,
                            decoration: TextDecoration.underline,
                            decorationColor: primary),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () async {
                        // Show confirmation dialog
                        bool confirmLogout = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Confirm Logout"),
                              content: const Text(
                                  "Are you sure you want to log out?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(false); // Cancel logout
                                  },
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(true); // Confirm logout
                                  },
                                  child: const Text("Logout"),
                                ),
                              ],
                            );
                          },
                        );

                        // If user confirmed, proceed with logout
                        if (confirmLogout == true) {
                          // Clean user data in local storage
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.clear();

                          // Navigate to login page
                          Navigator.of(context).pushReplacementNamed('/login');
                        }
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: white,
                      ),
                      label: const Text(
                        "Logout",
                        style: TextStyle(color: white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: thirdColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  // show edit other user info dialog
  void _showEditDialog(
      BuildContext context, String fieldName, Function(String) onSave) {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit $fieldName"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: "Enter new $fieldName",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await onSave(controller.text);
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // show edit goal dialog
  void _showEditGoalDialog(
      BuildContext context, String currentGoal, Function(String) onSave) {
    String selectedGoal = currentGoal;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Goal"),
          content: DropdownButtonFormField<String>(
            value: selectedGoal,
            items: ['lose weight', 'maintain weight', 'gain weight']
                .map((goal) => DropdownMenuItem(
                      value: goal,
                      child: Text(goal),
                    ))
                .toList(),
            onChanged: (value) {
              selectedGoal = value!;
            },
            decoration: const InputDecoration(
              labelText: "Select your goal",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await onSave(selectedGoal);
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // show change password dialog
  void _showChangePasswordDialog(BuildContext context) {
    final TextEditingController oldPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Change Password"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: oldPasswordController,
                  decoration: const InputDecoration(
                    labelText: "Enter old password",
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: newPasswordController,
                  decoration: const InputDecoration(
                    labelText: "Enter new password",
                  ),
                  obscureText: true,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (user != null) {
                  if (oldPasswordController.text == user.password) {
                    // update user object
                    final updatedUser =
                        user.copyWith(password: newPasswordController.text);
                    await userProvider.updateUserAsync(updatedUser);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Password changed successfully')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Old password is incorrect')),
                    );
                  }
                }
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
