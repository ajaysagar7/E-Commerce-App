class WishlistModel {
  final int id;
  final int productId;
  final String productName;
  final dynamic productPrice;
  final String productImage;
  final bool? isWishlisted;
  WishlistModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.isWishlisted,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
        id: json["id"],
        productId: json["productId"],
        productName: json["productName"],
        productPrice: json["productPrice"],
        isWishlisted: json["isWishlisted"],
        productImage: json["productImage"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "productId": productId,
      "productName": productName,
      "productPrice": productPrice.toInt(),
      "productImage": productImage,
      "isWishlisted": isWishlisted! ? 1 : 0
    };
  }
}
