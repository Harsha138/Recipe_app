import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'recipe_bloc.dart';
import 'recipe_event.dart';
import 'recipe_state.dart';
import 'recipe_detail_screen.dart';

class RecipeList extends StatelessWidget {
  const RecipeList({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeBloc = BlocProvider.of<RecipeBloc>(context);
    recipeBloc.add(FetchRecipesEvent());

    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        if (state is RecipeLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RecipeLoadedState) {
          return ListView.builder(
            itemCount: state.recipes.length,
            itemBuilder: (context, index) {
              final recipe = state.recipes[index];
              return ListTile(
                title: Text(recipe['label']),
                subtitle: Image.network(recipe['image']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailScreen(recipe: recipe),
                    ),
                  );
                },
              );
            },
          );
        } else if (state is RecipeErrorState) {
          return Center(child: Text('Error: ${state.error}'));
        } else {
          return Container();
        }
      },
    );
  }
}
