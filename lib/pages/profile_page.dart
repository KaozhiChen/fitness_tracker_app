import 'package:fitness_tracker_app/widgets/goal_card.dart';
import 'package:fitness_tracker_app/widgets/user_info_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitness_tracker_app/theme/colors.dart';
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
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          )
        ],
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
                    Center(
                      child: Stack(
                        children: [
                          const CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                AssetImage("assets/images/logo.png"),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: secondary,
                              ),
                              child: GestureDetector(
                                onTap: () {},
                                child: const Center(
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                    // const SizedBox(height: 4),
                    // Text(
                    //   user.email,
                    //   style: const TextStyle(fontSize: 16, color: Colors.grey),
                    // ),
                    const SizedBox(height: 20),

                    // user informations
                    UserInfoCard(
                      icon: Icons.person,
                      title: "Gender",
                      subtitle: user.gender,
                    ),
                    UserInfoCard(
                      icon: Icons.cake,
                      title: "Age",
                      subtitle: user.age.toString(),
                    ),
                    UserInfoCard(
                      icon: Icons.mail,
                      title: "Email",
                      subtitle: user.email,
                    ),
                    const GoalCard(),

                    // change password
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {},
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
                      onPressed: () {
                        //logout
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
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
