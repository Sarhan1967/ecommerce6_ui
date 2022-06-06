import 'package:e_commerce/constants.dart';
import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/view/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'helper/binding.dart';
import 'view/control_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //SharedPreferences.getInstance();
  Get.put(CartController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: Binding(),
      home: Scaffold(
        body: SplashPage(),
      ),
      theme: ThemeData(
        fontFamily: 'Source Sans Pro',
        primarySwatch: kPrimaryColor,
      ),
    );
  }
}
