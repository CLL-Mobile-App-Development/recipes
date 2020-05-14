import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/screens/recipe_details_screen.dart';

import '../widgets/scrollable_recipe_item_stream_renderer.dart';

class CategoryRecipesScreen extends StatefulWidget {
  // To avoid typo errors screen's route name has been stored in a static variable, which can be used in the routes table
  // and setting up the route to this screen with the pushNamed method of app Navigator. Since it is a static variable, it
  // is not part of this class's objects, but merely scoped to be under this screen' name. So, its access does not require
  // an instance of this screen and can be accessed with the "." notation
  static const screenRouteName = '/category-recipes';

  @override
  _CategoryRecipesScreenState createState() => _CategoryRecipesScreenState();
}

class _CategoryRecipesScreenState extends State<CategoryRecipesScreen> {
  DocumentSnapshot categoryDoc;
  String categoryId = "", categoryDocId = "";
  String categoryTitle = "";
  List<Recipe> selectedRecipes = [], filteredRecipes = [], favorites = [];
  Map<String, bool> recipeFilters;
  var firstRecipeDataLoad = false;

  String getCookingComplexityAsString(
      CookingComplexity recipeCookingComplexity) {
    switch (recipeCookingComplexity) {
      case CookingComplexity.Simple:
        return 'Simple';
        break;
      case CookingComplexity.Challenging:
        return 'Challenging';
        break;
      case CookingComplexity.Hard:
        return 'Hard';
        break;
      default:
        return 'Unknown';
    }
  }

  String getRecipeAffordabilityAsString(
      AffordabilityOfRecipe recipeAffordability) {
    switch (recipeAffordability) {
      case AffordabilityOfRecipe.Affordable:
        return 'Affordable';
        break;
      case AffordabilityOfRecipe.Pricey:
        return 'Pricey';
        break;
      case AffordabilityOfRecipe.Luxurious:
        return 'Luxurious';
        break;
      default:
        return 'Unknown';
    }
  }

  void openRecipeDetailScreen(BuildContext widgetContext,
      DocumentSnapshot recipeDetailDoc /*final recipeId*/) {
    Navigator.of(widgetContext)
        .pushNamed(RecipeDetailsScreen.screenRouteName, arguments: {
      'recipeDoc': recipeDetailDoc,
      'favorites': favorites,
      'filters': recipeFilters,
    });
    
  }

  
  @override
  void didChangeDependencies() {
    // Used this method instead of initState as context won't be available in initState()
    // Also, this method is called after initState() and before the build(). So, this will load
    // the whole list of matched recipes with the setState call before the build, discarding any deletes
    // that were done to trigger the widget re-paint. Hence, the use of a flag to only load whole content
    // for the first time.

    // Args passed as a map with the onTap action of the CategotyItem widget tapped on the CategoriesScreen via a pushNamed
    // operation of a named route in MaterialApp widget's (main.dart) "routes" attribute. The mapping between the named route
    // and this screen is established in that routes table of the MaterialApp through the mapped builder function that returns
    // this screen as a widget.

    // The "context" is acting as an efficient message passing system enabling data access at different points in the widget
    // tree without passing arguments through widget constructors. Like in the case of ModalRoute, where arguments passed to
    // this screen from CategoryItem widget are being accessed directly through "context" without a constructor. As the type
    // of "arguments" is "object", it is being type-casted to the appropriate type of the arguments passed by CategoryItem.

    if (!firstRecipeDataLoad) {
      print('Initial recipe list load !');
      // Load whole list only for the first time when widget is created
      final screenRouteArgs =
          ModalRoute.of(context).settings.arguments as Map<String, Object>;

      categoryDoc = screenRouteArgs['categoryDoc'];
      categoryId = categoryDoc['categoryId'];
      categoryTitle = categoryDoc['categoryTitle'];

      favorites = screenRouteArgs['favoriteRecipes'];
      recipeFilters = screenRouteArgs['recipeFilters'];

      print(
          'Recipe Stream length:, with doc id: ${categoryDoc.documentID}, for category: $categoryTitle'); 

      firstRecipeDataLoad =
          true; // this flag prevent reload of the entire list in the future widget re-paints set-off by a recipe delete operation.

    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('Gluten setting: ${recipeFilters['gluten']}');
    print('Lactose setting: ${recipeFilters['lactose']}');
    print('Vegan setting: ${recipeFilters['vegan']}');
    print('Vegetarian setting: ${recipeFilters['vegetarian']}');
    print('Filtered recipe count: ${filteredRecipes.length}');

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),

      body: ScrollableRecipeItemStreamRenderer(
        recipeQSnapshotStream: Firestore.instance
            .collection('categories')
            .document(categoryDoc.documentID)
            .collection('recipes')
            .snapshots(),
        recipeFilters: recipeFilters,
        openRecipeDetailScreen: openRecipeDetailScreen,
      ),
    );
  }
}
