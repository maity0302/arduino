import 'package:flutter/material.dart';
import 'package:arduino/entry_point.dart';

import 'screen_export.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case logInScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );

    case deviceScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const DeviceScreen(),
      );

    case speedScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SpeedScreen(),
      );

    case discoverScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const DiscoverScreen(),
      );

    case flameScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const FlameScreen(),
      );

    case settingScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SettingScreen(),
      );

    case intensityScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const IntensityScreen(),
      );

    case entryPointScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const EntryPoint(),
      );

    // default:
    //   return MaterialPageRoute(
    //     // Make a screen for undefine
    //     builder: (context) => const LoginScreen(),
    //   );
    default:
      return MaterialPageRoute(
        // Make a screen for undefine
        builder: (context) => const EntryPoint(),
      );
  }
}
