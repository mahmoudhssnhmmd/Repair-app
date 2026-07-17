import 'package:repair/models/user_account.dart';

abstract class AuthenticationRepo {
  Future<(String? uid, String? error, UserAccount? account)> logIn(
    String email,
    String password,
  );
  Future<(String? uid, String? error, UserAccount? account)> signUp(
      UserAccount account
  );
}
