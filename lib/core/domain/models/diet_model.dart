class Diet {
  final String title;

  Diet({required this.title});

  factory Diet.fromJson(Map<String, dynamic> json) {
    return Diet(
      title: json['title'],
    );
  }
}