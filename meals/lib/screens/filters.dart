import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:meals/screens/tabs.dart';
// import 'package:meals/widgets/main_drawer.dart';

import 'package:meals/providers/filters_providers.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
    // required this.currentFilters, // Data nyt providerissa
  });

  // final Map<Filter, bool> currentFilters;

// Otetaan state pois ja käytetään provider state => stateless widget
//   @override
//   ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
// }

// class _FiltersScreenState extends ConsumerState<FiltersScreen> {
//   var _glutenFreeFilterSet = false;
//   var _lactoseFreeFilterSet = false;
//   var _vegetarianFilterSet = false;
//   var _veganFilterSet = false;

  // ctrl - pohjassa, k, c = kommentit
  // ctrl - pohjassa, k, u = poisto
  // widget käytettävissä vain jonkin metodin sisällä
  // @override
  // void initState() {
  //   super.initState();
  //   // Luetaan data kertaalleen
  //   final activeFilters = ref.read(filtersProvider);
  //   _glutenFreeFilterSet = activeFilters[Filter.glutenFree]!;
  //   _lactoseFreeFilterSet = activeFilters[Filter.lactoseFree]!;
  //   _vegetarianFilterSet = activeFilters[Filter.vegetarian]!;
  //   _veganFilterSet = activeFilters[Filter.vegan]!;
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      // drawer: MainDrawer(onSelectScreen: (identifier) {
      //   Navigator.of(context).pop(); //Suljetaan drawer
      //   if (identifier == 'meals') {
      //     Navigator.of(context).push(
      //       MaterialPageRoute(
      //         builder: (ctx) => const TabsScreen(),
      //       ),
      //     );
      //   }
      // }),
      body:
          // WillPopScope(
          //   // Kun funktio on async, sen palautus arvo paketoidaan futuurin
          //   onWillPop: () async {
          //     // Päivitetään provider, eventin sisällä, joten suositellaan read()
          //     // Halutaan käyttää providerin metodia, joten pitää hakea notifier objekti
          //     ref.read(filtersProvider.notifier).setFilters({
          //       // Luodaan uusi map objekti, huomioi aaltosulut ympärillä
          //       Filter.glutenFree: _glutenFreeFilterSet,
          //       Filter.lactoseFree: _lactoseFreeFilterSet,
          //       Filter.vegetarian: _vegetarianFilterSet,
          //       Filter.vegan: _veganFilterSet,
          //     });

          // Navigator.of(context).pop({
          // Avain: Arvo
          // Enum käyttö lähinnä helpottaa datan lukua
          // Filter.glutenFree: _glutenFreeFilterSet,
          // Filter.lactoseFree: _lactoseFreeFilterSet,
          // Filter.vegetarian: _vegetarianFilterSet,
          // Filter.vegan: _veganFilterSet,

          // glutenFree: true,
          // lactoseFree: false,
          // vegetarian: false,
          // vegan: true,
          // });
          // return true; // Tämä määrittää suoritetaanko pop vai ei
          // Koska suoritamme pop itse ja sen mukana data, ei tarvita pop uudestaan
          // },
          // child:
          Column(
        children: [
          SwitchListTile(
            // Kaikki filterit on alustettu providerissa, joten voi käyttää !
            value: activeFilters[Filter.glutenFree]!,
            onChanged: (isChecked) {
              // setState(() {
              //   _glutenFreeFilterSet = isChecked;
              // });
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
            },
            title: Text(
              'Gluten-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include gluten-free meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filter.lactoseFree]!,
            // value: _lactoseFreeFilterSet,
            onChanged: (isChecked) {
              // setState(() {
              //   _lactoseFreeFilterSet = isChecked;
              // });
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
            title: Text(
              'Lactose-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include lactose-free meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            // value: _vegetarianFilterSet,
            value: activeFilters[Filter.vegetarian]!,
            onChanged: (isChecked) {
              // setState(() {
              //   _vegetarianFilterSet = isChecked;
              // });
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
            },
            title: Text(
              'Vegetarian',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include vegetarian meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            // value: _veganFilterSet,
            value: activeFilters[Filter.vegan]!,
            onChanged: (isChecked) {
              // setState(() {
              //   _veganFilterSet = isChecked;
              // });
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
            title: Text(
              'Vegan',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include vegan meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          )
        ],
      ),
      // ), // OnWillPopScope
    );
  }
}
