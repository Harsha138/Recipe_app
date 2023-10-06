import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:recipe_2/first.dart';
// import 'package:recipe_2/first.dart';
import 'recipe_list.dart';
import 'recipe_bloc.dart';
// import 'first.dart';
// import 'recipe_list.dart';
// import 'first.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => RecipeBloc(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Recipe List'),
          ),
          body: RecipeList(),
        ),
      ),
    );
  }
}
