import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repair/app%20utils/app_colors.dart';
import 'package:repair/app%20utils/app_routs.dart';
import 'package:repair/app%20utils/app_styles.dart';
import 'package:repair/app%20utils/app_utils.dart';
import 'package:repair/screens/authentication/authentication.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final double spacing = 2;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Authentication _authentication = Authentication();
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
    return BlocProvider.value(
      value:_authentication,
      child: BlocListener<Authentication, AuthResponse>(
        listener: (context, state) {
          final bool loading = state.authState == AuthenticationState.loading;
          if (loading && !_isLoading) {
            _isLoading = true;
            showDialog(
              context: context,
              builder: (context) {
                return PopScope(
                  canPop: false,
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
            );
          } else {
            if(_isLoading){
              Navigator.of(context, rootNavigator: true).pop();
              _isLoading = false;
            }
            if (state.authState == AuthenticationState.success) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const Placeholder(),
                ),
              );
            }
            if (state.authState == AuthenticationState.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.error,
                  margin: EdgeInsets.all(10),
                  behavior: SnackBarBehavior.floating,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
                  ),
                  content: Text(
                    state.error ?? 'Something went wrong',
                    style: AppStyles.regular16MainTextColor,
                  ),
                ),
              );
            }
          }
        },
        child: Scaffold(
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
                              !RegExp(
                                r"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*",
                              ).hasMatch(v)
                          ? "incorrect email"
                          : null,
                    ),
                    SizedBox(height: AppUtils.getHeight(spacing)),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      onChanged: (v) => passwordController.text = v,
                      validator: (v) => v == null || v.length < 8
                          ? "password Should be at least 8 characters"
                          : null,
                    ),
                    SizedBox(height: AppUtils.getHeight(spacing)),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          AppRouts.forgetPassword,
                          arguments: emailController.text,
                        ),
                        child: Text('Forgot Password',style: AppStyles.regular16AccentColor,),
                      ),
                    ),
                    SizedBox(height: AppUtils.getHeight(spacing)),
                    FilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _authentication.login(
                            emailController.text,
                            passwordController.text,
                          );
                        }
                      },
                      child: Center(
                        child: Text(
                          'LogIn',
                          style: AppStyles.regular16MainTextColor,
                        ),
                      ),
                    ),
                    SizedBox(height: AppUtils.getHeight(1)),
                    FilledButton(
                      onPressed: () {},
                      child: Center(
                        child: Text(
                          'LogIn With Google',
                          style: AppStyles.regular16MainTextColor,
                        ),
                      ),
                    ),
                    SizedBox(height: AppUtils.getHeight(spacing)),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          AppRouts.signup,
                          arguments: <String, String>{
                            'email': emailController.text,
                            'password': passwordController.text,
                          },
                        ),
                        child: Text('Create an Account!',style: AppStyles.regular16AccentColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
