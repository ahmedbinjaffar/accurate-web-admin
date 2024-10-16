import 'package:admin/app_provider/app_provider.dart';
import 'package:admin/screens/signup/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin/constants/asset_image.dart';
import 'package:admin/constants/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadDataAndNavigate();
  }

  Future<void> _loadDataAndNavigate() async {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    await Future.wait([
      appProvider.callBackFunction(), // Load all necessary data
      Future.delayed(const Duration(seconds: 5)), // Wait for 5 seconds
    ]);

    if (!mounted) return; // Ensure the widget is still mounted

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginForm(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWeb = size.width > 800; // Use width threshold to distinguish web

    final logoHeight = isWeb ? size.height * 0.15 : size.height * 0.25;
    final logoWidth = isWeb ? size.width * 0.3 : size.width * 0.55;
    final spinkitSize = isWeb ? 20.0 : 40.0;
    final textSize = isWeb ? 12.0 : 15.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: logoHeight,
                width: logoWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage(AssetsImages.instance.logoImage),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.06),
              SpinKitSquareCircle(
                color: AppClr.primaryColor,
                size: spinkitSize,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              height: size.height * 0.06,
              width: size.width,
              child: Center(
                child: Text(
                  "Developed by Uhaa Tech",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: textSize,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
