import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
          Filter.vegetarian: false,
        });

  void setFilters(Map<Filter, bool> choosenFilters) {
    state = choosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

final filterMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeProvider = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (activeProvider[Filter.glutenFree]! && meal.isGlutenFree) {
      return false;
    }
    if (activeProvider[Filter.lactoseFree]! && meal.isLactoseFree) {
      return false;
    }
    if (activeProvider[Filter.vegetarian]! && meal.isVegetarian) {
      return false;
    }
    if (activeProvider[Filter.vegan]! && meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
