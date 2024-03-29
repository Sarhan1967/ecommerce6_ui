import 'package:e_commerce/model/cart_product_model.dart';
import 'package:e_commerce/view/search_screen.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/controllers/favorites_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants.dart';
import 'cart_screen.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoritesController>(
      init: FavoritesController(),
      builder: (favoritesController) => Scaffold(
        appBar: AppBar(
          title: Text('Favorites page'),
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
        body: favoritesController.loading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : favoritesController.allFavoriteProducts.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 250.0,
                          width: 200.0,
                          child: SvgPicture.asset('assets/images/no_Fav.svg')),
                      CustomText(
                        text: 'No Favorites Added yet ...',
                        size: 20.0,
                        alignment: Alignment.center,
                      ),
                    ],
                  )
                : Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Slidable(
                          startActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            extentRatio: 0.25,
                            children: [
                              GetBuilder<CartController>(
                                init: CartController(),
                                builder: (cartController) => Container(
                                  margin: EdgeInsets.symmetric(vertical: 10.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8.0),
                                      bottomRight: Radius.circular(8.0),
                                    ),
                                    child: SlidableAction(
                                      icon: Icons.add_shopping_cart,
                                      //     iconWidget:Icon(
                                      //       Icons.star,
                                      //       size: 35.0,
                                      //       color: Colors.white,
                                      //     ),
                                      backgroundColor: kPrimaryColor,
                                      foregroundColor: Colors.white,
                                      onPressed: (context) {
                                        cartController.addProduct(
                                          CartProductModel(
                                            image: favoritesController
                                                .allFavoriteProducts[index]
                                                .image,
                                            name: favoritesController
                                                .allFavoriteProducts[index]
                                                .name,
                                            price: favoritesController
                                                .allFavoriteProducts[index]
                                                .price,
                                            productId: favoritesController
                                                .allFavoriteProducts[index]
                                                .productId,
                                            quantity: 1,
                                          ),
                                          context,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            extentRatio: 0.25,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    bottomLeft: Radius.circular(8.0),
                                  ),
                                  child: SlidableAction(
                                    icon: Icons.delete_forever_outlined,
                                    backgroundColor:
                                        Color.fromRGBO(250, 68, 37, 1.0),
                                    onPressed: (context) {
                                      favoritesController.removeFromFavorites(
                                          favoritesController
                                              .allFavoriteProducts[index]
                                              .productId!);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          child: Container(
                            padding: EdgeInsets.all(15.0),
                            margin: EdgeInsets.symmetric(
                                horizontal: 13.0, vertical: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: Offset(3, 8),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 135.0,
                                  width: 120,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      favoritesController
                                          .allFavoriteProducts[index].image!,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 12.0, top: 10.0, bottom: 10.0),
                                    height: 132,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: favoritesController
                                              .allFavoriteProducts[index].name!,
                                          size: 18.0,
                                          weight: FontWeight.bold,
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Expanded(
                                          child: CustomText(
                                            text: favoritesController
                                                .allFavoriteProducts[index]
                                                .description!,
                                            fontColor: Colors.grey.shade600,
                                            size: 17.0,
                                            linesNum: 3,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7.0,
                                        ),
                                        CustomText(
                                          text:
                                              '\$${favoritesController.allFavoriteProducts[index].price}',
                                          fontColor: kPrimaryColor,
                                          size: 20.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: favoritesController.allFavoriteProducts.length,
                    ),
                  ),
      ),
    );
  }
}
