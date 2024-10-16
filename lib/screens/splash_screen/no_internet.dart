// import 'package:admin/constants/asset_image.dart';
// import 'package:flutter/material.dart';

// class NoInternetScreen extends StatefulWidget {
//   const NoInternetScreen({super.key});

//   @override
//   State<NoInternetScreen> createState() => _NoInternetScreenState();
// }

// class _NoInternetScreenState extends State<NoInternetScreen> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//         body: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Center(
//           child: Image.asset(
//             AssetsImages.instance.nointernetimage,
//             height: 100,
//           ),
//         ),
//         SizedBox(
//           height: size.height / 100 * 2,
//         ),
//         const Text(
//           "Internet Connectivity is not Available\nPlease connect with internet for \neasy browsing.",
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     ));
//   }
// }
