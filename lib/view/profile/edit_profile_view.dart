import 'package:e_commerce/controllers/profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/selectImageController.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class EditProfileView extends StatefulWidget {
  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    String _loginMethod =
        FirebaseAuth.instance.currentUser!.providerData[0].providerId;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 130,
            child: Padding(
              padding: EdgeInsets.only(bottom: 24, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                  CustomText(
                    text: 'Edit Profile',
                    size: 20,
                    alignment: Alignment.bottomCenter,
                  ),
                  Container(
                    width: 24,
                  ),
                ],
              ),
            ),
          ),
          GetBuilder<SelectImageController>(
            init: SelectImageController(),
            builder: (controller) => Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.only(right: 16, left: 16, bottom: 24),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: _loginMethod == 'google.com' ||
                              _loginMethod == 'facebook.com'
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  _loginMethod == 'google.com'
                                      ? 'assets/images/icons/google.png'
                                      : 'assets/images/icons/facebook.png',
                                  fit: BoxFit.cover,
                                  height: 40,
                                  width: 40,
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                CustomText(
                                  text: _loginMethod == 'google.com'
                                      ? 'You\'re logged in using Google account!'
                                      : 'You\'re logged in using Facebook account!',
                                  size: 16,
                                  alignment: Alignment.center,
                                ),
                              ],
                            )
                          : Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 60,
                                        backgroundImage: AssetImage(
                                            'assets/images/profile_pic.png'),
                                        foregroundImage: controller.imageFile !=
                                                null
                                            ? FileImage(controller.imageFile!)
                                            : null,
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.dialog(
                                            AlertDialog(
                                              title: CustomText(
                                                text: 'Choose option',
                                                size: 20,
                                                fontColor: Colors.blue,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Divider(
                                                    height: 1,
                                                  ),
                                                  ListTile(
                                                    onTap: () async {
                                                      try {
                                                        await controller
                                                            .cameraImage();
                                                        Get.back();
                                                      } catch (error) {
                                                        Get.back();
                                                      }
                                                    },
                                                    title: CustomText(
                                                      text: 'Camera',
                                                    ),
                                                    leading: Icon(
                                                      Icons.camera,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 1,
                                                  ),
                                                  ListTile(
                                                    onTap: () async {
                                                      try {
                                                        await controller
                                                            .galleryImage();
                                                        Get.back();
                                                      } catch (error) {
                                                        Get.back();
                                                      }
                                                    },
                                                    title: CustomText(
                                                      text: 'Gallery',
                                                    ),
                                                    leading: Icon(
                                                      Icons.account_box,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text('Select Image'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 38,
                                  ),
                                  CustomTextFormField(
                                    titleText: 'Name',
                                    hint: Get.find<ProfileController>()
                                        .currentUser!
                                        .name!,
                                    initialValue: Get.find<ProfileController>()
                                        .currentUser!
                                        .name!,
                                    validate: (value) {
                                      if (value!.isEmpty || value.length < 4)
                                        return 'Please enter valid name.';
                                    },
                                    onSave: (value) {
                                      Get.find<ProfileController>().name = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 38,
                                  ),
                                  Column(
                                    children: [
                                      CustomTextFormField(
                                        titleText: 'Email',
                                        hint: Get.find<ProfileController>()
                                            .currentUser!
                                            .email!,
                                        initialValue:
                                            Get.find<ProfileController>()
                                                .currentUser!
                                                .email!,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validate: (value) {
                                          if (value!.isEmpty)
                                            return 'Please enter valid email address.';
                                        },
                                        onSave: (value) {
                                          Get.find<ProfileController>().email =
                                              value;
                                        },
                                      ),
                                      SizedBox(
                                        height: 38,
                                      ),
                                      CustomTextFormField(
                                        titleText: 'Password',
                                        hint: '',
                                        obscureText: true,
                                        validate: (value) {
                                          if (value!.isEmpty ||
                                              value.length < 6)
                                            return 'Please enter valid password with at least 6 characters.';
                                        },
                                        onSave: (value) {
                                          Get.find<ProfileController>()
                                              .password = value;
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  _isLoading
                                      ? CircularProgressIndicator()
                                      : CustomButton(
                                          'SUBMIT',
                                          () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                _isLoading = true;
                                              });
                                              try {
                                                await controller
                                                    .uploadImageToFirebase();
                                                Get.find<ProfileController>()
                                                    .picUrl = controller.pic;
                                              } catch (e) {
                                                Get.find<ProfileController>()
                                                        .picUrl =
                                                    Get.find<ProfileController>()
                                                        .currentUser
                                                        ?.pic;
                                              }
                                              _formKey.currentState!.save();
                                              await Get.find<ProfileController>()
                                                  .updateCurrentUser();
                                              setState(() {
                                                _isLoading = false;
                                              });
                                            }
                                          },
                                        ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
