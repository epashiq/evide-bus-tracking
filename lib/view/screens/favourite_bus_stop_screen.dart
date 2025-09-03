import 'package:evide_bus_tracking_test/controller/provider/bus_provider.dart';
import 'package:evide_bus_tracking_test/view/screens/bus_details_stop_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteBusStopScreen extends StatelessWidget {
  const FavoriteBusStopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Stops"),
        elevation: 2,
      ),
      body: Consumer<BusProvider>(
        builder: (context, busPro, _) {
          final favoriteStops =
              busPro.stops.where((stop) => stop.isFavorite).toList();

          if (favoriteStops.isEmpty) {
            return const Center(
              child: Text(
                "No favorite stops yet",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: favoriteStops.length,
            itemBuilder: (context, index) {
              final stop = favoriteStops[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  leading: const Icon(Icons.directions_bus,
                      size: 28, color: Colors.blue),
                  title: Text(
                    stop.stopname,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text(
                    "Lat: ${stop.latitude}, Lng: ${stop.longitude}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () => busPro.toggleFavorite(stop),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BusDetailsStopScreen(stop: stop),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
