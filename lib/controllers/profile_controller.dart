import 'package:e_commerce/model/user_model.dart';
import 'package:e_commerce/service/local_storage_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../service/firestore_user.dart';

class ProfileController extends GetxController {
  LocalStorageController localStorageController = LocalStorageController();
  late UserModel _currentUser;
  UserModel? get currentUser => _currentUser;
  String? name, email, password, picUrl;
  ValueNotifier<bool> loading = ValueNotifier(false);
  @override
  void onInit() {
    getLocallyStoredData();
    super.onInit();
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    //await FacebookLogin().logOut();
    localStorageController.deleteUserCachedData();
    update();
  }

  getLocallyStoredData() async {
    loading.value = true;
    _currentUser = await localStorageController.retrieveDate();
    loading.value = false;
    update();
  }


  updateCurrentUser() async {
    try {
      UserModel _userModel = UserModel(
        userId: currentUser!.userId,
        email: email!,
        name: name!,
        pic: picUrl == null ?_currentUser.pic : picUrl!,
      );
      await FirebaseAuth.instance.currentUser!.updateEmail(email!);
      await FirebaseAuth.instance.currentUser!.updatePassword(password!);
      FireStoreUser().addUserToUsersCollection(_userModel);
      await localStorageController.setUserData(_userModel);
      getLocallyStoredData();
      Get.back();
    } catch (error) {
      String errorMessage =
      error.toString().substring(error.toString().indexOf(' ') + 1);
      Get.snackbar(
        'Failed to update..',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

}
