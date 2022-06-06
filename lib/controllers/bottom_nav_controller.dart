import 'package:e_commerce/view/cart_screen.dart';
import 'package:e_commerce/view/home_screen.dart';
import 'package:e_commerce/view/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../view/favorites_screen.dart';

class BottomNavController extends GetxController {
  int bottomNavBarCurrentIndex = 0;
  Widget currentBodyScreen = HomeScreen();

  void onBottomNavBarTabbed(int index) {
    bottomNavBarCurrentIndex = index;
    switch(index){
      case 0 :{
        currentBodyScreen = HomeScreen();
        break;
      }
      case 1 :{
        currentBodyScreen = CartScreen();
        break;
      }
      case 2 :{
        currentBodyScreen = FavoritesScreen();
        break;
      }
      case 3 :{
        currentBodyScreen = ProfileScreen();
        break;
      }
    }
    update();
  }
}
