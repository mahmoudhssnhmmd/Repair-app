import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:repair/app%20utils/app_styles.dart';
import 'package:repair/app%20utils/app_utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final double spacing = 2;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController nameController;
  late final TextEditingController phoneNumberController;
  late final TextEditingController addressController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    emailController = TextEditingController();
    nameController = TextEditingController();
    phoneNumberController = TextEditingController();
    addressController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String,String> args = ModalRoute.of(context)!.settings.arguments as Map<String,String>;
    emailController.text = args['email']??'';
    passwordController.text = args['password']??'';
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('SignUp', style: AppStyles.bold24black),
                SizedBox(height: AppUtils.getHeight(5)),
                TextFormField(
                  initialValue: emailController.text.isEmpty?null:emailController.text,
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
                  decoration: InputDecoration(labelText: 'Name'),
                  onChanged: (v) => nameController.text = v,
                  validator: (v) =>
                      v == null || v.isEmpty ? "Add Name" : null,
                ),
                SizedBox(height: AppUtils.getHeight(spacing)),
                TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  onChanged: (v) => phoneNumberController.text = v,
                  validator: (v) => v == null || v.length < 11
                      ? "invalid Phone Number"
                      : null,
                ),
                SizedBox(height: AppUtils.getHeight(spacing)),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Address'),
                  onChanged: (v) => addressController.text = v,
                  validator: (v) =>
                      v == null || v.isEmpty || RegExp(r"\w").hasMatch(v)
                      ? "incorrect email"
                      : null,
                ),
                SizedBox(height: AppUtils.getHeight(spacing)),
                TextFormField(
                  initialValue: passwordController.text.isEmpty?null:passwordController.text,
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: (v) => v == null || v.length < 8
                      ? "password Should be at least 8 characters"
                      : null,
                ),
                SizedBox(height: AppUtils.getHeight(spacing)),
                TextFormField(
                  initialValue: passwordController.text.isEmpty?null:passwordController.text,
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  onChanged: (v)=>confirmPasswordController.text = v,
                  validator: (v) => v == null || v.length < 8
                      ? "password Should be at least 8 characters"
                      : null,
                ),
                SizedBox(height: AppUtils.getHeight(spacing)),
                FilledButton(
                  onPressed: () {},
                  child: Center(
                    child: Text(
                      'SignUp',
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
                    onPressed: ()=>Navigator.pop(context),
                    child: Text('Have an Account? LogIn'),
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
