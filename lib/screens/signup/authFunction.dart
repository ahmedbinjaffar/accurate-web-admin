// ignore_for_file: file_names
// // ignore_for_file: deprecated_member_use, use_build_context_synchronously, file_names

// import 'package:admin/screens/main/main_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'firebaseFunction.dart';

// class AuthServices {
//   static Future<void> signupUser(String email, String password, String name,
//       String cnic, BuildContext context) async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);

//       await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
//       await FirebaseAuth.instance.currentUser!.updateEmail(email);

//       await FirestoreServices.saveUser(
//           name, email, userCredential.user!.uid, cnic);

//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('Registration Successful'),
//         backgroundColor: Colors.white70,
//       ));
//     } on FirebaseAuthException catch (e) {
//       String errorMessage;
//       if (e.code == 'weak-password') {
//         errorMessage = 'Password is too weak';
//       } else if (e.code == 'email-already-in-use') {
//         errorMessage = 'Email already exists';
//       } else {
//         errorMessage = 'Registration failed';
//       }
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(errorMessage),
//         backgroundColor: Colors.white70,
//       ));
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(e.toString()),
//         backgroundColor: Colors.white70,
//       ));
//     }
//   }

//   static Future<void> signinUser(
//       String email, String password, BuildContext context) async {
//     try {
//       await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);

//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text(
//           'You are Logged in',
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.white70,
//       ));
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => const MainScreen()),
//       );
//     } on FirebaseAuthException catch (e) {
//       String errorMessage;
//       if (e.code == 'user-not-found') {
//         errorMessage = 'No user found with this email';
//       } else if (e.code == 'wrong-password') {
//         errorMessage = 'Password did not match';
//       } else {
//         errorMessage = 'Sign in failed';
//       }
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(
//           errorMessage,
//           style: const TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.white70,
//       ));
//     }
//   }
// }
