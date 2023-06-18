import 'package:arduino/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FlameWidget extends StatefulWidget {
  const FlameWidget({Key? key}) : super(key: key);

  @override
  State<FlameWidget> createState() => _FlameWidgetState();
}

class _FlameWidgetState extends State<FlameWidget> {
  int value = 0;
  late final DatabaseReference databaseReference =
  FirebaseDatabase.instance.ref("fire");

  void initState() {
    super.initState();
    getItems();
  }

  void getItems() async {
    databaseReference.onValue.listen((event) {
      var snapshot = event.snapshot;
      if (snapshot.exists) {
        setState(() {
          if (!mounted) {
            super.dispose();
            return;
          };
          value = snapshot.value as int;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: value == 0 ? warningColor : primaryColor,
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
                        'assets/images/meow.png',
                        color: primaryColor,
                        scale: 4,
                      ),
                    ),
                  Center(
                      child:Text(
                        value == 0 ? 'CHÁY NHÀ BÀ CON LÁNG GIỀNG ƠI!' : 'Nhà vẫn OK',
                        style: TextStyle(
                          fontSize: 15,
                          color: whileColor80,
                          fontWeight: FontWeight.bold,
                        ),
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
