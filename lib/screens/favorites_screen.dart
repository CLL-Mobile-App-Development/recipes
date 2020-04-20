import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './recipe_details_screen.dart';

import '../widgets/recipe_item.dart';
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
      //'recipeId':
      //  recipeId, // passing just the recipe-id as an argument to the recipe details screen page route.
      'recipeDoc': recipeDoc,
      'favorites': widget.favorites,
      //'filters' : recipeFilters,
    });
    // .then((_) {
    //   // As the RecipeDetailsScreen pop would be implicit on the back button click and not an explicit pop through app flow,
    //   // a null value will be returned to the "then" method. So, it has been ignored.
    //   if (widget.favorites.length != currentFavoritesCount)
    //     setState(
    //         () {}); // No action is performed, but a screen re-build is triggered to reflect the changes in users recipe favorites.
    // });

    //   .then((deletedRecipeId) {
    // if (deletedRecipeId != null) {
    //   setState(() {
    //     // Remove the recipe with matching id from the list of selected recipes and then setState to enable re-building the widget
    //     selectedRecipes.removeWhere((recipe) {
    //       return recipe.recipeId == deletedRecipeId;
    //     });
    //   });
    // }
    //});
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.favorites.length == 0) {
    //   return Center(
    //     child: Text('You don\'t have any favorites at the moment !',
    //         style: Theme.of(context).textTheme.title),
    //   );
    // } else {
    //   currentFavoritesCount = widget.favorites.length;

    // return StreamBuilder(
    //     stream: Firestore.instance
    //         .collection('users')
    //         .document('admin')
    //         .collection('favorite_recipes')
    //         .snapshots(),
    //     builder: (context, snapshot) {
    //       if (snapshot == null || snapshot.data == null || snapshot.data.documents.length == 0) {
    //         return Center(
    //           child: Text('You don\'t have any favorites at the moment !',
    //               style: Theme.of(context).textTheme.title),
    //         );
    //       } else {
    //         return ListView.builder(
    //           itemBuilder: (widgetContext, itemIndex) {
    //             return RecipeItem(
    //               // recipeTitle: widget.favorites[itemIndex].recipeTitle,
    //               // recipeId: widget.favorites[itemIndex].recipeId,
    //               // imageUrl: widget.favorites[itemIndex].recipeImageUrl,
    //               // cookingTime: widget.favorites[itemIndex].cookingTime,
    //               // cookingComplexity: getCookingComplexityAsString(
    //               //     widget.favorites[itemIndex].cookingComplexity),
    //               // recipeAffordability: getRecipeAffordabilityAsString(
    //               //     widget.favorites[itemIndex].affordabilityOfRecipe),
    //               recipeDetailDoc: snapshot.data.documents[itemIndex],
    //               // loadRecipeDetailsOnTap: () => openRecipeDetailScreen(
    //               //     widgetContext, widget.favorites[itemIndex].recipeId),
    //               loadRecipeDetailsOnTap: () => openRecipeDetailScreen(
    //                 widgetContext,
    //                 snapshot.data.documents[itemIndex],
    //               ),
    //             );
    //           },
    //           //itemCount: widget.favorites.length,
    //           itemCount: snapshot.data.documents.length,
    //         );
    //       } // end of else-part
    //     });
    //}

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
