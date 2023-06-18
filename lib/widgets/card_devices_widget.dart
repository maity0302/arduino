import 'dart:async';
import 'package:arduino/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardDevicesWidget extends StatefulWidget {
  const CardDevicesWidget({
    Key? key,
    required this.ref,
    required this.title,
    required this.icon,
    required this.selectedIcon,
    this.onTap,
    this.onTapDown,
  }) : super(key: key);

  final String title;
  final String icon;
  final String selectedIcon;
  final VoidCallback? onTap;
  final VoidCallback? onTapDown;

  final String ref;

  @override
  _CardDevicesWidgetState createState() => _CardDevicesWidgetState();
}

class _CardDevicesWidgetState extends State<CardDevicesWidget> {
  late final DatabaseReference databaseReference =
  FirebaseDatabase.instance.ref(widget.ref);
  Timer? _timer;

  bool isLoading = true;
  bool value = false;

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the Timer if exists
    super.dispose();
  }

  @override
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
            _timer?.cancel(); // Cancel the Timer if exists
            super.dispose();
            return;
          }
          isLoading = false;
          value = snapshot.value as bool;
        });
      }
    });
  }

  void updateData(data) async {
    databaseReference.set(data);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        if(!value) return;
        _timer = Timer(Duration(seconds: 1), () {
          widget.onTapDown?.call();
        });
      },
      onTapCancel: () {
        _timer?.cancel();
      },
      child: GestureDetector(
        onTap: () {
          setState(() {
            updateData(!value);
          });
          widget.onTap?.call();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 36,
          ),
          width: 156,
          decoration: BoxDecoration(
            color: value ? primaryColor : blackColor10.withOpacity(0.5),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              SvgPicture.asset(
                value ? widget.selectedIcon : widget.icon,
                height: 50,
                color: value ? Colors.white : primaryColor,
              ),
              const SizedBox(height: 10),
              Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: value ? Colors.white : primaryColor,
                ),
              ),
              Switch(
                value: value,
                onChanged: (newVal) {
                  setState(() {
                    updateData(newVal);
                  });
                },
                activeColor: Colors.white,
                inactiveThumbColor: primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
