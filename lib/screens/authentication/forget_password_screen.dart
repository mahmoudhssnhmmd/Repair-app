import 'package:flutter/material.dart';
import 'package:repair/app%20utils/app_styles.dart';


class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      body: Center(
        child: Text(
          args ?? 'null',
          style: AppStyles.bold24black.copyWith(color: Colors.redAccent),
        ),
      ),
    );
  }
}
