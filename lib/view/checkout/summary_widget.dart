import 'package:e_commerce/constants.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/controllers/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/checkout_controller.dart';

class Summary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: Get.find(),
      builder: (controller) => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 170.0,
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                //color: Colors.red,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 120.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 120.0,
                              height: 110.0,
                              child: Image.network(
                                controller.cartProductModel[index].image!,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            RichText(
                              text: TextSpan(
                                text: controller.cartProductModel[index].name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.0,
                                ),
                              ),
                              // maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(height: 8.0),
                            CustomText(
                              text: '\$' +
                                  controller.cartProductModel[index].price
                                      .toString(),
                              fontColor: kPrimaryColor,
                              size: 18.0,
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 15.0,
                      );
                    },
                    itemCount: controller.cartProductModel.length),
              ),
              SizedBox(
                height: 50.0,
                child: Divider(
                  height: 1.5,
                  color: Colors.grey,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    CustomText(
                      text: 'Shipping Address',
                      size: 20.0,
                      weight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GetBuilder<CheckOutController>(
                          init: Get.find(),
                          builder: (controller) => Expanded(
                            child: CustomText(
                              text:
                                  '${controller.street1 + ',' + controller.street2 + ',' + controller.phone + ',' + controller.city + ',' + controller.state + ',' + controller.country}',
                              size: 18.0,
                              linesHeight: 1.4,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.check_circle,
                          color: kPrimaryColor,
                          size: 27.0,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    CustomText(
                      text: 'Change',
                      fontColor: kPrimaryColor,
                      size: 16.0,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 45.0,
                child: Divider(
                  height: 1.5,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
