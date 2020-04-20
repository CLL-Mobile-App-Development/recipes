import 'package:flutter/material.dart';

import '../screens/filters_screen.dart';

class SideDrawer extends StatefulWidget { // Apparently stateful widget is needed to transmit data to next screen/page route by reference and retain changes to be rendered in later instances
                                          // So, StatelessWidget might be cutting-off the data stream in the app.
                                          // Hence, need Stateful widgets not just for widget re-paints, but also continuous data transmission in the app by reference.
  Map<String, bool>
      recipeSelectionFilters; // Not final as filters can be changed by the user.

  SideDrawer({this.recipeSelectionFilters});

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {

  Widget _buildAppNavLinkInContainer(BuildContext widgetContext,
      IconData linkIcon, String linkTitle, Function linkTapAction) {
    return Container(
      child: ListTile(
        leading: Icon(
          linkIcon,
          size: 26,
        ),
        title: Text(
          linkTitle,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        onTap: linkTapAction,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            height: 200,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).accentColor,
            child: Text(
              'I know, too many delicious recipes !',
              style: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),
          SizedBox(height: 20),
          _buildAppNavLinkInContainer(
              context, Icons.restaurant_menu, 'All Recipe Categories', () {
            Navigator.of(context).pushReplacementNamed(
              '/',
              arguments: widget.recipeSelectionFilters, // The filter selections set through the filters screen (passed by reference) will be passed on to the TabScreen.
                                                 // It will then be passed on down the categories and recipe details screens to filter the recipes based on user preferences.
            );
          }),
          _buildAppNavLinkInContainer(
              context, Icons.settings, 'Your Preferences', () {
            Navigator.of(context).pushNamed(
              FiltersScreen.screenRouteName,
              arguments: widget.recipeSelectionFilters,
            ).then((userRecipePreferences){ // Update filter settings, pop and push the app root by passing on the settings for retainment.
              widget.recipeSelectionFilters = userRecipePreferences;
              Navigator.of(context).popAndPushNamed('/', arguments: widget.recipeSelectionFilters);
            });
          }),
        ],
      ),
    );
  }
}
