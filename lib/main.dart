import 'package:flutter/material.dart';
//firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//SupaBase
import 'package:repair/api/supabase/supabase_const.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//app utils
import 'package:repair/app utils/app_routs.dart';
import 'package:repair/theme/light_theme.dart';
//screens
import 'package:repair/screens/authentication/login_screen.dart';
import 'package:repair/screens/authentication/signup_screen.dart';
import 'package:repair/screens/authentication/forget_password_screen.dart';
//packages

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Supabase.initialize(
    url: SupabaseConst.supabaseUrl,
    publishableKey: SupabaseConst.supabasePublishableKey,
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        AppRouts.login: (context) => const LoginScreen(),
        AppRouts.signup: (context) => const SignupScreen(),
        AppRouts.forgetPassword: (context) => const ForgetPasswordScreen(),
      },
      theme: lightTheme,
      initialRoute: AppRouts.login,
    );
  }
}
