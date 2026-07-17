import 'package:repair/repositories/authentication%20repo/authentication%20repo%20impl/firebase_auth_repo_impl.dart';
import 'package:repair/repositories/authentication%20repo/authentication%20repo%20impl/supabase_auth_repo.dart';
import 'package:repair/repositories/authentication%20repo/authentication_repo.dart';

AuthenticationRepo injectAuthenticationRepo (){
  return SupabaseAuthRepo();
}