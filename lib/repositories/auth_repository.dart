import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_base/database/secure_storage_helper.dart';
import 'package:flutter_base/network/api_client.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/entities/token_entity.dart';

abstract class AuthRepository {
  Future<TokenEntity?> getToken();

  Future<void> saveToken(TokenEntity token);

  Future<void> removeToken();

  Future<TokenEntity?> signIn(String username, String password);

  Future<User?> signInWithGoogle();

  Future<void> signOutGoogle();

  Future<User?> signInWithEmail(String email, String password);

  Future signOutWithEmail();

  Future registerEmail(String email, String password);

}

class AuthRepositoryImpl extends AuthRepository {
  ApiClient apiClient;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  AuthRepositoryImpl({required this.apiClient});

  @override
  Future<TokenEntity?> getToken() async {
    return await SecureStorageHelper.instance.getToken();
  }

  @override
  Future<void> removeToken() async {
    return SecureStorageHelper.instance.removeToken();
  }

  @override
  Future<void> saveToken(TokenEntity token) async {
    return SecureStorageHelper.instance.saveToken(token);
  }

  @override
  Future<TokenEntity?> signIn(String username, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    return TokenEntity(
        accessToken: 'app_access_token', refreshToken: 'app_refresh_token');
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
        print(user!.providerData);
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
    return user;
  }

  @override
  Future<void> signOutGoogle() async {
    try {
      await auth.signOut();
      await GoogleSignIn().signOut();
    } catch(error) {
      print("$error sign out Google error!");
    }
  }

  @override
  Future registerEmail(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  @override
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      user = credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        /// Todo
      } else if (e.code == 'wrong-password') {
        /// Todo
      }
    }
    return user;
  }

  @override
  Future signOutWithEmail() async {
    try {
      await auth.signOut();
    } catch(error) {
      print("$error signout Email error");
    }
  }

}
