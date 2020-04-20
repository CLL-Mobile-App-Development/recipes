import 'package:flutter/material.dart';

import './screens/tabs_screen.dart';
import './screens/categories_screen.dart';
import './screens/category_recipes_screen.dart';
import './screens/recipe_details_screen.dart';
import './screens/favorites_screen.dart';
import './screens/filters_screen.dart';
import './models/recipe.dart';

void main() => runApp(LakshmisCookbook());

class LakshmisCookbook extends StatelessWidget {
  // This widget is the root of your application.

  List<Recipe> favoriteRecipes = [];

  Map<String, bool> recipefilterSelections = {
    'gluten'  : false,
    'lactose' : false,
    'vegan' : false,
    'vegetarian' : false,
  };

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      //home: CategoriesScreen(),
      //initialRoute: '/',
      routes: {
        '/' : (widgetContext) => TabsScreen(favorites: favoriteRecipes, filters: recipefilterSelections,), 
        CategoriesScreen.screenRouteName : (widgetContext) => CategoriesScreen(favorites: favoriteRecipes,filters: recipefilterSelections,),
        CategoryRecipesScreen.screenRouteName : (widgetContext) => CategoryRecipesScreen(),
        RecipeDetailsScreen.screenRouteName : (widgetContext) => RecipeDetailsScreen(), 
        FavoritesScreen.screenRouteName : (widgetContext) => FavoritesScreen(favorites: favoriteRecipes, recipeFilters: recipefilterSelections,),
        FiltersScreen.screenRouteName : (widgetContext) => FiltersScreen(filters: recipefilterSelections),
      },
      onUnknownRoute: (settings){
        print(settings.arguments);
        return MaterialPageRoute(builder: (widgetContext) {
            return CategoriesScreen(favorites: favoriteRecipes, filters: recipefilterSelections,);
        });
      }
    );
  }
}