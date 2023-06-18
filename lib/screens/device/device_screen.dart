import 'package:arduino/routes/screen_export.dart';
import 'package:flutter/material.dart';

import '../../widgets/card_devices_widget.dart';

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/iot-banner.png',
                        scale: 1.2,
                      ),
                    ),

                    const Text(
                      'CHỨC NĂNG CHÍNH',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CardDevicesWidget(
                          onTap: () {
                            print('Đèn');
                          },
                          onTapDown: () {
                            Navigator.pushNamed(context, intensityScreenRoute);
                            print('OK');
                          },
                          ref: 'light',
                          icon: 'assets/svgs/lamp.svg',
                          selectedIcon: 'assets/svgs/lamp-light.svg',
                          title: 'BÓNG ĐÈN',
                        ),
                        CardDevicesWidget(
                          onTap: () {
                            print('Điều hoà');
                          },
                          ref: 'dieuHoa',
                          icon: 'assets/svgs/air-conditioner-off.svg',
                          selectedIcon: 'assets/svgs/air-conditioner-on.svg',
                          title: 'ĐIỀU HOÀ',
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CardDevicesWidget(
                          onTap: () {
                            print('máy giặt ');
                          },
                          ref: 'mayGiat',
                          icon: 'assets/svgs/lamp.svg',
                          selectedIcon: 'assets/svgs/lamp-light.svg',
                          title: 'MÁY GIẶT',
                        ),
                        CardDevicesWidget(
                          onTap: () {
                            print('fan');
                          },
                          ref: 'fan',
                          icon: 'assets/svgs/air-conditioner-off.svg',
                          selectedIcon: 'assets/svgs/air-conditioner-on.svg',
                          title: 'QUẠT TRỜI',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
