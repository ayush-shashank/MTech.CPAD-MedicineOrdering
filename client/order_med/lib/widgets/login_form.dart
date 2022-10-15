import 'package:order_med/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:order_med/service/customer_service.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  SnackBar failure = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red[600],
      duration: const Duration(milliseconds: 1250),
      content: const Text('Invalid Credentials!'));
  SnackBar success = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green[600],
      duration: const Duration(milliseconds: 1250),
      content: const Text('Successfully Logged In!'));

  void onLogin() async {
    if (_formKey.currentState!.validate()) {
      CustomerService.instance
          .login(email: emailController.text, password: passwordController.text)
          .then((user) {
        globals.isLoggedIn = true;
        globals.userId = user.id;
        Navigator.pushNamed(context, '/dashboard');
        ScaffoldMessenger.of(context).showSnackBar(success);
      }).catchError((err) {
        ScaffoldMessenger.of(context).showSnackBar(failure);
      });
    }
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the email address!';
    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Please enter a valid email address!';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the password!';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              autofocus: true,
              enableSuggestions: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Example: abc@gmail.com'),
              validator: emailValidator,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter password'),
              validator: passwordValidator,
            ),
          ),
          Container(
            height: 50,
            width: 250,
            margin: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: onLogin,
              child: const Text(
                'Login',
                style: TextStyle(
                    textBaseline: TextBaseline.ideographic,
                    color: Colors.white,
                    fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
