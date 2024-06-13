class IngredientWithUnits
{
  final String title;
  final List<String> units;

  IngredientWithUnits({required this.title, required this.units});

  factory IngredientWithUnits.fromJson(Map<String, dynamic> json) {
    return IngredientWithUnits(
      title: json['title'],
      units: json['units'],
    );
  }
}