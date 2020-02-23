class CartItem {
  final int id;
  final String name;
  final int quantity;
  final int price;

  CartItem(this.id, this.name, this.quantity, this.price);

  CartItem copyWith({int quantity}) {
    return CartItem(this.id, this.name, quantity, this.price);
  }
}
