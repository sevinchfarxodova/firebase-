import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_signs/core/routes/route_names.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  static final auth = FirebaseAuth.instance;

  static Future<User?> signInUser({required String email,required String password}) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    final User? firebaseUser = auth.currentUser;
    return firebaseUser;
  }

  static Future<User?> signUpUser(
  { required String email,required String password}) async {
    var authResult = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = authResult.user;
    return user;
  }

  static void logOut(BuildContext context){
    auth.signOut();
    Navigator.pushNamed(context, RouteNames.signInPage);
  }

  static bool isSignedIn(){
final User? fireBaseuser  =auth.currentUser;
return fireBaseuser !=null;
  }
}
