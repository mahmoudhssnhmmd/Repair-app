import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repair/app%20utils/app_colors.dart';
import 'package:repair/app%20utils/app_consts.dart';
import 'package:repair/app%20utils/app_styles.dart';
import 'package:repair/app%20utils/app_utils.dart';
import 'package:repair/screens/authentication/authentication.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  int cityIndex = 0;
  final double spacing = 2;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Authentication _authentication = Authentication();
  late final TextEditingController emailController;
  late final TextEditingController nameController;
  late final TextEditingController phoneNumberController;
  late final TextEditingController streetController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    emailController = TextEditingController();
    nameController = TextEditingController();
    phoneNumberController = TextEditingController();
    streetController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    streetController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _authentication,
      child: BlocListener<Authentication, AuthResponse>(
        listener: (context, state) {
          final bool isLoading = state.authState == AuthenticationState.loading;
          if (isLoading) {
            showDialog(
              context: context,
              builder: (context) {
                return PopScope(
                  canPop: false,
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
            );
          } else if (state.authState == AuthenticationState.success) {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const Placeholder(),
              ),
            );
          }
          if (state.authState == AuthenticationState.error) {
            Navigator.of(context, rootNavigator: true).pop();
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
                    Text('SignUp', style: AppStyles.bold24black),
                    SizedBox(height: AppUtils.getHeight(5)),
                    TextFormField(
                      initialValue: emailController.text.isEmpty
                          ? null
                          : emailController.text,
                      decoration: InputDecoration(labelText: 'Email'),
                      onChanged: (v) => emailController.text = v,
                      validator: (v) {
                        if (v == null) {
                          return "email can't be empty";
                        } else if (!RegExp(
                          r"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*",
                        ).hasMatch(v)) {
                          return "incorrect email";
                        }
                        return null;
                      },
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
                    SizedBox(
                      height: AppUtils.getHeight(5),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                border: BoxBorder.all(
                                  width: 2.5,
                                  color: AppColors.mainColor
                                ),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(Radius.circular(16))
                              ),
                              child: DropdownButton<int>(
                                isExpanded: true,
                                dropdownColor: AppColors.backgroundTint,
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                value: cityIndex,
                                items: AppConsts.citiesAR
                                    .map((e) => DropdownMenuItem<int>(value: AppConsts.citiesAR.indexOf(e),child: Text(e)))
                                    .toList(),
                                onChanged: (e) => cityIndex = e ?? 0,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: AppUtils.getWidth(.5),
                          ),
                          Expanded(
                            flex: 5,
                            child: TextFormField(
                              decoration: InputDecoration(labelText: 'Street'),
                              onChanged: (v) => streetController.text = v,
                              validator: (v) => v == null || v.isEmpty
                                  ? "Address is required"
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppUtils.getHeight(spacing)),
                    TextFormField(
                      initialValue: passwordController.text,
                      decoration: InputDecoration(labelText: 'Password'),
                      onChanged: (v) => passwordController.text = v,
                      validator: (v) => v == null || v.length < 8
                          ? "password Should be at least 8 characters"
                          : null,
                    ),
                    SizedBox(height: AppUtils.getHeight(spacing)),
                    TextFormField(
                      initialValue: confirmPasswordController.text,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                      ),
                      onChanged: (v) => confirmPasswordController.text = v,
                      validator: (v) {
                        if (v == null || v.length < 8) {
                          return "password Should be at least 8 characters";
                        }
                        if (v != passwordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: AppUtils.getHeight(spacing)),
                    FilledButton(
                      onPressed: () {
                        debugPrint('\n\n\ncontroller${emailController.text}\n\n\n');
                        if (_formKey.currentState!.validate()) {
                          _authentication.signup(
                            emailController.text,
                            nameController.text,
                            int.parse(phoneNumberController.text),
                            AppConsts.citiesAR[cityIndex],
                            streetController.text,
                            passwordController.text,
                          );
                        }
                      },
                      child: Center(
                        child: Text(
                          'SignUp',
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
                      alignment: AlignmentGeometry.centerLeft,
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Have an Account? LogIn'),
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
