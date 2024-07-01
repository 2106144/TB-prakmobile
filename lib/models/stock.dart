class Stock{
  String id;
  String name;
  double qty;
  String attr;
  double weight;
  


  Stock({
    required this.id,
    required this.name,
    required this.qty,
    required this.attr,
    required this.weight,
    
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: json['id'],
      name: json['name'],
      qty: json['qty'],
      attr: json['attr'],
      weight: json['weight'],
    );
  }
}
