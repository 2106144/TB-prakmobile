class Product {
  String id;
  String name;
  int price;
  int qty;
  String attr;
  int weight;
  
  


  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.qty,
    required this.attr,
    required this.weight,
    
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      qty: json['qty'],
      attr: json['attr'],
      weight: json['weight'],
    );
  }
}
