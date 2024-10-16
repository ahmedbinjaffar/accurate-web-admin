// import 'dart:async';

// import 'package:admin/screens/main/main_screen.dart';
// import 'package:admin/screens/signup/utils.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class VerifyEmailPage extends StatefulWidget {
//   const VerifyEmailPage({super.key});

//   @override
//   State<VerifyEmailPage> createState() => _VerifyEmailPageState();
// }

// class _VerifyEmailPageState extends State<VerifyEmailPage> {
//   bool isEmailVerified = false;
//   bool canResendEmail = false;
//   Timer? timer;

//   @override
//   void initState() {
//     super.initState();

//     isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
//     if (!isEmailVerified) {
//       sendVerificationEmail();

//       timer = Timer.periodic(
//           const Duration(seconds: 3), (_) => checkEmailVerified());
//     }
//   }

//   @override
//   void dispose() {
//     timer?.cancel();

//     super.dispose();
//   }

//   Future checkEmailVerified() async {
//     await FirebaseAuth.instance.currentUser!.reload();
//     setState(() {
//       isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
//     });

//     if (isEmailVerified) timer?.cancel();
//   }

//   Future sendVerificationEmail() async {
//     try {
//       final user = FirebaseAuth.instance.currentUser!;
//       await user.sendEmailVerification();

//       setState(() => canResendEmail = false);
//       await Future.delayed(const Duration(seconds: 5));
//       setState(() => canResendEmail = true);
//     } catch (e) {
//       ToastUtils.showToast(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) => isEmailVerified
//       ? const MainScreen()
//       : Scaffold(
//           appBar: AppBar(
//             //backgroundColor: AppClr.primaryColor,
//             title: const Text('Verify Email'),
//             centerTitle: true,
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'A verification email has been sent to you email',
//                   style: TextStyle(fontSize: 20),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(
//                   height: 24,
//                 ),
//                 ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       minimumSize: const Size.fromHeight(50),
//                       //primary: AppClr.primaryColor
//                     ),
//                     icon: Icon(
//                       Icons.email,
//                       size: 32,
//                       color: Colors.redAccent.shade700,
//                     ),
//                     label: const Text(
//                       'Reset Email',
//                       style: TextStyle(fontSize: 20, color: Colors.black87),
//                     ),
//                     onPressed: canResendEmail ? sendVerificationEmail : null),
//                 TextButton(
//                     style: ElevatedButton.styleFrom(
//                         minimumSize: const Size.fromHeight(50)),
//                     onPressed: () => FirebaseAuth.instance.signOut(),
//                     child: const Text(
//                       'Cancel',
//                       style: TextStyle(fontSize: 22, color: Colors.black87),
//                     ))
//               ],
//             ),
//           ),
//         );
// }
