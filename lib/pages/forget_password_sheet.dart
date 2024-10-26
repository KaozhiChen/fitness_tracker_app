import 'package:flutter/material.dart';
import '../services/database_helper.dart';

class ForgetPasswordSheet extends StatefulWidget {
  const ForgetPasswordSheet({super.key});

  @override
  _ForgetPasswordSheetState createState() => _ForgetPasswordSheetState();
}

class _ForgetPasswordSheetState extends State<ForgetPasswordSheet> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _password;
  bool _loading = false;

  Future<void> _retrievePassword() async {
    setState(() {
      _loading = true;
    });

    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();

    // check database
    var user = await DatabaseHelper.instance.validateUserEmail(username, email);

    if (user != null) {
      setState(() {
        _password = user.password;
        _loading = false;
      });
    } else {
      setState(() {
        _password = null;
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username and Email do not match')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Find password',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'username',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          _loading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: _retrievePassword,
                  child: const Text('find password'),
                ),
          const SizedBox(height: 10),
          if (_password != null) ...[
            const Text('Your password is:'),
            Text(
              _password!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            )
          ],
        ],
      ),
    );
  }
}
