import 'package:equatable/equatable.dart';
import 'package:recipes/core/domain/models/recipe_preview_model.dart';

enum RecipeSearchStatus { initial, success, failure, loading }

class RecipeSearchState extends Equatable {
  const RecipeSearchState({
    this.status = RecipeSearchStatus.initial,
    this.recipes = const <RecipePreview>[],
    this.hasReachedMax = false,
  });

  final RecipeSearchStatus status;
  final List<RecipePreview> recipes;
  final bool hasReachedMax;

  RecipeSearchState copyWith({
    RecipeSearchStatus? status,
    List<RecipePreview>? recipes,
    bool? hasReachedMax,
  }) {
    return RecipeSearchState(
      status: status ?? this.status,
      recipes: recipes ?? this.recipes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''RecipeSearchState { status: $status, hasReachedMax: $hasReachedMax, recipes: ${recipes.length} }''';
  }

  @override
  List<Object> get props => [status, recipes, hasReachedMax];
}
