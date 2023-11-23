import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:test_ra_media/utils/utils.dart';

import '../play/screens/main_menu.dart';
import '../web/webview_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 5)); //Loading imitation

    bool hasInternet = await Services.checkConnection();
    bool ipAllowed = Services.checkIP("192.168.1.1");

    //additional checks
    bool isAgeGood = Services.checkUserAge(18);
    bool isCountryGood = Services.checkUserCountry("Ukraine");
    bool isAndroid = Services.checkUserOS();

    if (hasInternet) {
      _openScreen(WebViewScreen());
    } else {
      _openScreen(const MainMenu());
    }
  }

  void _openScreen(Widget screen) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Lottie.asset('assets/animations/loading.json')));
  }
}
