import 'package:flutter/material.dart';
import 'package:order_med/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 60),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 150,
                    child: Image.asset('assets/img/medical-logo.png')),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 0.1, bottom: 1.0),
              child: LoginForm(),
            ),
            TextButton(
                onPressed: () {
                  print("/register");
                },
                child: const Text('New User? Create Account'))
          ],
        ),
      ),
    );
  }
}
