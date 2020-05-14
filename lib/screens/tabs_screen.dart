import 'package:flutter/material.dart';

import './categories_screen.dart';
import './favorites_screen.dart';
import '../widgets/side_drawer.dart';

class TabsScreen extends StatefulWidget {
  var favorites;
  var filters;

  TabsScreen({
    @required this.favorites,
    @required this.filters,
  });

  @override
  State<StatefulWidget> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Widget> tabScreens = [];

  @override
  void initState() {
    super.initState();

    tabScreens.add(CategoriesScreen(
      favorites: widget.favorites,
      filters: widget.filters,
    ));

    tabScreens.add(FavoritesScreen(
      favorites: widget.favorites,
      recipeFilters: widget.filters,
    ));
  }

  @override
  void didChangeDependencies() {
    var recipeFilters =
        ModalRoute.of(context).settings.arguments as Map<String, bool>;

    if (recipeFilters != null) {
      // Meaning, user recipe preferences are available for custom recipe selection in the app.
      widget.filters = recipeFilters;

      // Update the CategoriesScreen tab widget with the new data, after the initState method, where default settings are available.
      // First remove the entry by matching its type
      tabScreens.removeWhere((tabWidget) {
        return tabWidget.runtimeType == CategoriesScreen;
      });

      tabScreens.removeWhere((tabWidget) {
        return tabWidget.runtimeType == FavoritesScreen;
      });

      // Then, add/insert its instance again at index 0 with updated data.
      tabScreens.insert(
          0,
          CategoriesScreen(
            favorites: widget.favorites,
            filters: widget.filters,
          ));

      tabScreens.insert(
          1,
          FavoritesScreen(
            favorites: widget.favorites,
            recipeFilters: widget.filters,
          ));
    }

    super.didChangeDependencies();
  }

  int _currentTabIndex = 0; // By default select first tab.

  void _loadSelectedTabScreen(int userChosenTabIndex) {
    // Set the current tab index as the one chosen by the user. This will re-paint the widget to load the appropriate tab screen.
    setState(() {
      _currentTabIndex = userChosenTabIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (_currentTabIndex == 0)
            ? Text('Lakshmi\'s Cookbook - Categories')
            : Text('Lakshmi\'s Cookbook - Favorites'),
      ),
      drawer: SideDrawer(
        recipeSelectionFilters: widget.filters,
      ),
      body: tabScreens[_currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _loadSelectedTabScreen,
        currentIndex:
            _currentTabIndex, // This is to be set to give Flutter info about which tab has been selected and for
        // properties like [selected/unselected]ItemColor to be applied in app real-time.
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category,
            ),
            title: Text(
              'Categories',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            title: Text(
              'Favorites',
            ),
          ),
        ],
      ),
    );
  }
}
