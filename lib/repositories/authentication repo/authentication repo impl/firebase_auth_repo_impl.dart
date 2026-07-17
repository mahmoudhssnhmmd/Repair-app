import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:repair/models/user_account.dart';
import 'package:repair/repositories/authentication%20repo/authentication_repo.dart';

class FirebaseAuthRepoImpl extends AuthenticationRepo{
  @override
  Future<(String?, String?, UserAccount?)> logIn(String email, String password) async{
    String? uid;
    String? error;
    UserAccount? account;
    Map<String, dynamic>? userData;
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      uid = credential.user?.uid;
      //userData = await FirebaseFirestore.instance.collection('Users').doc(uid).get().then((value) => value.data());
    } on FirebaseAuthException catch (e) {
      error = e.toString();
    } catch (e) {
      error = e.toString();
    }
    if (userData != null) {
      account = UserAccount(
        name: userData['name'],
        email: userData['email'],
        phoneNumber: userData['phone'],
        city: userData['city'],
        street: userData['street']
      );
    }
    return (uid, error, account);
  }
  @override
  Future<(String?, String?, UserAccount?)> signUp(UserAccount account) async {
    //FirebaseFirestore firestore = FirebaseFirestore.instance;
    String? uid;
    String? error;
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: account.email,
        password: account.password!,
      );
      uid = credential.user?.uid;
      // await firestore.collection('Users').doc(uid).set({
      //   'name': account.name,
      //   'email': account.email,
      //   'phone': account.phoneNumber,
      //   'address': account.address,
      // });
    } on FirebaseAuthException catch (e) {
      error = e.toString();
    }catch (e) {
      error = e.toString();
    }
    return (uid, error, account);
  }
}