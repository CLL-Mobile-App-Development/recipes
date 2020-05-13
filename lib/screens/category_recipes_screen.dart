import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/screens/recipe_details_screen.dart';

//import '../widgets/recipe_item.dart';
import '../widgets/scrollable_recipe_item_stream_renderer.dart';

//import '../data/real-data.dart';

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
      //'recipeId':
      //  recipeId, // passing just the recipe-id as an argument to the recipe details screen page route.
      'favorites': favorites,
      'filters': recipeFilters,
    });
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

  // @override
  // void initState() {
  //   super.initState();
  // }

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

      //categoryId = screenRouteArgs['categoryId'];
      //categoryDocId = screenRouteArgs['categoryDocId'];
      //categoryTitle = screenRouteArgs['categoryTitle'];
      categoryDoc = screenRouteArgs['categoryDoc'];
      categoryId = categoryDoc['categoryId'];
      categoryTitle = categoryDoc['categoryTitle'];

      // selectedRecipes = DUMMY_RECIPES.where((recipe) {
      //   // "where" method filters list items based on the items returning true for the test
      //   print('Recipe name: ${recipe.recipeTitle}');
      //   return recipe.mappedCategoryIds.contains(
      //       categoryId); // "contains" method checks if the passed in item is part of the list instance.
      // }).toList();

      //final categoryRecipeDataDocs = Firestore.instance.collection('categories').document(categoryDocId).collection('recipes').snapshots();

      favorites = screenRouteArgs['favoriteRecipes'];
      recipeFilters = screenRouteArgs['recipeFilters'];

      // final categoryRecipeDocSnapshotNestedList = Firestore.instance
      //     .collection('categories')
      //     .document(categoryDoc.documentID)
      //     .collection('recipes')
      //     .snapshots()
      //     .where((recipeCollection) {
      //   final recipeDocListWithPreferences =
      //       recipeCollection.documents.where((recipeDoc) {
      //     return (recipeDoc['filters']['isGlutenFree'] ==
      //             !recipeFilters['gluten']) &&
      //         (recipeDoc['filters']['isLactoseFree'] ==
      //             !recipeFilters['lactose']) &&
      //         (recipeDoc['filters']['isVegan'] == recipeFilters['vegan']) &&
      //         (recipeDoc['filters']['isVegetarian'] ==
      //             recipeFilters['vegetarian']);
      //   }).toList();

      //   if (recipeDocListWithPreferences.length > 0)
      //     print('Found docs matching the preferences for the chosen category');
      //   else
      //     print('Docs don\'t match the preferences for the chosen category');

      //   return recipeDocListWithPreferences.length > 0;
      // }); //.map((recipeSnapshot){ return recipeSnapshot.documents;}).toList();

      // List<DocumentSnapshot> categoryRecipeDocList = [];
      // categoryRecipeDocSnapshotNestedList.then((recipeDocNestedList){
      //   for(List<DocumentSnapshot> recDocList in recipeDocNestedList){
      //     categoryRecipeDocList.addAll(recDocList);
      //   }
      // });

      // .where(
      //   'filters.isGlutenFree',
      //   isEqualTo: '!recipeFilters[\'gluten\']',
      // )
      // .where(
      //   'filters.isLactoseFree',
      //   isEqualTo: '!recipeFilters[\'lactose\']',
      // )
      // .where(
      //   'filters.isVegan',
      //   isEqualTo: 'recipeFilters[\'vegan\']',
      // )
      // .where(
      //   'filters.isVegetarian',
      //   isEqualTo: 'recipeFilters[\'vegetarian\']',
      // )
      //     .getDocuments()
      //     .then((recipeCollection) {
      //   return recipeCollection.documents;
      // });

      print(
          'Recipe Stream length:, with doc id: ${categoryDoc.documentID}, for category: $categoryTitle'); // .whenComplete(action).then((recipeList) {
      //return recipeList.length;
      //})}

      // filteredRecipes = selectedRecipes.where((currentRecipeItem) {
      //   return ((currentRecipeItem.isRecipeGlutenFree ==
      //           !recipeFilters['gluten']) &&
      //       (currentRecipeItem.isRecipeLactoseFree ==
      //           !recipeFilters['lactose']) &&
      //       (currentRecipeItem.isRecipeVegan == recipeFilters['vegan']) &&
      //       (currentRecipeItem.isRecipeVegetarian ==
      //           recipeFilters['vegetarian']));
      // }).toList();

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

      // body: filteredRecipes.length ==
      //         0 // Render text or ListView.builder widget based on available data in the filteredRecipes list.
      //     ? Center(
      //         child: Text(
      //           'No recipes matched your preferences !',
      //           style: TextStyle(
      //             fontFamily: 'RobotoCondensed',
      //             fontWeight: FontWeight.bold,
      //             fontSize: 20,
      //           ),
      //         ),
      //       )
      //     :
      // body: SingleChildScrollView(
      //   controller: ScrollController(initialScrollOffset: 0.2),
      //   child: Container(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       children: <Widget>[
      //         Container(
      //           width: MediaQuery.of(context).size.width * 0.6,
      //           child: ListTile(
      //             leading: Text(
      //               'Apply Preferences',
      //               style: Theme.of(context).textTheme.title,
      //             ),
      //             title: Switch(
      //               value: applyRecipePreferences,
      //               onChanged: manageSwitchState,
      //             ),
      //             contentPadding: EdgeInsets.all(10.0),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         applyRecipePreferences
      //             ? StreamBuilder(
      //                 stream: Firestore.instance
      //                     .collection('categories')
      //                     .document(categoryDoc.documentID)
      //                     .collection('recipes')
      //                     .snapshots()
      //                     .where((recipeCollection) {
      //                   var recipeDocListWithPreferences = [];

      //                   if (recipeCollection == null ||
      //                       recipeCollection.documents == null)
      //                     return false;
      //                   else {
      //                     final recipeDocListRef = recipeCollection.documents;

      //                     recipeDocListWithPreferences =
      //                         recipeDocListRef.where((recipeDoc) {
      //                       return (recipeDoc['filters']['isGlutenFree'] ==
      //                               !recipeFilters['gluten']) &&
      //                           (recipeDoc['filters']['isLactoseFree'] ==
      //                               !recipeFilters['lactose']) &&
      //                           (recipeDoc['filters']['isVegan'] ==
      //                               recipeFilters['vegan']) &&
      //                           (recipeDoc['filters']['isVegetarian'] ==
      //                               recipeFilters['vegetarian']);
      //                     }).toList();
      //                   }

      //                   bool foundRecipesMatchingPreferences =
      //                       recipeDocListWithPreferences.length > 0;

      //                   if (foundRecipesMatchingPreferences)
      //                     print(
      //                         'Found docs matching the preferences for the chosen category');
      //                   else
      //                     print(
      //                         'Docs don\'t match the preferences for the chosen category');

      //                   return foundRecipesMatchingPreferences;
      //                 }),
      //                 builder: (context, snapshot) {
      //                   if (snapshot == null ||
      //                       snapshot.data == null ||
      //                       snapshot.data.documents.length == 0) {
      //                     print(
      //                         'No matching recipes found for set preferences');
      //                     return Center(
      //                       child: Text(
      //                         'No recipes matched your preferences !',
      //                         style: TextStyle(
      //                           fontFamily: 'RobotoCondensed',
      //                           fontWeight: FontWeight.bold,
      //                           fontSize: 20,
      //                         ),
      //                       ),
      //                     );
      //                   } else {
      //                     print(
      //                         'Document count in stream rendered snapshot: ${snapshot.data.documents.length}, document id: ${snapshot.data.documents[0].documentID}');

      //                     var recipeDocListWithPreferences = [];
      //                     recipeDocListWithPreferences = snapshot.data.documents
      //                         .where((recipeDocSnapshot) {
      //                       return (recipeDocSnapshot['filters']
      //                                   ['isGlutenFree'] ==
      //                               !recipeFilters['gluten']) &&
      //                           (recipeDocSnapshot['filters']
      //                                   ['isLactoseFree'] ==
      //                               !recipeFilters['lactose']) &&
      //                           (recipeDocSnapshot['filters']['isVegan'] ==
      //                               recipeFilters['vegan']) &&
      //                           (recipeDocSnapshot['filters']['isVegetarian'] ==
      //                               recipeFilters['vegetarian']);
      //                     }).toList();

      //                     if (recipeDocListWithPreferences.length == 0) {
      //                       print(
      //                           'No matching recipes found for set preferences in the input snapshot');
      //                       return Column(
      //                         children: <Widget>[
      //                           SizedBox(
      //                             height:
      //                                 MediaQuery.of(context).size.height * 0.25,
      //                           ),
      //                           Center(
      //                             child: Text(
      //                               'No recipes matched your preferences !',
      //                               style: TextStyle(
      //                                 fontFamily: 'RobotoCondensed',
      //                                 fontWeight: FontWeight.bold,
      //                                 fontSize: 20,
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       );
      //                     } else {
      //                       // Have recipes matching preferences
      //                       return SingleChildScrollView(
      //                         child: ListView.builder(
      //                           /* Important observation:
      //                    ----------------------
      //                    ListView.builder does not render intended content if the itemBuilder callback fails to fetch a Widget object
      //                    in any iteration during the process of building a list. For that reason, the logic to create filtered recipes
      //                    has been taken out of the builder callback function and placed in the didChangeDependencies method to perform
      //                    the recipe filtration process right after the corresponding category recipes list has been created.
      //                    It took some time to figure out the issue with missing data on the category_recipes_screen as there is no
      //                    hinting information in the debug console log or the app interface. */
      //                           itemBuilder: (widgetContext, itemIndex) {
      //                             print(
      //                                 'Item # $itemIndex: ${snapshot.data.documents[itemIndex]['title']}');
      //                             print(
      //                                 'Gluten Free: ${snapshot.data.documents[itemIndex]['filters']['isGlutenFree']}');
      //                             print(
      //                                 'Lactose Free: ${snapshot.data.documents[itemIndex]['filters']['isLactoseFree']}');
      //                             print(
      //                                 'Vegan: ${snapshot.data.documents[itemIndex]['filters']['isVegan']}');
      //                             print(
      //                                 'Vegetarian: ${snapshot.data.documents[itemIndex]['filters']['isVegetarian']}');

      //                             // if ((recipeFilters['gluten'] ==
      //                             //         !selectedRecipes[itemIndex].isRecipeGlutenFree) &&
      //                             //     (recipeFilters['lactose'] ==
      //                             //         !selectedRecipes[itemIndex].isRecipeLactoseFree) &&
      //                             //     (recipeFilters['vegan'] ==
      //                             //         selectedRecipes[itemIndex].isRecipeVegan) &&
      //                             //     (recipeFilters['vegetarian'] ==
      //                             //         selectedRecipes[itemIndex].isRecipeVegetarian)) {
      //                             return RecipeItem(
      //                               // recipeTitle: filteredRecipes[itemIndex].recipeTitle,
      //                               // recipeId: filteredRecipes[itemIndex].recipeId,
      //                               // imageUrl: filteredRecipes[itemIndex].recipeImageUrl,
      //                               // cookingTime: filteredRecipes[itemIndex].cookingTime,
      //                               // cookingComplexity: getCookingComplexityAsString(
      //                               //     filteredRecipes[itemIndex].cookingComplexity),
      //                               // recipeAffordability: getRecipeAffordabilityAsString(
      //                               //     filteredRecipes[itemIndex].affordabilityOfRecipe),
      //                               recipeDetailDoc:
      //                                   //snapshot.data.documents[itemIndex],
      //                                   recipeDocListWithPreferences[itemIndex],
      //                               loadRecipeDetailsOnTap: () =>
      //                                   openRecipeDetailScreen(
      //                                       widgetContext,
      //                                       //snapshot.data.documents[
      //                                       //  itemIndex] /*filteredRecipes[itemIndex].recipeId*/),
      //                                       recipeDocListWithPreferences[
      //                                           itemIndex]),
      //                             );
      //                             // } // end of if
      //                           },
      //                           //itemCount: snapshot.data.documents.length,
      //                           itemCount: recipeDocListWithPreferences.length,
      //                           shrinkWrap: true,
      //                           controller: ScrollController(
      //                             initialScrollOffset: 0.2,
      //                           ),
      //                         ),
      //                       );
      //                     }
      //                   }
      //                 })
      //             : // Render all recipes in the given category
      //             StreamBuilder(
      //                 stream: Firestore.instance
      //                     .collection('categories')
      //                     .document(categoryDoc.documentID)
      //                     .collection('recipes')
      //                     .snapshots() /* Stream all recipes in the chosen category */,
      //                 builder: (context, snapshot) {
      //                   if (snapshot == null ||
      //                       snapshot.data == null ||
      //                       snapshot.data.documents.length == 0) {
      //                     return Center(
      //                       child: Text(
      //                         'No recipes available under this category !',
      //                         style: TextStyle(
      //                           fontFamily: 'RobotoCondensed',
      //                           fontWeight: FontWeight.bold,
      //                           fontSize: 20,
      //                         ),
      //                       ),
      //                     );
      //                   } else {
      //                     return SingleChildScrollView(
      //                       controller: ScrollController(),
      //                       child: ListView.builder(
      //                         controller: ScrollController(),
      //                         shrinkWrap: true,
      //                         itemCount: snapshot.data.documents.length,
      //                         itemBuilder: (context, itemIdx) {
      //                           print(
      //                               'Item # $itemIdx: ${snapshot.data.documents[itemIdx]['title']}');
      //                           print(
      //                               'Gluten Free: ${snapshot.data.documents[itemIdx]['filters']['isGlutenFree']}');
      //                           print(
      //                               'Lactose Free: ${snapshot.data.documents[itemIdx]['filters']['isLactoseFree']}');
      //                           print(
      //                               'Vegan: ${snapshot.data.documents[itemIdx]['filters']['isVegan']}');
      //                           print(
      //                               'Vegetarian: ${snapshot.data.documents[itemIdx]['filters']['isVegetarian']}');

      //                           return RecipeItem(
      //                             // recipeTitle: filteredRecipes[itemIndex].recipeTitle,
      //                             // recipeId: filteredRecipes[itemIndex].recipeId,
      //                             // imageUrl: filteredRecipes[itemIndex].recipeImageUrl,
      //                             // cookingTime: filteredRecipes[itemIndex].cookingTime,
      //                             // cookingComplexity: getCookingComplexityAsString(
      //                             //     filteredRecipes[itemIndex].cookingComplexity),
      //                             // recipeAffordability: getRecipeAffordabilityAsString(
      //                             //     filteredRecipes[itemIndex].affordabilityOfRecipe),
      //                             recipeDetailDoc:
      //                                 snapshot.data.documents[itemIdx],
      //                             loadRecipeDetailsOnTap: () =>
      //                                 openRecipeDetailScreen(
      //                                     context,
      //                                     snapshot.data.documents[
      //                                         itemIdx] /*filteredRecipes[itemIndex].recipeId*/),
      //                           );
      //                         }, // itemBuilder
      //                       ),
      //                     ); // SingleChildScrollView
      //                   } // else-part
      //                 } // builder
      //                 ),
      //       ],
      //     ),
      //   ),
      // ),

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
