import 'package:flutter/material.dart';
import 'package:login_page_auth/widget_page.dart/login_textfield.dart';
import 'package:login_page_auth/widget_page.dart/sign_in_butto.dart';
import 'package:provider/provider.dart';

import '../services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.onTap});
  final Function()? onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

  void authRegister() async {
    if (passwordTextEditingController.text !=
        confirmPasswordTextEditingController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Password do not Match")));
    }
    //get the authService or import the authSerive
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailandPassword(
          emailTextEditingController.text,
          passwordTextEditingController.text,
          confirmPasswordTextEditingController.text);
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
            MyTextField(
              controller: confirmPasswordTextEditingController,
              textFieldText: "Confirm Password",
              obsecureText: true,
            ),
            const SizedBox(
              height: 10,
            ),
            SignInButton(
              signIn: "Register",
              onTap: authRegister,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Alread a member? "),
                GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Login now",
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
