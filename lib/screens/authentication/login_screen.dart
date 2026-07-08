import 'package:flutter/material.dart';
import 'package:repair/app%20utils/app_routs.dart';
import 'package:repair/app%20utils/app_styles.dart';
import 'package:repair/app%20utils/app_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final double spacing = 2;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('LogIn', style: AppStyles.bold24black),
                SizedBox(height: AppUtils.getHeight(5)),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  onChanged: (v) => emailController.text = v,
                  validator: (v) =>
                      v == null ||
                          v.isEmpty ||
                          RegExp(
                            r"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*",
                          ).hasMatch(v)
                      ? "incorrect email"
                      : null,
                ),
                SizedBox(height: AppUtils.getHeight(spacing)),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  onChanged: (v)=>passwordController.text = v,
                  validator: (v) => v == null || v.length < 8
                      ? "password Should be at least 8 characters"
                      : null,
                ),
                SizedBox(height: AppUtils.getHeight(spacing)),
                Align(
                  alignment: AlignmentGeometry.centerEnd,
                  child: TextButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AppRouts.forgetPassword,
                      arguments: emailController.text,
                    ),
                    child: Text('Forgot Password'),
                  ),
                ),
                SizedBox(height: AppUtils.getHeight(spacing)),
                FilledButton(
                  onPressed: () {},
                  child: Center(
                    child: Text(
                      'LogIn',
                      style: AppStyles.regular16DisabledText,
                    ),
                  ),
                ),
                SizedBox(height: AppUtils.getHeight(1)),
                FilledButton(
                  onPressed: () {},
                  child: Center(
                    child: Text(
                      'LogIn With Google',
                      style: AppStyles.regular16DisabledText,
                    ),
                  ),
                ),
                SizedBox(height: AppUtils.getHeight(spacing)),
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: TextButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AppRouts.signup,
                      arguments: <String, String>{
                        'email': emailController.text,
                        'password': passwordController.text,
                      },
                    ),
                    child: Text('Create an Account!'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
