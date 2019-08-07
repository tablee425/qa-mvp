import 'package:flutter/material.dart';
import 'quotes_page.dart';
import 'package:qa_mvp/utils/app_shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final globalKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    new Future.delayed(const Duration(seconds: 3), _onFinishSplash);
    return new Scaffold(
      key: globalKey,
      body: _splashContainer(),
    );
  }

  Widget _splashContainer() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: new Text('Empty Splash'),
      ),
    );
  }

  void _onFinishSplash() async {
    List<int> _favorites = await AppSharedPreferences.getFavorites();
    if (this.mounted) {
      setState(() {
        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => new QuotesPage(favorites: _favorites)));
      });
    }
  }
}