class Ingredient {
  final String name;
  final double amount;
  final String unit;

  Ingredient({required this.name, required this.amount, required this.unit});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'],
      amount: json['amount'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
      'unit': unit,
    };
  }
}
