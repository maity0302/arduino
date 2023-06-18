import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'constants.dart';
import 'routes/screen_export.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({Key? key}) : super(key: key);

  @override
  _EntryPointState createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  final List<Widget> _pages = [
    DeviceScreen(),
    SpeedScreen(),
    DiscoverScreen(),
    FlameScreen(),
    SettingScreen(),
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }

  Widget svgIcon(String src, {Color? color}) {
    return SvgPicture.asset(
      src,
      height: 24,
      color: color ??
          Theme.of(context).iconTheme.color!.withOpacity(
                Theme.of(context).brightness == Brightness.dark ? 0.3 : 1,
              ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: const SizedBox(),
        leadingWidth: 0,
        centerTitle: false,
        title: SvgPicture.asset(
          "assets/svgs/logo.svg",
          height: 30,
          width: 100,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: svgIcon(
              "assets/svgs/notifications.svg",
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: svgIcon(
              "assets/svgs/plus-square.svg",
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
        ],
      ),
      body: PageTransitionSwitcher(
        duration: defaultDuration,
        transitionBuilder: (child, animation, secondAnimation) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondAnimation,
            child: child,
          );
        },
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: defaultPadding / 2),
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : const Color(0xFF101015),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index != _currentIndex) {
              setState(() {
                _currentIndex = index;
              });
            }
          },
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF101015),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.transparent,
          items: [
            BottomNavigationBarItem(
              icon: svgIcon("assets/svgs/power.svg"),
              activeIcon: svgIcon("assets/svgs/power.svg", color: primaryColor),
              label: "Thiết bị",
            ),
            BottomNavigationBarItem(
              icon: svgIcon("assets/svgs/activity.svg"),
              activeIcon:
                  svgIcon("assets/svgs/activity.svg", color: primaryColor),
              label: "Tốc độ mạng",
            ),
            BottomNavigationBarItem(
              icon: svgIcon("assets/svgs/layout.svg"),
              activeIcon:
                  svgIcon("assets/svgs/layout.svg", color: primaryColor),
              label: "Tiện ích",
            ),
            BottomNavigationBarItem(
              icon: svgIcon("assets/svgs/flame.svg"),
              activeIcon: svgIcon("assets/svgs/flame.svg", color: errorColor),
              label: "Cháy nhà",
            ),
            BottomNavigationBarItem(
              icon: svgIcon("assets/svgs/settings.svg"),
              activeIcon:
                  svgIcon("assets/svgs/settings.svg", color: primaryColor),
              label: "Cài đặt",
            ),
          ],
        ),
      ),
    );
  }
}
