import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../constants.dart';
import 'control_view.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 10), () {
      Get.offAll(()=> ControlView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_rounded,
              color: kPrimaryColor,
              size: 80,
            ),
            Text(
              'SHOPEE',
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 20,
                letterSpacing: 4.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            Container(
              color: Colors.transparent,
              width: 120.0,
              height: 120.0,
              child: SpinKitFadingCircle(
                itemBuilder: (_, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven ? Colors.red : Colors.green,
                    ),
                  );
                },
                size: 120.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
