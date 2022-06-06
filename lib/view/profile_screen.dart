import 'package:e_commerce/constants.dart';
import 'package:e_commerce/view/profile/cards_view.dart';
import 'package:e_commerce/view/profile/edit_profile_view.dart';
import 'package:e_commerce/view/profile/notifications_view.dart';
import 'package:e_commerce/view/search_screen.dart';
import 'package:e_commerce/view/user_orders_screen.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view/widgets/reusable_list_tile.dart';
import 'package:e_commerce/controllers/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../controllers/favorites_controller.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text('Account'),
          backgroundColor: kPrimaryColor,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Get.to(()=>SearchScreen());
              },
            ),
            InkWell(
              onTap: () {
                Get.to(() => FavoritesScreen());
                //Get.to(() => FavouriteView());
              },
              child: Stack(
                children: [
                  GetBuilder<FavoritesController>(
                    init: Get.put(FavoritesController()),
                    builder: (controller) => Align(
                      child: Text(
                          controller.allFavoriteProducts.length > 0
                              ? controller.allFavoriteProducts.length
                              .toString()
                              : '0'),
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(Icons.favorite_border_outlined),
                      //alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
              // child: Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Icon(Icons.favorite_border_outlined),
              // ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => CartScreen());
              },
              child: Stack(
                children: [
                  GetBuilder<CartController>(
                    init: Get.put(CartController()),
                    builder: (controller) => Align(
                      child: Text(controller.cartProductModel.length > 0
                          ? controller.cartProductModel.length.toString()
                          : ''),
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  Align(
                    child: Icon(Icons.shopping_cart),
                    alignment: Alignment.center,
                  ),
                ],
              ),
            ),
          ],
        ),
        body: controller.loading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              child: Padding(
                                padding: EdgeInsets.all(3.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: controller.currentUser!.pic == null
                                      ? Image.asset(
                                          'assets/images/default.png',
                                        )
                                      : Image.network(controller.currentUser!.pic!),
                                ),
                              ),
                              radius: 50.0,
                              backgroundColor: kPrimaryColor.withOpacity(0.6),
                            ),
                            // Container(
                            //  padding: EdgeInsets.all(10.0),
                            //   height: 100.0,
                            //   width: 100.0,
                            //   decoration: BoxDecoration(
                            //     color: Colors.red,
                            //     borderRadius: BorderRadius.circular(50.0),
                            //     image: DecorationImage(
                            //       fit: BoxFit.fill,
                            //       image: controller.userData.pic == null
                            //           ? AssetImage(
                            //                'assets/images/default.png',
                            //             )
                            //           : NetworkImage(controller.userData.pic),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(width: 20.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: controller.currentUser!.name!,
                                  size: 30.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                CustomText(
                                  text: controller.currentUser!.email!,
                                  size: 20.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        ReusableTile(
                          tileTitle: 'Edit Profile',
                          iconImage: 'assets/icon_images/Icon_Edit-Profile.png',
                          onTilePressed: () {
                            Get.to(()=>EditProfileView());
                          },
                        ),
                        ReusableTile(
                          tileTitle: 'Shipping Address',
                          iconImage: 'assets/icon_images/Icon_Location.png',
                          onTilePressed: () {

                          },
                        ),
                        ReusableTile(
                          tileTitle: 'Favorites',
                          iconImage: 'assets/icon_images/icon_favorites.png',
                          onTilePressed: () {
                            Get.to(()=>FavoritesScreen());
                          },
                        ),
                        ReusableTile(
                          tileTitle: 'Order History',
                          iconImage: 'assets/icon_images/Icon_History.png',
                          onTilePressed: () {
                            Get.to(()=>UserOrdersScreen());
                          },
                        ),
                        ReusableTile(
                          tileTitle: 'Cards',
                          iconImage: 'assets/icon_images/Icon_Payment.png',
                          onTilePressed: () {
                            Get.to(CardsView());
                          },
                        ),
                        ReusableTile(
                          tileTitle: 'Notifications',
                          iconImage: 'assets/icon_images/Icon_Alert.png',
                          onTilePressed: () {
                            Get.to(NotificationsView());
                          },
                        ),
                        ReusableTile(
                          tileTitle: 'Log Out',
                          iconImage: 'assets/icon_images/Icon_Exit.png',
                          onTilePressed: () {
                            controller.logOut();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
