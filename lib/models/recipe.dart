import 'package:flutter/foundation.dart';

enum CookingComplexity {
  Simple,
  Challenging,
  Hard,
}

enum AffordabilityOfRecipe {
  Affordable,
  Pricey,
  Luxurious,
}

class Recipe {
  final String recipeId;
  final List<String>
      mappedCategoryIds; // List of categories to which this recipe belongs to
  final String recipeTitle;
  final String recipeImageUrl;
  final List<String>
      recipeIngredients; // ingredient name and quantity together as a string
  final List<String> recipeSteps;
  final int cookingTime;
  final CookingComplexity cookingComplexity; // How hard is the recipe to cook ?
  final AffordabilityOfRecipe
      affordabilityOfRecipe; // How expensive can it be ?
  final bool isRecipeGlutenFree;
  final bool isRecipeLactoseFree;
  final bool isRecipeVegan;
  final bool isRecipeVegetarian;

  const Recipe({
    @required this.recipeId,
    @required this.mappedCategoryIds,
    @required this.recipeTitle,
    @required this.recipeImageUrl,
    @required this.recipeIngredients,
    @required this.recipeSteps,
    @required this.cookingTime,
    @required this.cookingComplexity,
    @required this.affordabilityOfRecipe,
    @required this.isRecipeGlutenFree,
    @required this.isRecipeLactoseFree,
    @required this.isRecipeVegan,
    @required this.isRecipeVegetarian,
  });

}
