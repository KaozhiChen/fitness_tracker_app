import 'package:flutter/material.dart';
import 'package:fitness_tracker_app/theme/colors.dart';

class UserInfoCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const UserInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  State<UserInfoCard> createState() => _UserInfoCardState();
}

class _UserInfoCardState extends State<UserInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: Container(
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [primary, secondary],
            ),
            borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          textColor: white,
          leading: Icon(
            widget.icon,
            color: white,
          ),
          title: Text(widget.title),
          subtitle: Text(widget.subtitle),
        ),
      ),
    );
  }
}