import 'package:e_commerce/model/product_model.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../details_screen.dart';
import 'package:get/get.dart';

import 'custom_text.dart';

class CustomProductViewer extends StatelessWidget {
  final ProductModel determinedProduct;
  CustomProductViewer({required this.determinedProduct});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(DetailsScreen(
          model: determinedProduct,
        ));
      },
      child: Container(
        height: 300.0,
        width: 175.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Container(
                height: 150,
                width: 175,
                child: Image.network(
                  determinedProduct.image!,
                  //  fit: BoxFit.cover,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            CustomText(
              text: determinedProduct.name!,
              size: 18.0,
              weight: FontWeight.bold,
            ),
            SizedBox(
              height: 7.0,
            ),
            CustomText(
              text: determinedProduct.brand.toString(),
              //.substring(0,30)+' ....',
              fontColor: Colors.grey,
              size: 16.0,
            ),
            SizedBox(
              height: 7.0,
            ),
            CustomText(
              text: '\$ ${determinedProduct.price.toString()} ',
              fontColor: kPrimaryColor,
              size: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
