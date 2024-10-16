// // ignore_for_file: camel_case_types, library_private_types_in_public_api, use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class Forgot_Password extends StatefulWidget {
//   const Forgot_Password({Key? key}) : super(key: key);

//   @override
//   _Forgot_PasswordState createState() => _Forgot_PasswordState();
// }

// class _Forgot_PasswordState extends State<Forgot_Password> {
//   final _formKey = GlobalKey<FormState>();
//   final emailController = TextEditingController();
//   final auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.bottomCenter,
//             end: Alignment.topCenter,
//             colors: [
//               Colors.redAccent.shade700, // Darker shade at the bottom
//               Colors.redAccent.shade100, // Lighter shade at the top
//             ],
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(
//                       Icons.arrow_back,
//                       color: Colors.black87,
//                     ),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   const Text(
//                     'Reset Password',
//                     style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Center(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         'images/th (1).png',
//                         width: 200,
//                         height: 200,
//                       ),
//                       const SizedBox(height: 20),
//                       Form(
//                         key: _formKey,
//                         child: Container(
//                           padding: const EdgeInsets.all(14),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               TextFormField(
//                                 controller: emailController,
//                                 decoration: InputDecoration(
//                                   hintText: 'Enter Email',
//                                   filled: true,
//                                   fillColor: Colors.white,
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(20.0),
//                                     borderSide: BorderSide.none,
//                                   ),
//                                   errorStyle:
//                                       const TextStyle(color: Colors.white),
//                                 ),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Please enter email';
//                                   }
//                                   if (!RegExp(
//                                           r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-z]+$")
//                                       .hasMatch(value)) {
//                                     return 'Please enter a valid email';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                               const SizedBox(height: 30),
//                               SizedBox(
//                                 height: 55,
//                                 width: double.infinity,
//                                 child: ElevatedButton(
//                                   onPressed: () async {
//                                     if (_formKey.currentState!.validate()) {
//                                       try {
//                                         await auth.sendPasswordResetEmail(
//                                             email: emailController.text
//                                                 .toString());
//                                         ScaffoldMessenger.of(context)
//                                             .showSnackBar(
//                                           const SnackBar(
//                                             content: Text(
//                                               'Password reset email sent successfully',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.black87),
//                                             ),
//                                             backgroundColor: Colors.white70,
//                                           ),
//                                         );
//                                       } catch (error) {
//                                         ScaffoldMessenger.of(context)
//                                             .showSnackBar(
//                                           SnackBar(
//                                             content: Text(
//                                               'Failed to send password reset email: $error',
//                                               style: const TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.redAccent),
//                                             ),
//                                             backgroundColor: Colors.white,
//                                           ),
//                                         );
//                                       }
//                                     }
//                                   },
//                                   child: const Text(
//                                     'Reset Password',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                         color: Colors.redAccent),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 200,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
