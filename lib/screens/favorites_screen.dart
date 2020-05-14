import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './recipe_details_screen.dart';

import '../widgets/scrollable_recipe_item_stream_renderer.dart';

import '../models/recipe.dart';

class FavoritesScreen extends StatefulWidget {
  static const screenRouteName = '/favorites-screen';

  List<Recipe> favorites;
  Map<String, bool> recipeFilters;

  FavoritesScreen({
    @required this.favorites,
    @required this.recipeFilters,
  });

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  void openRecipeDetailScreen(BuildContext widgetContext, final recipeDoc) {
    Navigator.of(widgetContext)
        .pushNamed(RecipeDetailsScreen.screenRouteName, arguments: {
      'recipeDoc': recipeDoc,
      'favorites': widget.favorites,
    });
  }

  @override
  Widget build(BuildContext context) {
    
    // This screen is actually part of a tab, so, only unlike a normal screen laid out with Scaffold(appBar, body),
    // this screeen has only the body with appBar being taken care of in the TabsScreen.
    
    return ScrollableRecipeItemStreamRenderer(
      recipeFilters: widget.recipeFilters,
      openRecipeDetailScreen: openRecipeDetailScreen,
      recipeQSnapshotStream: Firestore.instance
          .collection('users')
          .document('admin')
          .collection('favorite_recipes')
          .snapshots(),
    );
  }
}
