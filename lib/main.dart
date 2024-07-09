import 'package:aigeminichatbot/api%20key/api_key.dart';
import 'package:aigeminichatbot/pages/onboard%20screen/ui/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:google_fonts/google_fonts.dart';

void main() async {
  Gemini.init(apiKey: apiKey);
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  initialization()async{
    await Future.delayed(
    const Duration(milliseconds: 1500),
  );
  FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    initialization();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.robotoSerifTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OnBoardingScreen(),
    );
  }
}
