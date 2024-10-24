import 'package:fitness_tracker_app/theme/colors.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // 编辑资料逻辑
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // profile photo
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      // backgroundColor: Colors.grey[300],
                      backgroundImage: AssetImage("assets/images/logo.png"),
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
              const Text(
                'John Doe',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'johndoe@example.com',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // user informations
              Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [primary, secondary],
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  child: const ListTile(
                    textColor: white,
                    leading: Icon(
                      Icons.person,
                      color: white,
                    ),
                    title: Text("Gender"),
                    subtitle: Text("Male"),
                  ),
                ),
              ),

              const Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: ListTile(
                  leading: Icon(Icons.cake),
                  title: Text("Age"),
                  subtitle: Text("25"),
                ),
              ),
              const Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: ListTile(
                  leading: Icon(Icons.phone),
                  title: Text("Phone Number"),
                  subtitle: Text("+1 234 567 890"),
                ),
              ),
              const Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: ListTile(
                  leading: Icon(Icons.location_city),
                  title: Text("Address"),
                  subtitle: Text("New York, USA"),
                ),
              ),
              const Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: ListTile(
                  leading: Icon(Icons.location_city),
                  title: Text("Goals"),
                  subtitle: Text("Workout 2 hours"),
                ),
              ),
              // 操作按钮
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
                  // 退出登录逻辑
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
          ),
        ),
      ),
    );
  }
}
