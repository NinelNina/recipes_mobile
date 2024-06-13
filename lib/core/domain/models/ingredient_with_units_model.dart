class IngredientWithUnits
{
  final String title;
  final List<String> units;

  IngredientWithUnits({required this.title, required this.units});

  String getTitle(){
    return title;
  }

  List<String> getUnits(){
    return units;
  }
}