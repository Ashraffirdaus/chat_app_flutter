// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:login_page_auth/services/auth/auth_service.dart';
import 'package:login_page_auth/widget_page.dart/login_textfield.dart';
import 'package:login_page_auth/widget_page.dart/sign_in_butto.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onTap});
  final void Function()? onTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();

  // Function to login user
  void authSignIn() async {
    // get the auth service or import the auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signInWithEmailandPassword(
          emailTextEditingController.text, passwordTextEditingController.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.android_outlined,
              size: 150,
            ),
            const Text(
              "Chat App",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            MyTextField(
                controller: emailTextEditingController,
                textFieldText: "Email",
                obsecureText: false),
            const SizedBox(
              height: 5,
            ),
            MyTextField(
              controller: passwordTextEditingController,
              textFieldText: "Password",
              obsecureText: true,
            ),
            const SizedBox(
              height: 5,
            ),
            SignInButton(
              signIn: "Sign In",
              onTap: authSignIn,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Not a member ?"),
                GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Register now",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
