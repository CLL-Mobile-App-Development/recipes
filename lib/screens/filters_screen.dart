import 'package:flutter/material.dart';
import '../widgets/side_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const screenRouteName = '/filters-screen';

  Map<String, bool> filters;

  FiltersScreen({@required this.filters,});

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool isInitialScreenLoad =
      true; // Initial value set to true, to allow the data sent by parent by parent screen to be loaded onlye once at widget creation.
  // That way, any settings changed by the user later can be retained and displayed on this screen page.

  //Map<String, bool>
    //  recipeFilterSettings; // Stores and maintains the user chosen recipe filter settings.

  // Recipe filter flags
  bool doesUserWantGluten = false;
  bool doesUserWantLactose = false;
  bool doesUserWantVegan = false;
  bool doesUserWantVegetarian = false;

  bool getFilterState(String filterName) {
    if (filterName == 'Gluten')
      return doesUserWantGluten;
    else if (filterName == 'Lactose')
      return doesUserWantLactose;
    else if (filterName == 'Vegan')
      return doesUserWantVegan;
    else //(filterName == 'Vegetarian')
      return doesUserWantVegetarian; // Equivalent of getter for filterState, where its current state is assigned to the "value"
  }

  Widget _buildRecipeFilter(String filterName) {
    return SwitchListTile(
      title: Text(filterName),
      value: getFilterState(filterName),
      onChanged: (newState) {
        setState(() {
          if (filterName == 'Gluten')
            doesUserWantGluten = newState;
          else if (filterName == 'Lactose')
            doesUserWantLactose = newState;
          else if (filterName == 'Vegan')
            doesUserWantVegan = newState;
          else // if (filterName == 'Lactose')
            doesUserWantVegetarian = newState;
        });
      },
    );
  }

  @override
  void didChangeDependencies() {
    if (isInitialScreenLoad) {
      widget.filters =
          ModalRoute.of(context).settings.arguments as Map<String, bool>;

      doesUserWantGluten = widget.filters['gluten'];
      doesUserWantLactose = widget.filters['lactose'];
      doesUserWantVegan = widget.filters['vegan'];
      doesUserWantVegetarian = widget.filters['vegetarian'];

      isInitialScreenLoad =
          false; // to avoid data-reset on further widget re-builds.
    }

    super.didChangeDependencies();
  }

  void filterButtonAction(){

    widget.filters = {
      'gluten' : doesUserWantGluten,
      'lactose' : doesUserWantLactose,
      'vegan' : doesUserWantVegan,
      'vegetarian' : doesUserWantVegetarian,
    };

    print('On button press, gluten setting: ${widget.filters['gluten']}');
    print('On button press, gluten setting: ${widget.filters['lactose']}');
    print('On button press, gluten setting: ${widget.filters['vegan']}');
    print('On button press, gluten setting: ${widget.filters['vegetarian']}');

    Navigator.of(context).pop(widget.filters); // Just pop, the side drawer underneath will capture the thrown data and pass it on to rest of the app.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Preferences',
        ),
      ),
      drawer: SideDrawer(),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                'Filter recipes to your liking !',
                style: Theme.of(context).textTheme.title,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _buildRecipeFilter(
            'Gluten',
          ),
          _buildRecipeFilter(
            'Lactose',
          ),
          _buildRecipeFilter(
            'Vegan',
          ),
          _buildRecipeFilter(
            'Vegetarian',
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            child: Text(
              'Filter',
              style: TextStyle(
                fontFamily: 'RobotoCondensed',
                //fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            color: Theme.of(context).accentColor,
            onPressed: filterButtonAction,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            padding: EdgeInsets.all(10),
          ),
        ],
      ),
    );
  }
}
