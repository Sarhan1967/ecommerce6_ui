class FavoritesProductModel {
  String? name, image, price, productId, description;

  FavoritesProductModel(
      {required this.name, required this.image, required this.price, required this.description, required this.productId});

  FavoritesProductModel.fromJson(Map<dynamic, dynamic> data) {
    if (data == null) {
      return;
    }
    name = data['name'];
    image = data['image'];
    price = data['price'];
    description = data['description'];
    productId = data['productId'];
  }
  toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'description': description,
      'productId': productId
    };
  }
}
