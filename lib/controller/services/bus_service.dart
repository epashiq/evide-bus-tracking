import 'dart:convert';
import 'package:evide_bus_tracking_test/model/bus_stop_model.dart';
import 'package:flutter/services.dart';

class BusService {
  static const String assetsPath = 'assets/mock/stop.json';

  Future<List<BusStopModel>> fetchBusStops() async {
    try {
      final jsonString = await rootBundle.loadString(assetsPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      final List<dynamic> stops = jsonData['ktklTotir'] as List<dynamic>;

      return stops
          .map((json) => BusStopModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch bus stops: $e');
    }
  }

  
}
