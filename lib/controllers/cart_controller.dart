import 'package:e_commerce/model/cart_product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';
import '../service/sqflite_database/cartDatabase_Helper.dart';

class CartController extends GetxController {
  //CartDatbaseHelper dbHelper = CartDatbaseHelper();
  var cartdbHelper = CartDatbaseHelper.db;

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  List<CartProductModel> _cartProductModel = [];

  List<CartProductModel> get cartProductModel => _cartProductModel;

  double get totalPrice => _totalPrice;
  double _totalPrice = 0.0;

  //late FavoritesProductModel favModel ;
  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   getCartList();
  //   super.onInit();
  // }

  CartController() {
    getAllProduct();
  }

  getAllProduct() async {
    loading.value = true;
    _cartProductModel = (await cartdbHelper.getAllProduct())!;
    print(_cartProductModel.length);
    loading.value = false;
    getTotalPrice();
    update();
  }

  getTotalPrice() {
    _totalPrice = 0;
    for (int i = 0; i < _cartProductModel.length; i++) {
      _totalPrice += (double.parse(_cartProductModel[i].price!) *
          _cartProductModel[i].quantity!);
      print(_totalPrice);
    update();
    }
  }

  //addToCart
  addProduct(CartProductModel cartProductModel, context) async {
    for (int i = 0; i < _cartProductModel.length; i++) {
      if (_cartProductModel[i].productId == cartProductModel.productId) {
        // Toast.show('Item already exists in cart', textStyle: context);
        Get.snackbar(
          'Attention !!',
          'Item already exists in cart ',          backgroundColor: Colors.cyanAccent,
          //icon: Icon(Icons.person, color: Colors.blueAccent),
          snackPosition: SnackPosition.BOTTOM,
          //backgroundColor: Colors.red,
          colorText: Colors.redAccent,
          duration: Duration(seconds: 5),
          // behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),

        );
        return;
      }
    }

    var cartdbHelper = CartDatbaseHelper.db;
    await cartdbHelper.insert(cartProductModel);
    _cartProductModel.add(cartProductModel);
    _totalPrice += (double.parse(cartProductModel.price!) *
        cartProductModel.quantity!);
    // Toast.show(
    //   'Item Added To Your Cart',
    //   textStyle: context,
    // );
    Get.snackbar(
      'Done !',
      'Item Added To  Your Cart ',
      icon: Icon(Icons.person, color: Colors.blueAccent),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.cyanAccent,
      colorText: Colors.redAccent,
    );
    update();
  }

  increaseQuantity(int productIndex) async {
    //allCartProducts[productIndex].quantity++;
    _cartProductModel[productIndex].quantity=(_cartProductModel[productIndex].quantity!+1);
    _totalPrice += (double.parse(_cartProductModel[productIndex].price!));
    await cartdbHelper.update(_cartProductModel[productIndex]);
    update();
  }

  decreaseQuantity(int productIndex) async {
    if (_cartProductModel[productIndex].quantity! > 1) {
      //allCartProducts[productIndex].quantity--;
      _cartProductModel[productIndex].quantity=(_cartProductModel[productIndex].quantity!-1);
      _totalPrice -= (double.parse(_cartProductModel[productIndex].price!));
      await cartdbHelper.update(_cartProductModel[productIndex]);
    }
    update();
  }

  clearCart() async {
    await cartdbHelper.deleteAllCartProducts();
    _cartProductModel.clear();
    update();
  }

  removeProductFromCart(String id) async {
    await cartdbHelper.deleteProductFromCart(id);
    Get.snackbar(
      'Done',
      'Item Removed From Your Cart',
      icon: Icon(Icons.person, color: Colors.blueAccent),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.cyanAccent,
      colorText: Colors.redAccent,
    );
    update();
  }

  onActionPressed(int index, SlidableActions action, String id) {
    switch (action) {
    //   case SlidableActions.AddToFavorite:
    //     List<ProductModel> allProductsLIst =
    //         Get.find<HomeController>().ourAllProducts;
    //     break;
        //FavoritesProductModel favModel = FavoritesProductModel();
        // var controller = Get.find<FavoritesController>();
        // for (int i = 0; i < allProductsLIst.length; i++) {
        //   if (allProductsLIst[i].productId == id) {
        //     favModel = FavoritesProductModel(
        //       productId: allProductsLIst[i].productId,
        //       name: allProductsLIst[i].name,
        //       image: allProductsLIst[i].image,
        //       price: allProductsLIst[i].price,
        //       description: allProductsLIst[i].description,
        //     );
        //     break;
        //   }
        // }
        // controller.addToFavorites(favModel);
        //
        // break;
      case SlidableActions.Delete:
        removeProductFromCart(id);
        _cartProductModel.removeAt(index);
        getTotalPrice();
        Get.snackbar(
          'Done',
          'Item Removed From Cart',
          icon: Icon(Icons.person, color: Colors.blueAccent),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.cyanAccent,
          colorText: Colors.redAccent,
        );
        break;
    }
    update();
  }
}

/*var controller = Get.put(FavoritesController());
            print(
                'lemgthhhhhhhhhhhh  ${Get.put(FavoritesController()).allFavoriteProducts.length}');

            print(
                'lemgthhhhhhhhhhhh  ${FavoritesController().allFavoriteProducts.length}');
            for (int x = 0;
                x < FavoritesController().allFavoriteProducts.length;
                x++) {
              if (FavoritesController().allFavoriteProducts[x].productId ==
                  id) {
                Get.snackbar(
                    'Attention !!', 'Item already Exists in favorites');
                return;
              }
            }*/
