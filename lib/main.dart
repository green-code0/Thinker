import 'package:thinker/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home.dart';

void main() {
  // staus bar color
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: bg,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Thinker',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Theme.of(context).platform == TargetPlatform.android ||
              Theme.of(context).platform == TargetPlatform.iOS
          ? const Home()
          : const Scaffold(
              backgroundColor: bgbtn,
              body: Center(
                child: Text(
                  "please open this game on your mobile phone",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
    );
  }
}
