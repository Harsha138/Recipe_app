import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'recipe_event.dart';
import 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc() : super(RecipeInitialState());

  @override
  Stream<RecipeState> mapEventToState(RecipeEvent event) async* {
    if (event is FetchRecipesEvent) {
      yield RecipeLoadingState();

      try {
        final recipes = await _fetchRecipes();
        yield RecipeLoadedState(recipes: recipes);
      } catch (e) {
        yield RecipeErrorState(error: 'Failed to fetch recipes.');
      }
    }
  }

  Future<List<Map<String, dynamic>>> _fetchRecipes() async {
    final response = await http.get(Uri.parse(
        'https://api.edamam.com/search?q=chicken&app_id=cd11cda2&app_key=54365a0301250fceec91a54de777247d&health=alcohol-free'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['hits']
          .map((dynamic hit) => (hit as Map<String, dynamic>)['recipe']));
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
