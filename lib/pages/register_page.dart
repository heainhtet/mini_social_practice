import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/primary_button.dart';
import '../components/primary_textfield.dart';
import '../helper/helper_function.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPwController = TextEditingController();

  //register user method
  void registerUser() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );
    //make sure passwords match
    if (passwordController.text != confirmPwController.text) {
      //pop the loading circle
      Navigator.pop(context);
      //show error message
      displayMessageToUser("Password dosen't match!", context);
    } else {
      //try register the user
      try {
        //create the user
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );

        // create a user document and add to the firestore database
        createUserDocument(userCredential);
        //pop the loading circle
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        //pop the loading circle
        Navigator.pop(context);
        //show error message
        displayMessageToUser(e.code, context);
      }
    }
  }

  // create a user document and collet them in fire store
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
            'email': userCredential.user!.email,
            'username': userNameController.text,
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //LOGO
                Icon(
                  Icons.compass_calibration,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  size: 80,
                ),
                const SizedBox(height: 24),

                //APP NAME
                Text("T Y P E T A L K"),
                const SizedBox(height: 48),
                //USERNAME TEXT FIELD
                PrimaryTextfield(
                  hintText: "Username",
                  obscureText: false,
                  controller: userNameController,
                ),
                const SizedBox(height: 12),

                //EMAIL TEXT FIELD
                PrimaryTextfield(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController,
                ),
                const SizedBox(height: 12),
                //PASSWORD TEXT FIELD
                PrimaryTextfield(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController,
                ),
                //CONFIRM PASSWORD TEXT FIELD
                const SizedBox(height: 12),
                //PASSWORD TEXT FIELD
                PrimaryTextfield(
                  hintText: "Confirm Password",
                  obscureText: true,
                  controller: confirmPwController,
                ),
                SizedBox(height: 8),
                //FORGOT PASSWORD
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                PrimaryButton(text: "Sign Up", onTap: registerUser),
                //bottom: MediaQuery.of(context).viewInsets.bottom,
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login Here",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
