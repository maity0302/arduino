import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../constants.dart';
import '../../widgets/rounded_box_widget.dart';

class IntensityScreen extends StatefulWidget {
  const IntensityScreen({Key? key}) : super(key: key);

  @override
  State<IntensityScreen> createState() => _IntensityScreenState();
}

class _IntensityScreenState extends State<IntensityScreen> {
  final dref = FirebaseDatabase.instance.ref("intensity");

  late double heating = 0;
  late double led = 0;
  late double percent = 0;

  @override
  void initState() {
    super.initState();
    getItems();
  }

  Future<void> getItems() async {
    dref.onValue.listen((event) {
      final snapshot = event.snapshot;
      if (snapshot.exists) {
        setState(() {
          heating = snapshot.value == 0
              ? 0
              : snapshot.value == 100
                  ? 100
                  : snapshot.value as double;
          percent = heating / 100;
          led = percent * 30;
        });
      }
    });
  }

  Future<void> updateData(data) async {
    dref.set(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.indigo.shade50,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 32),
                    CircularPercentIndicator(
                      radius: 180,
                      lineWidth: 100,
                      percent: percent,
                      progressColor: primaryColor,
                      center: Text(
                        '${heating.round()}%',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Center(
                      child: Text(
                        'ĐIỀU CHỈNH',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RoundedBoxWidget(title: 'CHUNG', isActive: true),
                        RoundedBoxWidget(title: 'THÔNG SỐ'),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              'MỨC ĐỘ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Slider(
                            value: led,
                            onChanged: (newFan) {
                              setState(() {
                                led = newFan;
                                percent = newFan / 30.0;
                                heating = 0 + 100 * percent;
                                updateData(heating);
                              });
                            },
                            max: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'YẾU',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                Text(
                                  'MẠNH',
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
