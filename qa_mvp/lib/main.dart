import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/splash_page.dart';

void main() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Author MVP',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: SplashPage(),
    );
  }
}
