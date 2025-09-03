
import 'package:evide_bus_tracking_test/controller/services/bus_service.dart';
import 'package:evide_bus_tracking_test/model/bus_stop_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusProvider with ChangeNotifier {
  final BusService busService = BusService();
  List<BusStopModel> stops = [];
  List<BusStopModel> filteredStops = [];
  Set<String> favoriteIds = {};
  bool isLoading = false;

  Future<void> fetchBusStops() async {
    isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    favoriteIds = prefs.getStringList('favorites')?.toSet() ?? {};

    final allStops = await busService.fetchBusStops();
    stops = allStops
        .map((stop) =>
            stop.copyWith(isFavorite: favoriteIds.contains(stop.stopname)))
        .toList();

    filteredStops = stops;
    isLoading = false;
    notifyListeners();
  }

  void searchStops(String query) {
    if (query.isEmpty) {
      filteredStops = stops;
    } else {
      filteredStops = stops
          .where((stop) =>
              stop.stopname.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<void> toggleFavorite(BusStopModel stop) async {
    final prefs = await SharedPreferences.getInstance();
    if (favoriteIds.contains(stop.stopname)) {
      favoriteIds.remove(stop.stopname);
    } else {
      favoriteIds.add(stop.stopname);
    }
    await prefs.setStringList('favorites', favoriteIds.toList());

    stops = stops
        .map((s) => s.stopname == stop.stopname
            ? s.copyWith(isFavorite: !s.isFavorite)
            : s)
        .toList();

    searchStops(""); 
  }
}
