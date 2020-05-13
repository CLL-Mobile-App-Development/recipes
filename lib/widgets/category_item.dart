import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../screens/category_recipes_screen.dart';

class CategoryItem extends StatefulWidget {
  // final String id;
  // final String title;
  // final Color color;
  DocumentSnapshot categoryItemDocument;
  List<Recipe> favorites;
  Map<String, bool> filters;

  CategoryItem({
    // @required this.id,
    // @required this.title,
    // @required this.color,
    @required this.categoryItemDocument,
    @required this.favorites,
    @required this.filters,
  });

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  void switchToCategoryRecipesScreen(final widgetContext) {
    Navigator.of(widgetContext).pushNamed(
      CategoryRecipesScreen.screenRouteName,
      arguments: {
        // this map will now be part of the "context" enabling direct data access in CategoryRecipesScreen
        // 'categoryId': widget.id,
        // 'categoryTitle': widget.title,
        //'categoryDocId': widget.categoryItemDocument.documentID,
        //'categoryId': widget.categoryItemDocument['categoryId'],
        //'categoryTitle': widget.categoryItemDocument['categoryTitle'],
        'categoryDoc': widget.categoryItemDocument,
        'favoriteRecipes': widget.favorites,
        'recipeFilters': widget.filters,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color categoryColor = widget.categoryItemDocument['isCategoryColorPrimary']
        ? Colors.primaries[widget.categoryItemDocument['categoryColorListIdx']]
        : Colors.accents[widget.categoryItemDocument['categoryColorListIdx']];

    return InkWell(
      onTap: () => switchToCategoryRecipesScreen(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
        child: Text(
          //widget.title,
          widget.categoryItemDocument['categoryTitle'],
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              // widget.color.withOpacity(0.7),
              // widget.color,
              categoryColor.withOpacity(0.7),
              categoryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
