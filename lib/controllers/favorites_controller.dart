import 'package:e_commerce/model/favorite_products_model.dart';
import 'package:e_commerce/service/sqflite_database/favoritedatabase_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../model/product_model.dart';
import 'home_controller.dart';

class FavoritesController extends GetxController {
  late FavoritesProductModel favModel ;
  FavoriteDBHelper fvdbHelper = FavoriteDBHelper();
  ValueNotifier<bool> loading = ValueNotifier(false);
  List<FavoritesProductModel> allFavoriteProducts = [];

  @override
  void onInit() {
    super.onInit();
    getFavoriteProducts();
  }

  getFavoriteProducts() async {
    loading.value = true;
    allFavoriteProducts = await fvdbHelper.getAllFavoriteProducts();
    loading.value = false;
    update();
  }

  addToFavorites(FavoritesProductModel model) async {
    for (int i = 0; i < allFavoriteProducts.length; i++) {
      if (allFavoriteProducts[i].productId == model.productId) {
        Get.snackbar(
          'Attention !!',
          'Item Exists in Favorites ',
          icon: Icon(Icons.person, color: Colors.blueAccent),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.cyanAccent,
          colorText: Colors.redAccent,
        );
        return;
      }
    }
    await fvdbHelper.insertToFavorites(model);
    Get.snackbar(
      'Done !',
      'Item Added To Favorites ',
      icon: Icon(Icons.person, color: Colors.blueAccent),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.cyanAccent,
      colorText: Colors.redAccent,
    );
    getFavoriteProducts();
    update();
  }

  removeFromFavorites(String productId) {
    fvdbHelper.deleteProductFromFavorites(productId);
    allFavoriteProducts
        .removeWhere((product) => product.productId == productId);
    Get.snackbar(
      'Done',
      'Item Removed From Favorites',
      icon: Icon(Icons.person, color: Colors.blueAccent),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.cyanAccent,
      colorText: Colors.redAccent,
    );
    update();
  }

  bool isFavorite(String proId) {
    for (int i = 0; i < allFavoriteProducts.length; i++) {
      if (allFavoriteProducts[i].productId == proId) {
        return true;
      }
    }
    return false;
  }

  onStarPressed(String prodId, context, FavoritesProductModel model) {
    if (isFavorite(prodId)) {
      removeFromFavorites(prodId);
      getFavoriteProducts();
    } else {
      addToFavorites(model);
      getFavoriteProducts();
    }
    update();
  }

  onActionPressed(int index, SlidableActions action, String id) {
    switch (action) {
      case SlidableActions.AddToFavorite:
        List<ProductModel> allProductsLIst =
            Get.find<HomeController>().ourAllProducts;
        //FavoritesProductModel favModel = FavoritesProductModel();
        var controller = Get.find<FavoritesController>();
        for (int i = 0; i < allProductsLIst.length; i++) {
          if (allProductsLIst[i].productId == id) {
            favModel = FavoritesProductModel(
              productId: allProductsLIst[i].productId,
              name: allProductsLIst[i].name,
              image: allProductsLIst[i].image,
              price: allProductsLIst[i].price,
              description: allProductsLIst[i].description,
            );
            break;
          }
        }
        controller.addToFavorites(favModel);

        break;
      // case SlidableActions.Delete:
      //   removeProductFromCart(id);
      //   allCartProducts.removeAt(index);
      //   getTotalPrice();
      //   Get.snackbar(
      //     'Done',
      //     'Item Removed From Cart',
      //   );
      //   break;
    }
    update();
  }
}
