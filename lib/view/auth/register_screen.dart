import 'package:e_commerce/view/widgets/custom_auth_button.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import '../../controllers/auth_controller.dart';
import 'login_screen.dart';

class RegisterScreen extends GetWidget<AuthController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_outlined,
            color: kPrimaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10,),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 15,
                          offset: Offset(4, 8)),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Register Account",
                        style: TextStyle(
                          fontSize: 30,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // const Text(
                      //   "Complete your details or continue \nwith social media",
                      //   textAlign: TextAlign.center,
                      //   size: 30.0,
                      // ),

                      // CustomText(
                      //   alignment: Alignment.center,
                      //   text: 'Complete your details or continue \nwith social media',
                      //   fontColor: Colors.deepPurple,
                      //   linesNum:2,
                      //   size: 18.0,
                      // ),
                      Text(
                        'Complete your details or continue \nwith social media',
                        textAlign: TextAlign.center,
                        //style: Theme.of(context).textTheme.caption,
                        style: TextStyle(color: Colors.deepPurple,fontSize: 20,),

                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      CustomTextFormField(
                        titleText: 'Name',
                        hint: 'Mohammed Sarhan',
                        onSave: (value) {
                          controller.name = value!;
                        },
                        validate: (value) {
                          if (value == '') {
                            return 'Please enter your name';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      CustomTextFormField(
                        titleText: 'Email',
                        hint: 'Amr@gamail.com',
                        onSave: (value) {
                          controller.email = value!;
                        },
                        validate: (value) {
                          if (value == '') {
                            return 'Please enter valid Email';
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value!)) {
                            return 'Please Enter a valid Email';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      CustomTextFormField(
                        titleText: 'Password',
                        hint: '*******',
                        hidePassword: true,
                        onSave: (value) {
                          controller.password = value!;
                        },
                        validate: (value) {
                          if (value == '') {
                            return 'Please enter Password';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      CustomTextFormField(
                        titleText: 'Confirm Password',
                        hint: '*******',
                        hidePassword: true,
                        onSave: (value) {
                          controller.confirmedPassword = value!;
                        },
                        validate: (value) {
                          if (value == '') {
                            return 'Re_enter your password';
                          }
                          if (controller.password != controller.confirmedPassword) {
                            return ' Password does n\'t match';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      CustomButton(
                        btnText: 'Sign UP',
                        onPress: () {
                          _formKey.currentState!.save();
                          if (_formKey.currentState!.validate()) {
                            controller.signUpWithEmailPassword();
                            Get.off(() => LoginScreen());
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      Text(
                        'By continuing your confirm that you agree \nwith our Term and Condition',
                        textAlign: TextAlign.center,
                        //style: Theme.of(context).textTheme.caption,
                        style: TextStyle(color: Colors.deepPurple,fontSize: 20,),

                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
