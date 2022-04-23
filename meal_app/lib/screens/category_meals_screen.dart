import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import '../Widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> avilableMeals;

  CategoryMealsScreen(this.avilableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> displayedMeal;
  var _loadedinitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedinitData) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'].toString();
      final categoryid = routeArgs['id'];
      displayedMeal = widget.avilableMeals.where((meal) {
        return meal.categories.contains(categoryid);
      }).toList();
      _loadedinitData = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle.toString()),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayedMeal[index].id,
              title: displayedMeal[index].title,
              imageUrl: displayedMeal[index].imageUrl,
              duration: displayedMeal[index].duration,
              affordability: displayedMeal[index].affordability,
              complexity: displayedMeal[index].complexity,
            );
          },
          itemCount: displayedMeal.length,
        ));
  }
}
