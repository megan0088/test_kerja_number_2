// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:number_2/constants/apiKey/login_api.dart';
import 'package:number_2/Features/view/profile_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  var user = await LoginAPI.login();
                  if (user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuccessLogin(
                            name: user.displayName!, email: user.email),
                      ),
                    );
                  }
                } catch (e) {
                  debugPrint('Failed to sign in: $e');
                }
              },
              child: const Text('Login with Google'),
            )
          ],
        ),
      ),
    );
  }
}
