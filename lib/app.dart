import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_system/scenes/home_scene.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solar System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: const HomeScene(),
    );
  }
}
