abstract class RecipeState {}

class RecipeInitialState extends RecipeState {}

class RecipeLoadingState extends RecipeState {}

class RecipeLoadedState extends RecipeState {
  final List<Map<String, dynamic>> recipes;

  RecipeLoadedState({required this.recipes});
}

class RecipeErrorState extends RecipeState {
  final String error;

  RecipeErrorState({required this.error});
}
