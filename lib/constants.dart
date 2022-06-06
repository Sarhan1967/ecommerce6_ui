import 'package:flutter/material.dart';

final String cartTableName = 'cartProductsTable';
final String cartProductName = 'name';
final String cartProductImage = 'image';
final String cartProductQuantity = 'quantity';
final String cartProductPrice = 'price';
final String cartProductId = 'productId';

final String favTableName = 'favoriteProductsTable';
final String favProductName = 'name';
final String favProductImage = 'image';
final String favProductPrice = 'price';
final String favProductId = 'productId';
final String favProductDescription = 'description';

//const kPrimaryColor = Color.fromRGBO(0, 197, 105, 1.0);
const MaterialColor kPrimaryColor = const MaterialColor(
  0xFF00C569,
  //0xFFFF7643,
  const <int, Color>{
    50: const Color(0xFF00C569),
    100: const Color(0xFF00C569),
    200: const Color(0xFF00C569),
    300: const Color(0xFF00C569),
    400: const Color(0xFF00C569),
    500: const Color(0xFF00C569),
    600: const Color(0xFF00C569),
    700: const Color(0xFF00C569),
    800: const Color(0xFF00C569),
    900: const Color(0xFF00C569),
  },
);

const kTileHeight = 50.0;
const inProgressColor = Colors.black87;
const todoColor = Color(0xffd1d2d7);

enum Pages {
  DeliveryTime,
  AddAddress,
  Summary,
}

enum Delivery { StandardDelivery, NextDayDelivery, NominatedDelivery }

enum SlidableActions { Delete, AddToFavorite }

//SizeConfig-----------------------
class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size------------
// double getHRatio(double inputHeight) {
//   double screenHeight = SizeConfig.screenHeight;
//   // 812 is the layout height that designer use
//   return (inputHeight / 812.0) * screenHeight;
// }

// Get the proportionate width as per screen size
// double getWRatio(double inputWidth) {
//   double screenWidth = SizeConfig.screenWidth;
//   // 375 is the layout width that designer use
//   return (inputWidth / 375.0) * screenWidth;
// }

