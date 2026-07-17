import 'package:flutter/cupertino.dart';
import 'package:repair/models/user_account.dart';
import 'package:repair/repositories/authentication%20repo/authentication_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthRepo extends AuthenticationRepo {
  @override
  Future<(String?, String?, UserAccount?)> logIn(
    String email,
    String password,
  ) async {
    String? uid;
    String? error;
    UserAccount? account;
    Map<String, dynamic>? userData;
    try {
      final credential = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      uid = credential.user?.id;
      userData = await Supabase.instance.client.rest
          .from('profiles')
          .select()
          .eq('id', uid!)
          .single();
      account = UserAccount(
        email: email,
        name: userData['full_name'],
        city: userData['city'],
        street: userData['street'],
        phoneNumber: userData['Phone_number'],
      );
    } catch (e) {
      error = e.toString();
    }
    return (uid, error, account);
  }

  @override
  Future<(String?, String?, UserAccount?)> signUp(UserAccount account) async {
    String? uid;
    String? error;
    try {
      debugPrint('\n\n\n${account.email}\n\n\n');
      final credential = await Supabase.instance.client.auth.signUp(
        email: account.email,
        password: account.password!,
      );
      uid = credential.user?.id;
      Supabase.instance.client.rest.from('profiles').insert({
        'full_name': account.name,
        'Phone_number': account.phoneNumber,
        'City': account.city,
        'Street': account.street,
      });
    } catch (e) {
      error = e.toString();
      debugPrint('\n\n\n${e.toString()}\n\n\n');
    }
    return (uid, error, account);
  }
}
