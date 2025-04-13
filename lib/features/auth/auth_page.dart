import 'package:autoswift/core/components/custom_button.dart';
import 'package:autoswift/core/components/custom_text.dart';
import 'package:autoswift/core/components/custom_text_field.dart';
import 'package:autoswift/core/components/snack.dart';
import 'package:autoswift/features/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLogin = true;

  Future<void> _authenticate() async {
    try {
      if (isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        Snack().success(context, "User Logged in Successfully");
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        Snack().success(context, "User Created in Successfully");
      }

      Navigator.push(context,MaterialPageRoute(builder: (c) => HomePageView()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(backgroundColor: Colors.grey.shade300, toolbarHeight: 0),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 80),
            Icon(CupertinoIcons.lock,size: 100,),
            SizedBox(height: 30),
            CustomTextField(
              controller: _emailController,
              hint: 'Email',
              type: TextInputType.text,
            ),
            SizedBox(height: 10),
            CustomTextField(
              controller: _passwordController,
              hint: 'Password',
              type: TextInputType.number,
            ),
            SizedBox(height: 20),
            CustomButton(
              onTap: _authenticate,
              width: double.infinity,
              height: 35,
              color: Colors.black87,
              radius: 8,
              child: Center(child: CustomText(text:  isLogin ? "Login" : "Register",color: Colors.white,fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () => setState(() => isLogin = !isLogin),
              child: CustomText(text: isLogin ? "Create an account" : "Already have an account? Login",color: Colors.black,),
            ),
            Spacer(),
            CustomText(text: "powered by rich sonic 2025"),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

