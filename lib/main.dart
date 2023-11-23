import 'package:flutter/material.dart';
import 'package:test_ra_media/splash/spalsh_screen.dart';
import 'package:test_ra_media/utils/obfuscation_code.dart';

void main() {
  //Код для обфускации
  var user = User(22, 'music, technology', true);
  var engine = RecommendationEngine();
  var recommendations = engine.getRecommendations(user);
  print(recommendations);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test RaMedia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
    );
  }
}
