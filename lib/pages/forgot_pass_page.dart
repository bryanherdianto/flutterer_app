import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterer_app/components/my_button.dart';
import 'package:flutterer_app/components/my_textfield.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({
    super.key,
  });

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final resetEmailController = TextEditingController();

  @override
  void dispose() {
    resetEmailController.dispose();
    super.dispose();
  }

  void passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: resetEmailController.text.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        showErrorMessage("No user found for that email.");
      }
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error",
                style: TextStyle(fontWeight: FontWeight.bold)),
            content: Text(
              message,
              style: const TextStyle(fontSize: 18),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.purple[900],
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "OK",
                  style: TextStyle(fontSize: 18,
                    color: Colors.white
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.purple[900],
          title: const Text(
            'Forgot Password',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 150),
                  const Text(
                    'Enter your email to reset password!',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 40),
                  MyTextField(
                      controller: resetEmailController,
                      hintText: "Email",
                      prefixIcon: Icons.email,
                      obscureText: false),
                  const SizedBox(height: 30),
                  MyButton(onTap: passwordReset, message: "Reset Password")
                ],
              ),
            ),
          ),
        ));
  }
}
