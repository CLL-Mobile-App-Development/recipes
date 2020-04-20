import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './recipe_item.dart';

class ScrollableRecipeItemStreamRenderer extends StatefulWidget {
  final Map<String, bool> recipeFilters;
  final Function openRecipeDetailScreen;
  final Stream<QuerySnapshot> recipeQSnapshotStream;

  ScrollableRecipeItemStreamRenderer({
    @required this.recipeFilters,
    @required this.openRecipeDetailScreen,
    @required this.recipeQSnapshotStream,
  });

  @override
  State<StatefulWidget> createState() =>
      _ScrollableRecipeItemStreamRendererState();
}

class _ScrollableRecipeItemStreamRendererState
    extends State<ScrollableRecipeItemStreamRenderer> {
  bool applyRecipePreferences =
      false; // State maintained for the switch in rendering all or preferred recipes in a given category

  // Call back method for the Switch in ListTile to toggle and accordingly render appropriate set of
  void manageSwitchState(bool currSwitchState) {
    setState(() {
      print('Current setting to apply preferences is $applyRecipePreferences');
      applyRecipePreferences = currSwitchState;
      print('Updated setting to apply preferences is $applyRecipePreferences');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(initialScrollOffset: 0.2),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.width * 0.7
                  : MediaQuery.of(context).size.width * 0.4, // Orientation.landscape
              child: ListTile(
                leading: Text(
                  'Apply Preferences',
                  style: Theme.of(context).textTheme.title,
                ),
                title: Switch(
                  value: applyRecipePreferences,
                  onChanged: manageSwitchState,
                ),
                contentPadding: EdgeInsets.all(10.0),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            applyRecipePreferences
                ? StreamBuilder(
                    // stream: Firestore.instance
                    //     .collection('categories')
                    //     .document(categoryDoc.documentID)
                    //     .collection('recipes')
                    //     .snapshots()
                    //     .where((recipeCollection) {
                    //   var recipeDocListWithPreferences = [];

                    //   if (recipeCollection == null ||
                    //       recipeCollection.documents == null)
                    //     return false;
                    //   else {
                    //     final recipeDocListRef = recipeCollection.documents;

                    //     recipeDocListWithPreferences =
                    //         recipeDocListRef.where((recipeDoc) {
                    //       return (recipeDoc['filters']['isGlutenFree'] ==
                    //               !recipeFilters['gluten']) &&
                    //           (recipeDoc['filters']['isLactoseFree'] ==
                    //               !recipeFilters['lactose']) &&
                    //           (recipeDoc['filters']['isVegan'] ==
                    //               recipeFilters['vegan']) &&
                    //           (recipeDoc['filters']['isVegetarian'] ==
                    //               recipeFilters['vegetarian']);
                    //     }).toList();
                    //   }

                    //   bool foundRecipesMatchingPreferences =
                    //       recipeDocListWithPreferences.length > 0;

                    //   if (foundRecipesMatchingPreferences)
                    //     print(
                    //         'Found docs matching the preferences for the chosen category');
                    //   else
                    //     print(
                    //         'Docs don\'t match the preferences for the chosen category');

                    //   return foundRecipesMatchingPreferences;
                    // }),
                    stream: widget.recipeQSnapshotStream,
                    builder: (context, snapshot) {
                      if (snapshot == null ||
                          snapshot.data == null ||
                          snapshot.data.documents.length == 0) {
                        print('No matching recipes found for set preferences');
                        return Center(
                          child: Text(
                            'No recipes matched your preferences !',
                            style: TextStyle(
                              fontFamily: 'RobotoCondensed',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        );
                      } else {
                        print(
                            'Document count in stream rendered snapshot: ${snapshot.data.documents.length}, document id: ${snapshot.data.documents[0].documentID}');

                        var recipeDocListWithPreferences = [];
                        recipeDocListWithPreferences =
                            snapshot.data.documents.where((recipeDocSnapshot) {
                          return (recipeDocSnapshot['filters']
                                      ['isGlutenFree'] ==
                                  !widget.recipeFilters['gluten']) &&
                              (recipeDocSnapshot['filters']['isLactoseFree'] ==
                                  !widget.recipeFilters['lactose']) &&
                              (recipeDocSnapshot['filters']['isVegan'] ==
                                  widget.recipeFilters['vegan']) &&
                              (recipeDocSnapshot['filters']['isVegetarian'] ==
                                  widget.recipeFilters['vegetarian']);
                        }).toList();

                        if (recipeDocListWithPreferences.length == 0) {
                          print(
                              'No matching recipes found for set preferences in the input snapshot');
                          return Column(
                            children: <Widget>[
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                              ),
                              Center(
                                child: Text(
                                  'No recipes matched your preferences !',
                                  style: TextStyle(
                                    fontFamily: 'RobotoCondensed',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          // Have recipes matching preferences
                          return ListView.builder(
                            /* Important observation: 
                           ----------------------
                           1) ListView.builder does not render intended content if the itemBuilder callback fails to fetch a Widget object
                           in any iteration during the process of building a list. For that reason, the logic to create filtered recipes
                           has been taken out of the builder callback function and placed in the didChangeDependencies method to perform
                           the recipe filtration process right after the corresponding category recipes list has been created.
                           It took some time to figure out the issue with missing data on the category_recipes_screen as there is no
                           hinting information in the debug console log or the app interface.
                           
                           2) controller, shrinkWrap are important attributes to be set in ListView.builder widget, 
                          when rendered as a Column widget child (or nested) as that would make the list item stream scrollable
                          and so would give the Column widget a handle on the layout of the dynamic content size displayed
                          on the screen. Otherwise, an empty screen would be displayed with no list items.
                          By default, column would take as much space as it can, which is virtually infinite, so, that 
                          essentially gets in to effect when the children widgets don't give a means for Column widget to get
                          an estimate on the size and content layout.
                            */
                            itemBuilder: (widgetContext, itemIndex) {
                              print(
                                  'Item # $itemIndex: ${snapshot.data.documents[itemIndex]['title']}');
                              print(
                                  'Gluten Free: ${snapshot.data.documents[itemIndex]['filters']['isGlutenFree']}');
                              print(
                                  'Lactose Free: ${snapshot.data.documents[itemIndex]['filters']['isLactoseFree']}');
                              print(
                                  'Vegan: ${snapshot.data.documents[itemIndex]['filters']['isVegan']}');
                              print(
                                  'Vegetarian: ${snapshot.data.documents[itemIndex]['filters']['isVegetarian']}');

                              // if ((recipeFilters['gluten'] ==
                              //         !selectedRecipes[itemIndex].isRecipeGlutenFree) &&
                              //     (recipeFilters['lactose'] ==
                              //         !selectedRecipes[itemIndex].isRecipeLactoseFree) &&
                              //     (recipeFilters['vegan'] ==
                              //         selectedRecipes[itemIndex].isRecipeVegan) &&
                              //     (recipeFilters['vegetarian'] ==
                              //         selectedRecipes[itemIndex].isRecipeVegetarian)) {
                              return RecipeItem(
                                // recipeTitle: filteredRecipes[itemIndex].recipeTitle,
                                // recipeId: filteredRecipes[itemIndex].recipeId,
                                // imageUrl: filteredRecipes[itemIndex].recipeImageUrl,
                                // cookingTime: filteredRecipes[itemIndex].cookingTime,
                                // cookingComplexity: getCookingComplexityAsString(
                                //     filteredRecipes[itemIndex].cookingComplexity),
                                // recipeAffordability: getRecipeAffordabilityAsString(
                                //     filteredRecipes[itemIndex].affordabilityOfRecipe),
                                recipeDetailDoc:
                                    //snapshot.data.documents[itemIndex],
                                    recipeDocListWithPreferences[itemIndex],
                                loadRecipeDetailsOnTap: () =>
                                    widget.openRecipeDetailScreen(
                                        widgetContext,
                                        //snapshot.data.documents[
                                        //  itemIndex] /*filteredRecipes[itemIndex].recipeId*/),
                                        recipeDocListWithPreferences[
                                            itemIndex]),
                              );
                              // } // end of if
                            },
                            //itemCount: snapshot.data.documents.length,
                            itemCount: recipeDocListWithPreferences.length,
                            shrinkWrap: true,
                            controller: ScrollController(
                              initialScrollOffset: 0.2,
                            ),
                          );
                        }
                      }
                    })
                : // Render all recipes in the given category
                StreamBuilder(
                    stream: widget
                        .recipeQSnapshotStream /* Stream all recipes in the chosen category */,
                    builder: (context, snapshot) {
                      if (snapshot == null ||
                          snapshot.data == null ||
                          snapshot.data.documents.length == 0) {
                        return Center(
                          child: Text(
                            'No recipes available under this category !',
                            style: TextStyle(
                              fontFamily: 'RobotoCondensed',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          // controller, shrinkWrap are important attributes to be set in ListView.builder widget,
                          // when rendered as a Column widget child (or nested) as that would make the list item stream scrollable
                          // and so would give the Column widget a handle on the layout of the dynamic content size displayed
                          // on the screen. Otherwise, an empty screen would be displayed with no list items.
                          // By default, column would take as much space as it can, which is virtually infinite, so, that
                          // essentially gets in to effect when the children widgets don't give a means for Column widget to get
                          // an estimate on the size and content layout.
                          controller: ScrollController(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, itemIdx) {
                            print(
                                'Item # $itemIdx: ${snapshot.data.documents[itemIdx]['title']}');
                            print(
                                'Gluten Free: ${snapshot.data.documents[itemIdx]['filters']['isGlutenFree']}');
                            print(
                                'Lactose Free: ${snapshot.data.documents[itemIdx]['filters']['isLactoseFree']}');
                            print(
                                'Vegan: ${snapshot.data.documents[itemIdx]['filters']['isVegan']}');
                            print(
                                'Vegetarian: ${snapshot.data.documents[itemIdx]['filters']['isVegetarian']}');

                            return RecipeItem(
                              // recipeTitle: filteredRecipes[itemIndex].recipeTitle,
                              // recipeId: filteredRecipes[itemIndex].recipeId,
                              // imageUrl: filteredRecipes[itemIndex].recipeImageUrl,
                              // cookingTime: filteredRecipes[itemIndex].cookingTime,
                              // cookingComplexity: getCookingComplexityAsString(
                              //     filteredRecipes[itemIndex].cookingComplexity),
                              // recipeAffordability: getRecipeAffordabilityAsString(
                              //     filteredRecipes[itemIndex].affordabilityOfRecipe),
                              recipeDetailDoc: snapshot.data.documents[itemIdx],
                              loadRecipeDetailsOnTap: () =>
                                  widget.openRecipeDetailScreen(
                                      context,
                                      snapshot.data.documents[
                                          itemIdx] /*filteredRecipes[itemIndex].recipeId*/),
                            );
                          }, // itemBuilder
                        ); // SingleChildScrollView
                      } // else-part
                    } // builder
                    ),
          ],
        ),
      ),
    );
  }
}
