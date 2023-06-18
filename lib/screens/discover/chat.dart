import 'package:arduino/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  double nhietDoValue = 0;
  int doAmValue = 0;
  late final DatabaseReference nhietDo = FirebaseDatabase.instance.ref("nhietDo");
  late final DatabaseReference doAm = FirebaseDatabase.instance.ref("doAm");

  void initState() {
    super.initState();
    getItems();
  }

  void getItems() async {
    nhietDo.onValue.listen((event) {
      var snapshot = event.snapshot;
      if (snapshot.exists) {
        setState(() {
          if (!mounted) {
            super.dispose();
            return;
          };
          nhietDoValue = snapshot.value as double;
        });
      }
    });
    doAm.onValue.listen((event) {
      var snapshot = event.snapshot;
      if (snapshot.exists) {
        setState(() {
          if (!mounted) {
            super.dispose();
            return;
          };
          doAmValue = snapshot.value as int;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: paiChartSelectionDatas,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: defaultPadding),
                Text(
                  "$nhietDoValue \u2103",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    height: 0.5,
                  ),
                ),
                Text("$doAmValue độ ẩm"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


List<PieChartSectionData> paiChartSelectionDatas = [
  PieChartSectionData(
    color: primaryColor,
    value: 25,
    showTitle: false,
    radius: 25,
  ),
  PieChartSectionData(
    color: Color(0xFF26E5FF),
    value: 20,
    showTitle: false,
    radius: 22,
  ),
  PieChartSectionData(
    color: Color(0xFFFFCF26),
    value: 10,
    showTitle: false,
    radius: 19,
  ),
  PieChartSectionData(
    color: Color(0xFFEE2727),
    value: 15,
    showTitle: false,
    radius: 16,
  ),
  PieChartSectionData(
    color: primaryColor.withOpacity(0.1),
    value: 25,
    showTitle: false,
    radius: 13,
  ),
];
