class CartModel {
  String? name;
  String? price;
  String? quantity;
  String? description;
  String? category;
  String? imageUrl;
  String? id;
  String? stock;
  CartModel(
      {this.name,
      this.price,
      this.quantity,
      this.description,
      this.category,
      this.imageUrl,
      this.id,
      this.stock});

  CartModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    description = json['description'];
    category = json['category'];
    imageUrl = json['imageUrl'];
    id = json['id'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    data['quantity'] = quantity;
    data['description'] = description;
    data['category'] = category;
    data['imageUrl'] = imageUrl;
    data['id'] = id;
    data['stock'] = stock;
    return data;
  }
}
