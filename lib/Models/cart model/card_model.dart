class CartModel {
  final int? id;
  final String cartItemName;
  final String cartItemPrice;
  final String cartItemId;
  final String cartItemImage;
  final String cartItemQuantity;
  CartModel({
    this.id,
    required this.cartItemName,
    required this.cartItemPrice,
    required this.cartItemId,
    required this.cartItemImage,
    required this.cartItemQuantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
        id: json["id"],
        cartItemName: json["cartItemName"],
        cartItemPrice: json["cartItemPrice"],
        cartItemId: json["cartItemId"],
        cartItemImage: json["cartItemImage"],
        cartItemQuantity: json["cartItemQuantity"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "cartItemName": cartItemName,
      "cartItemPrice": cartItemPrice,
      "cartItemId": cartItemId,
      "cartItemImage": cartItemImage,
      "cartItemQuantity": cartItemQuantity,
    };
  }
}
