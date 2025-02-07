import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:meals_app/screens/tabs.dart';
// import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.of(context).pop();
      //     if (identifier == 'meals') {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (ctx) => const TabsScreen(),
      //         ),
      //       );
      //     }
      //   },
      // ),
      body: Column(
        children: [
          _buildSwitch(context,
              title: 'Gluten-free',
              subtitle: 'Only include gluten-free meals.',
              value: activeFilters[Filter.glutenFree]!, onChanged: (isChecked) {
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.glutenFree, isChecked);
          }),
          _buildSwitch(
            context,
            title: 'Vegan',
            subtitle: 'Only include vegan meals.',
            value: activeFilters[Filter.vegan]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
          ),
          _buildSwitch(context,
              title: 'Lactose-free',
              subtitle: 'Only include lactose-free meals.',
              value: activeFilters[Filter.lactoseFree]!,
              onChanged: (isChecked) {
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.lactoseFree, isChecked);
          }),
          _buildSwitch(context,
              title: 'Vegetarian',
              subtitle: 'Only include vegetarian meals.',
              value: activeFilters[Filter.vegetarian]!, onChanged: (isChecked) {
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.vegetarian, isChecked);
          }),
        ],
      ),
    );
  }

  Widget _buildSwitch(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
