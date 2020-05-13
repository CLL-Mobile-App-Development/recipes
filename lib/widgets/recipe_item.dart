import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/recipe.dart';

class RecipeItem extends StatelessWidget {
  // final String recipeTitle;
  // final String recipeId;
  // final String imageUrl;
  // final int cookingTime;
  // final String cookingComplexity;
  // final String recipeAffordability;
  final DocumentSnapshot recipeDetailDoc;
  final Function loadRecipeDetailsOnTap;

  const RecipeItem({
    // @required this.recipeTitle,
    // @required this.recipeId,
    // @required this.imageUrl,
    // @required this.cookingTime,
    // @required this.cookingComplexity,
    // @required this.recipeAffordability,
    @required this.recipeDetailDoc,
    @required this.loadRecipeDetailsOnTap,
  });


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


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loadRecipeDetailsOnTap,
      //splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Card(
        elevation: 10,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  child: Image.network(
                    recipeDetailDoc['imageUrl'],
                    fit: BoxFit.cover,
                    height: 250,
                    width: double.infinity,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                Positioned(
                  // To position the text on the bottom right corner of the image.
                  bottom: 20,
                  right: 10,
                  width: 200,
                  child: Container(
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(
                      recipeDetailDoc['title'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                      overflow: TextOverflow.fade,
                      softWrap: true,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.schedule),
                      SizedBox(width: 5),
                      Text(
                        '${recipeDetailDoc['cookingTime']} mins',
                        style: TextStyle(
                          //fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.work),
                      SizedBox(width: 5),
                      Text(
                        getCookingComplexityAsString(CookingComplexity.values[recipeDetailDoc['recipeCookingComplexityIdx']]),
                        style: TextStyle(
                          //fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.attach_money),
                      //SizedBox(width: 2),
                      Text(
                        getRecipeAffordabilityAsString(AffordabilityOfRecipe.values[recipeDetailDoc['recipeAffordabilityIdx']]),
                        style: TextStyle(
                          //fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
    );
  }
}
