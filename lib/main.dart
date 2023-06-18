import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:arduino/routes/route_constants.dart';
import 'package:arduino/routes/router.dart' as router;
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'theme/light_theme.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ARDUINO IOT',
      theme: lightTheme(context),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
      // initialRoute: onbordingScreenRoute,
    );
  }
}
