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
              // 用户头像部分
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[300],
                      // backgroundImage: const AssetImage(
                      //     "assets/images/profile_placeholder.png"), // 用户头像图片
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: secondary,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // 更换头像逻辑
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 用户名和邮箱
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

              // 用户详细信息（性别、年龄等）
              const Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Gender"),
                  subtitle: Text("Male"),
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
