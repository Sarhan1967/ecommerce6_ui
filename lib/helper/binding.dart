import 'package:e_commerce/service/local_storage_controller.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/bottom_nav_controller.dart';
import '../controllers/cart_controller.dart';
import '../controllers/checkout_controller.dart';
import '../controllers/favorites_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/order_controller.dart';
import '../controllers/profile_controller.dart';
import '../controllers/search_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => BottomNavController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => LocalStorageController());
    Get.lazyPut(() => CheckOutController());
    Get.lazyPut(() => SearchController());
    Get.lazyPut(() => OrderController());
    Get.lazyPut(() => FavoritesController());
  }
}
