// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';


class SignInButton extends StatelessWidget {
   SignInButton({super.key , required this.signIn , required this.onTap});
  final String signIn;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const  EdgeInsets.symmetric(horizontal: 100, vertical: 20),
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.blue,
        ),
        child: Text(signIn),
      ),
    );
  }
}