import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/recipe.dart';


class RecipeDetailsScreen extends StatefulWidget {
  static const screenRouteName = '/recipe-details-screen';

  @override
  _RecipeDetailsScreenState createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  var screenRouteArgs;
  DocumentSnapshot recipeDoc;
  String recipeId;
  List<Recipe> favorites;
  Map<String, bool> filters;
  Recipe userChosenRecipe;
  bool isInitialScreenLoad =
      true; // To control when the arguments are to be extracted and initial data is loaded on the screen.
  // This flag is used to prevent data initialization each time the build method is run.
  Future<bool>
      isChosenRecipeAFavoriteFut; // Flag to signify the user-liking to the recipe.
  //var isChosenRecipeAFavorite; // declared as var (variable), as FutureBuilder may or may not retrieve a bool.
  // It can also return a null if there is no match.
  String matchingBackEndFavRecDocID =
      ""; // To store the document id of matching favorite recipe document in cloud firestore backend.

  Widget buildContainerTitle(
      BuildContext widgetContext, String containerTitle) {
    return Text(
      containerTitle,
      style: Theme.of(widgetContext).textTheme.headline6,
    );
  }

  Widget buildContainerList(Widget listWidget) {
    return Container(
      height: 150,
      width: 300,
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: listWidget,
    );
  }

  Widget buildContainerWithTitleAndList(
      BuildContext widgetContext, final title, Widget listWidget) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          buildContainerTitle(widgetContext, title),
          buildContainerList(listWidget), // end of buildContainerList
        ],
      ),
    );
  }

  void recipeDeleteAction(BuildContext widgetContext, String recipeId) {
    Navigator.of(widgetContext).pop(recipeId);
  }

  Future<bool> isRecipeAFavorite() {
    // return favorites.any((currFavRecipe) {
    //   return currFavRecipe.recipeId == userChosenRecipe.recipeId;
    // });

    return Firestore.instance
        .collection('users')
        .document('admin')
        .collection('favorite_recipes')
        .snapshots()
        .any((favRecSnapshot) {
      List<DocumentSnapshot> matFavRecList =
          favRecSnapshot.documents.where((recDocSnapshot) {
        if (recDocSnapshot['recipeId'] == recipeDoc['recipeId']) {
          matchingBackEndFavRecDocID = recDocSnapshot
              .documentID; // A side-effect in the test to capture the mathcing document's id.
          // This is a state class attribute and will be used in marking a recipe
          // as a favorite through appropriate add/delete operation in cloud firestore.
        }

        return recDocSnapshot['recipeId'] == recipeDoc['recipeId'];
      }).toList();

      return matFavRecList.length > 0;
    });
  }

  @override
  void didChangeDependencies() {
    if (isInitialScreenLoad) {
      // fetching the recipe-id passed in by the /category-recipes screen while mounting this screen on to the Navigator stack
      screenRouteArgs =
          ModalRoute.of(context).settings.arguments as Map<String, Object>;

      recipeDoc = screenRouteArgs['recipeDoc'];
      //recipeId = screenRouteArgs['recipeId'];
      //favorites = screenRouteArgs['favorites'] as List<Recipe>;
      filters = screenRouteArgs['filters'] as Map<String, bool>;
      // userChosenRecipe = DUMMY_RECIPES.firstWhere((recipe) {
      //   return recipe.recipeId ==
      //       recipeDoc['recipeId']; // test returning a bool for each recipe. First recipe passing the test will be
      //   // returned by the firstWhere method.
      // });

      isInitialScreenLoad =
          false; // To prevent data initialization with the next widget re-paint on state change.
    }

    super.didChangeDependencies();
  }

  // Function to add/remove the chosen recipe to/from the favorites list of recipes
  void switchStateOfRecipeAsFavorite() {
    // Commented out setState() as Firestore data write automatically triggers a widget rebuild.
    //setState((){

    // var matchingFavRecDoc; // declared as variable to account for null or valid DocumentSnatshot retrieved from the Future<DocumentSnapshot>

    // // Widget returned by FutureBuilder is discarded. only purpose to extract value from future.
    // FutureBuilder(future: getMatchingFavRecDoc(widgetCxt), builder: (widgetCxt, favRecDocSnapshot){
    //      matchingFavRecDoc = favRecDocSnapshot.data as DocumentSnapshot;
    //      return Text("");
    // });

    if (matchingBackEndFavRecDocID == "") {
      // not a favorite
      //favorites.remove(userChosenRecipe);
      print(
          'Retrieved FavRecDoc is null, recipe ${recipeDoc['title']} is not a favorite');
      Firestore.instance
          .collection('users')
          .document('admin')
          .collection('favorite_recipes')
          .add(recipeDoc.data);
      print('Added recipe ${recipeDoc['title']} to the favorites');
    } else {
      // has non-empty document id, so, is a favorite
      //favorites.add(userChosenRecipe);
      print(
          'Retrieved FavRecDoc is non-null, recipe ${recipeDoc['title']} is a favorite');

      // Apparently, deletes in cloud firestore do not have auto-triggers for widget rebuilds.
      setState(() {
        Firestore.instance
            .collection('users')
            .document('admin')
            .collection('favorite_recipes')
            .document(matchingBackEndFavRecDocID)
            .delete();
      });

      matchingBackEndFavRecDocID =
          ""; // document id is being reset as it has been deleted from cloud firestore
      // and to have a cleaner code in line with the logic to check against "" (empty string)
      // in the next widget rebuild. Doesn't impact thr execution as even if it not reset,
      // its access won't be possible given that it is no longer part of the database.
      // This is being done as the variable is part of the state class and not the build method.
      print('Removed recipe ${recipeDoc['title']} from favorites');
    }

    //});
  }

  @override
  Widget build(BuildContext context) {
    isChosenRecipeAFavoriteFut =
        isRecipeAFavorite(); // Method to run a query on cloud firestore database to render a Future<bool>
    // returned by the query result that checks if recipeDoc is currently stored
    // as a favorite recipe.
    // Code below renders the appropriate star icon widget based on bool value extracted
    // from the Future<bool> through FutureBuilder.

    List<dynamic> recIngredients = recipeDoc['ingredients']; //as List<dynamic>;
    print('recipe ingredients: $recIngredients');

    List<dynamic> recSteps = recipeDoc['steps']; // as List<String>;
    print('recipe steps: $recSteps');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          //userChosenRecipe.recipeTitle,
          recipeDoc['title'],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.network(
              //userChosenRecipe.recipeImageUrl,
              recipeDoc['imageUrl'],
              height: 250,
              width: double.infinity,
              fit: BoxFit
                  .cover, // The given height and width settings create a box for the BoxFit to be applied.
            ),
            // Builds container widget with title "Ingredients" and corresponding list of ingredients with ListView.builder
            buildContainerWithTitleAndList(
              context,
              'Ingredients',
              ListView.builder(
                itemBuilder: (itemContext, itemIndex) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(
                        //'${userChosenRecipe.recipeIngredients[itemIndex]}',
                        //recIngredients[itemIndex],// as String,
                        recipeDoc['ingredients'][itemIndex],
                      ),
                    ),
                    elevation: 5,
                    color: Theme.of(context).accentColor,
                    margin: EdgeInsets.all(6),
                  );
                },
                //itemCount: userChosenRecipe.recipeIngredients.length,
                //itemCount: recIngredients.length
                itemCount: recipeDoc['ingredients'].length,
              ),
            ),
            buildContainerWithTitleAndList(
              context,
              'Steps',
              ListView.builder(
                itemBuilder: (itemContext, itemIndex) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          radius: 15,
                          child: FittedBox(
                              fit: BoxFit.cover,
                              child: Text('# ${itemIndex + 1}')),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          child: Text(
                            //'${userChosenRecipe.recipeSteps[itemIndex]}',
                            //recSteps[itemIndex],// as String,
                            recipeDoc['steps'][itemIndex],
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  );
                },
                //itemCount: userChosenRecipe.recipeSteps.length,
                //itemCount: recSteps.length,
                itemCount: recipeDoc['steps'].length,
              ),
            ), // end of buildContainerWithTitleAndList
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // FutureBuilder is a way to retrieve data from the future outside StreamBuilder.
        // However, still need to return a widget, possibly based on the retrieved data.
        child: FutureBuilder(

            // Why is isChosenRecipeAFavoriteFut holding a true value even when there is no matching favorite recipe in cloud firestore ???????
            // Possibly because with the delete, the stream does not change unlike the push with an add and hence an explicit call to setState is needed (still skeptical)
            future: isChosenRecipeAFavoriteFut,
            builder: (context, futAsyncSnapshot) {
              var isChosenRecipeAFavorite = futAsyncSnapshot.data;
              //as bool; // Setting the extracted bool here to be used in switchStateOfRecipeAsFavorite
              // for appropriate action.
              if (isChosenRecipeAFavorite == null ||
                  isChosenRecipeAFavorite == false ||
                  matchingBackEndFavRecDocID == "") {
                print(
                    'FavRec Future<bool> returned $isChosenRecipeAFavorite of type ${isChosenRecipeAFavorite.runtimeType}, recipe ${recipeDoc['title']} is not a favorite');
                return Icon(
                  Icons.star_border,
                );
              } else {
                // non-null, meaning a favorite
                print(
                    'FavRec Future<bool> returned $isChosenRecipeAFavorite of type ${isChosenRecipeAFavorite.runtimeType}, recipe ${recipeDoc['title']} is a favorite');
                return Icon(
                  Icons.star,
                  //color: Colors.red,
                );
              }
            }), //isChosenRecipeAFavorite
        onPressed: switchStateOfRecipeAsFavorite,
        //backgroundColor: Colors.white.withOpacity(0.7),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
