import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';


import '/models/city_model.dart';
import '/providers/cities_provider.dart';
import '/providers/weather_provider.dart';
import '/services/cities_service.dart';

class SearchPage extends ConsumerStatefulWidget {
  final LinearGradient gradient;

  const SearchPage({super.key, required this.gradient});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState(gradient: gradient);
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final LinearGradient gradient;

  _SearchPageState({required this.gradient});

  @override
  Widget build(BuildContext context) {
    final favourites = ref.watch(cityFavouritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Search Page"),
        backgroundColor: gradient.colors[0],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: gradient,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: <Widget>[
                TypeAheadField<City>(
                  builder: (context, textController, focusNode) {
                    return TextField(
                      controller: textController,
                      focusNode: focusNode,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Search city",
                        hintStyle: TextStyle(color: Colors.white60),
                        border: OutlineInputBorder(),
                      ),
                    );
                  },
                  debounceDuration: Duration(milliseconds: 500),
                  itemBuilder: (context, city) {
                    return ListTile(
                      title: Text('${city.name}, ${city.country}'),
                      trailing: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          addCityToFavourites(city);
                          ref.invalidate(cityFavouritesProvider);
                        },
                      ),
                    );
                  },
                  suggestionsCallback: (pattern) async {
                    if (pattern.length < 2) return [];
                    return await getCities(pattern);
                  },
                  onSelected: (city) {
                    ref.read(locationRequestProvider.notifier).state = WeatherRequest(
                      lat: city.latitude,
                      lon: city.longitude,
                      city: city
                    );
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 20),
                Text(
                  "Favourite Cities:",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                //show favourites
                favourites.when(
                  data: (favs) => Container(
                    height: MediaQuery.sizeOf(context).height - 250,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: favs.map((city) => TextButton(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16)
                              ),
                              child: ListTile(
                                title: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    '${city.name}, ${city.country}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.remove, color: Colors.white,),
                                  onPressed: () {
                                    removeCityToFavourites(city);
                                    ref.invalidate(cityFavouritesProvider);
                                  },
                                ),
                              ),
                            ),
                            onPressed: () {
                              ref.read(locationRequestProvider.notifier).state = WeatherRequest(
                                lat: city.latitude,
                                lon: city.longitude,
                                city: city
                              );
                              Navigator.pop(context);
                            },
                          ),
                        ).toList(),
                      ),
                    ),
                  ),
                  loading: () => Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  error: (e, _) => Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Could not get favourite locations",
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
