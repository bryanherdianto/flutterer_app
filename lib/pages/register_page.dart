import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterer_app/components/my_button.dart';
import 'package:flutterer_app/components/my_textfield.dart';
import 'package:flutterer_app/components/square_tile.dart';
import 'package:flutterer_app/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onPressed;

  const RegisterPage({super.key, required this.onPressed});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

  void signUserUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      if (confirmPassController.text == passController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userController.text,
          password: passController.text,
        );
      } else {
        if (mounted) {
          Navigator.pop(context);
        }
        showErrorMessage("Passwords do not match.");
        return;
      }
      if (mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        Navigator.pop(context);
      }
      if (e.code == 'user-not-found') {
        showErrorMessage("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        showErrorMessage("Wrong password provided for that user.");
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
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20), // Useful for giving space

                  Icon(
                    Icons.flutter_dash,
                    size: 130,
                    color: Colors.purple[900],
                  ),

                  const SizedBox(height: 30),

                  const Text('Let\'s get started with Flutterer!',
                      style: TextStyle(fontSize: 25)),

                  const SizedBox(height: 20),

                  MyTextField(
                      controller: userController,
                      hintText: "Username",
                      prefixIcon: Icons.person,
                      obscureText: false),

                  const SizedBox(height: 20),

                  MyTextField(
                      controller: passController,
                      hintText: "Password",
                      prefixIcon: Icons.lock,
                      obscureText: true),

                  const SizedBox(height: 20),

                  MyTextField(
                      controller: confirmPassController,
                      hintText: "Confirm Password",
                      prefixIcon: Icons.lock,
                      obscureText: true),

                  const SizedBox(height: 25),
                  MyButton(onTap: signUserUp, message: "Sign Up"),

                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey[600],
                            thickness: 0.5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "OR",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey[600],
                            thickness: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                  SquareTile(
                      imagePath: "lib/images/icons8-google-144.png",
                      tileText: "Sign Up with Google",
                      onTap: () => AuthService().signInWithGoogle()),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?",
                          style: TextStyle(color: Colors.grey[600])),
                      TextButton(
                        onPressed: widget.onPressed,
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.purple[900], fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
