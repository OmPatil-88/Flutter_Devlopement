import 'package:flutter/material.dart';
import 'package:meal_app/Widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegan = false;
  bool _vegetarian = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters["gluten"] as bool;
    _vegan = widget.currentFilters['vegan'] as bool;
    _vegetarian = widget.currentFilters['vegetarian'] as bool;
    _lactoseFree = widget.currentFilters['lactose'] as bool;
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String subtitle, bool currentvalue,
      Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title, style: Theme.of(context).textTheme.headline6),
      value: currentvalue,
      subtitle: Text(subtitle),
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter"),
        actions: [
          IconButton(
              onPressed: () {
                final _selectedFilters = {
                  'gluten': _glutenFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                  'lactose': _lactoseFree
                };
                widget.saveFilters(_selectedFilters);
              },
              icon: Icon(Icons.save))
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection.",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                    'Gluten-free', 'only gluten-free meal', _glutenFree,
                    (newval) {
                  setState(() {
                    _glutenFree = newval;
                  });
                }),
                _buildSwitchListTile('Vegan', 'only vegan meal', _vegan,
                    (newval) {
                  setState(() {
                    _vegan = newval;
                  });
                }),
                _buildSwitchListTile(
                    'Vegetarian', 'only Vegetarian meal', _vegetarian,
                    (newval) {
                  setState(() {
                    _vegetarian = newval;
                  });
                }),
                _buildSwitchListTile(
                    'Lactose-free', 'only Lactose-free meal', _lactoseFree,
                    (newval) {
                  setState(() {
                    _lactoseFree = newval;
                  });
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
