import 'package:admin/app_provider/app_provider.dart';
import 'package:admin/constants/colors.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/screens/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCIa8CPFqXQ6rriYP_jlQcToSdQsw1XS7c",
      authDomain: "accurate-scale-app-web.firebaseapp.com",
      projectId: "accurate-scale-app-web",
      storageBucket: "accurate-scale-app-web.appspot.com",
      messagingSenderId: "478213709699",
      appId: "1:478213709699:web:a2e0543b7173b2f33f20b6",
      measurementId: "G-2QY7169RKE",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MenuControllers(),
        ),
        ChangeNotifierProvider(
          create: (_) => AppProvider()..callBackFunction(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Admin Panel',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
