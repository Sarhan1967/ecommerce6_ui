import 'package:e_commerce/helper/extension.dart';
import 'package:flutter/cupertino.dart';

class ProductModel {
  String? name, image, description, size, price, brand, productId, category;
  Color? color;

  ProductModel({
    required this.name,
    required this.image,
    required this.description,
    required this.size,
    required this.color,
    required this.price,
    required this.brand,
    required this.productId,
    required this.category,
  });

  ProductModel.fromJson(Map<dynamic, dynamic> products) {
    if (products == null) {
      return;
    }
    name = products['name'];
    image = products['image'];
    description = products['description'];
    size = products['size'];
    color = HexColor.fromHex(products['color']);
    price = products['price'];
    brand = products['brand'];
    productId = products['productId'];
    category = products['category'];
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'size': size,
      'color': color,
      'price': price,
      'brand': brand,
      'productId': productId,
      'category': category,
    };
  }
}
