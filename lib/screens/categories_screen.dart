import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../widgets/category_item.dart';

/*******************************************************************************
 * IMPORTANT OBSERVATION:                                                      *
 * ----------------------                                                      *
 * When rendering data from a database in the backend, like cloud firestore    *
 * here, incorporate logic to handle delays in data trasfer over the network   *
 * such that the logic to access and display data is run only after it has     *
 * been successfully rendered. Since cloud firestore is a NoSQL database with  *
 * data organized in collections and documents, make sure the snapshot or      *
 * actual data in the snapshot.data instance is non-null, before accessing     *
 * data in individual documents and building/displaying data through widgets   *
 * in the app.                                                                 * 
 * 
 * If the user is on high speed network, the delay may not be visible in the   *
 * app, but, a console error still appears. Having code that handles network   *
 * events and gives a more tailored UI to users can lead to better user        *
 * experience and a more round-about code, which also gives a sense of         *
 * progress to users on more slower networks.                                  *
 *******************************************************************************/

class CategoriesScreen extends StatefulWidget {
  static const screenRouteName = '/categories';

  List<Recipe> favorites;
  Map<String, bool> filters;

  CategoriesScreen({
    @required this.favorites,
    @required this.filters,
  });

  State<StatefulWidget> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    // As this screen will now be displayed in a body of a tab that already has a Scaffold
    // in its controller widget, only the GridView widget in the body is being returned.
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: StreamBuilder(
          stream: Firestore.instance.collection('categories').snapshots(),
          builder: (context, snapshot) {
            // Using GridView.builder instead of GridView for a more cleaner code, even though there are only a handful
            // of categories and not a big list. So, builder constructor wouldn't help much in terms of run-time performance.
            // Also, the builder does the iteration to build one item at a time, rather than the full document list, like in
            // the case of just the GridView.

            if (snapshot == null || snapshot.data == null) {
              // To handle delay in data transfer over the network through an appropriate message on the UI to keep user informed of progress.
              // Also to avoid any error messages in the console if there is a null pointer reference in the app, because of rhe delay in stream data.
              return Center(
                child: Text(
                  'Rendering recipe categories...',
                  style: Theme.of(context).textTheme.headline6,
                ),
              );
            } else if (snapshot.data.documents.length == 0) {
              // Similarly, if there is no data in the backend to render, display a message indicating the same.
              return Center(
                child: Text(
                  'No recipe categories to display !',
                  style: Theme.of(context).textTheme.headline6,
                ),
              );
            } else {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 /
                      2, // Height / Width ratio. Here the height = 300, when width = 200 through maxCrossAxisExtent set to 200.
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, catDocIdx) {
                  return CategoryItem(
                    categoryItemDocument: snapshot.data.documents[catDocIdx],
                    favorites: widget.favorites,
                    filters: widget.filters,
                  );
                },
              );
            }
          }),
    );
  }
}
