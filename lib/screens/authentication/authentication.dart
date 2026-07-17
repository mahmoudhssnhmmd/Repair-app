import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:repair/di.dart';
import 'package:repair/models/user_account.dart';
import 'package:repair/repositories/authentication%20repo/authentication_repo.dart';

enum AuthenticationState { initial, loading, success, error }

class AuthResponse {
  final AuthenticationState authState;
  final String? uid;
  final String? error;
  AuthResponse({
    this.authState = AuthenticationState.initial,
    this.uid,
    this.error,
  });
}

class Authentication extends Cubit<AuthResponse> {
  Authentication()
    : super(AuthResponse(authState: AuthenticationState.initial));
  AuthenticationRepo authRepo = injectAuthenticationRepo();

  void login(String email, String password) async {
    emit(AuthResponse(authState: AuthenticationState.loading));
    final (uid, error, account) = await authRepo.logIn(email, password);
    if (error != null) {
      emit(AuthResponse(authState: AuthenticationState.error, error: error));
      return;
    }
    emit(AuthResponse(authState: AuthenticationState.success, uid: uid));
  }

  void loginWithGoogle() {
    //todo
  }
  void signup(
    String email,
    String name,
    int phoneNumber,
    String city,
    String street,
    String password,
  ) async {
    emit(AuthResponse(authState: AuthenticationState.loading));
    debugPrint('\n\n\nbloc $email\n\n\n');
    final (uid, error, account) = await authRepo.signUp(
      UserAccount(
        email: email,
        name: name,
        city: city,
        street: street,
        phoneNumber: phoneNumber,
        password: password,
      ),
    );
    if (error != null) {
      emit(AuthResponse(authState: AuthenticationState.error, error: error));
      return;
    }
    emit(AuthResponse(authState: AuthenticationState.success, uid: uid));
  }

  void forgetPassword(String email) {
    //todo
  }
}
