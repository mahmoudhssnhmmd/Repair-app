import 'package:flutter/material.dart';
import 'package:repair/app%20utils/app_utils.dart';

class ChooseAccountType extends StatelessWidget {
  const ChooseAccountType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilledButton(
            onPressed: null,
            child: Text('Customer'),
          ),
          SizedBox(height: AppUtils.getHeight( 1)),
          FilledButton(
            onPressed: null,
            child: Text('Worker'),
          ),
        ]
      ),
    );
  }
}