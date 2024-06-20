class MealType {
  final String title;

  MealType({required this.title});

  factory MealType.fromJson(Map<String, dynamic> json) {
    return MealType(
      title: json['title'],
    );
  }
}