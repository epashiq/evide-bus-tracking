
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

  Future<void> loadStops() async {
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

  
}
