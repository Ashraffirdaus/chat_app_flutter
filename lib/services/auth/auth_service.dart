import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  // instance of auth
  final FirebaseAuth _firebauseAuth = FirebaseAuth.instance;

// instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// sign user in
  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    try {
      //sign in
      UserCredential userCredential =
          await _firebauseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // add a new document for the user in users collection if it doesnt already exist
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': userCredential.user!.email,
      }, SetOptions(merge: true));

      return userCredential;
    }
//catch any errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

// create a new user
  Future<UserCredential> signUpWithEmailandPassword(
      String email, password, String text) async {
    try {
      UserCredential userCredential = await _firebauseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      // after we have a user , we need to create a document for the user in the users collection
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': userCredential.user!.email
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

//sign user out
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
