import 'package:e_commerce/view/auth/login_screen.dart';
import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/controllers/bottom_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class ControlView extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthController>().user == null)
          ? LoginScreen()
          : GetBuilder<BottomNavController>(
              init: BottomNavController(),
              builder: (navController) {
                return Scaffold(
                  body: navController.currentBodyScreen,
                  bottomNavigationBar: getBottomNavBar(),
                );
              },
            );
    });
  }

  GetBuilder<BottomNavController> getBottomNavBar() {
    return GetBuilder<BottomNavController>(
      init: BottomNavController(),
      builder: (homController) {
        return BottomNavigationBar(
          elevation: 5.0,
          selectedItemColor: Colors.redAccent,
          backgroundColor: kPrimaryColor,
          currentIndex: homController.bottomNavBarCurrentIndex,
          onTap: (index) {
            print(index);
            homController.onBottomNavBarTabbed(index);
          },
          items: [
            BottomNavigationBarItem(
              label: '',
              backgroundColor: kPrimaryColor,
              icon: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                // child: Image.asset('assets/images/Icon_Explore.png'),
                child: Icon(Icons.home, color: Colors.red, size: 30),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                // child: CustomText(
                //   text: 'Explore',
                //   size: 15.0,
                //   alignment: Alignment.topCenter,
                //   weight: FontWeight.bold,
                // ),
                child: Text(
                  "Explore",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              tooltip: 'Explore',
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                // child: Image.asset('assets/images/Icon_Cart.png'),
                child: Icon(Icons.shopping_cart_outlined,
                    color: Colors.red, size: 30),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                // child: CustomText(
                //   text: 'Cart',
                //   size: 15.0,
                //   weight: FontWeight.bold,
                //   alignment: Alignment.topCenter,
                // ),
                child: Text(
                  "Cart",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              tooltip: 'Cart',
            ),
            BottomNavigationBarItem(
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    "Favorite",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                label: '',
                icon: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  // child: Image.asset('assets/images/heart.png',fit: BoxFit.contain,width: 20,),
                  child:
                      Icon(Icons.favorite_border, color: Colors.red, size: 30),
                )),
            BottomNavigationBarItem(
              label: '',
              icon: Padding(
                padding: const EdgeInsets.only(top: 5),
                // child: Image.asset('assets/images/Icon_User.png'),
                child: Icon(Icons.person, color: Colors.red, size: 30),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(top: 5),
                // child: CustomText(
                //   text: 'Profile',
                //   size: 20.0,
                //   weight: FontWeight.bold,
                //   // alignment: Alignment.topCenter,
                // ),
                child: Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              tooltip: 'Profile',
            ),
          ],
        );
      },
    );
  }
}
