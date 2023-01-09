import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_base/repositories/firestore_repository.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_base/network/api_client.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../ui/commons/app_snackbar.dart';

abstract class AuthRepository {

  Future<User?> signInWithGoogle();

  Future<void> signOutGoogle();

  Future<User?> signInWithEmail(String email, String password);

  Future signOutWithEmail();

  Future registerEmail(String email, String passwordConfirm);

  Future<User?> getUser();
}

class AuthRepositoryImpl extends AuthRepository {
  ApiClient apiClient;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  AuthRepositoryImpl({required this.apiClient});

  Future<String> getBirthday(GoogleSignInAccount googleUser) async {
    final headers = await googleUser.authHeaders;

    final r = await http.get(
        Uri.parse(
            "https://people.googleapis.com/v1/people/me?personFields=birthday&key="),
        headers: {"Authorization": headers["Authorization"] ?? ""});
    final response = jsonDecode(r.body);
    String birthDay = '${response["birthdays"][1]["date"]["day"]}/${response["birthdays"][1]["date"]["month"]}/${response["birthdays"][1]["date"]["year"]}';
    return birthDay;
  }

  @override
  Future<User?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        "https://www.googleapis.com/auth/user.birthday.read",
        "https://www.googleapis.com/auth/userinfo.profile",
      ],
    );

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        // var birthDay = await getBirthday(googleUser);
        // print(birthDay);
        return user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        /// Todo
        print(e);
      }
    }
    return null;
  }

  @override
  Future<void> signOutGoogle() async {
    try {
      await auth.signOut();
      await GoogleSignIn().signOut();
    } catch (error) {
      print("$error sign out Google error!");
    }
  }

  @override
  Future registerEmail(String email, String passwordConfirm) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: passwordConfirm,
      );
      user = credential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AppSnackbar.showError(message: 'The password provided is too weak.');
        return null;
      } else if (e.code == 'email-already-in-use') {
        AppSnackbar.showError(message: 'The account already exists for that email.');
        return null;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      user = credential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AppSnackbar.showError(message: 'User not found');
      } else if (e.code == 'wrong-password') {
        AppSnackbar.showError(message: 'Wrong password');
      }
    }
    return null;
  }

  @override
  Future signOutWithEmail() async {
    try {
      await auth.signOut();
    } catch (error) {
      print("$error signout Email error");
    }
  }

  @override
  Future<User?> getUser() async {
    return auth.currentUser;
  }
}
