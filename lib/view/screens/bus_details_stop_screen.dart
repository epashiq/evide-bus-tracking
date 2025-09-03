import 'package:evide_bus_tracking_test/controller/provider/bus_provider.dart';
import 'package:evide_bus_tracking_test/model/bus_stop_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BusDetailsStopScreen extends StatelessWidget {
  final BusStopModel stop;
  const BusDetailsStopScreen({super.key, required this.stop});

  String getETA() {
    final minutes = ((stop.latitude + stop.longitude).abs() % 10).toInt();
    return '$minutes min ETA';
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BusProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(stop.stopname,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(
              stop.isFavorite ? Icons.favorite : Icons.favorite_outline,
              color: stop.isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () => provider.toggleFavorite(stop),
          ),
        ],
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stop Info Card
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.directions_bus,
                            size: 28, color: Colors.blue),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            stop.stopname,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.confirmation_number,
                            color: Colors.grey),
                        const SizedBox(width: 8),
                        Text("Stop ID: ${stop.stopname}",
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.green),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Lat: ${stop.latitude}, Lng: ${stop.longitude}",
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ETA Card
            Card(
              color: Colors.blue.shade50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Row(
                  children: [
                    const Icon(Icons.access_time, color: Colors.blue, size: 28),
                    const SizedBox(width: 12),
                    Text(
                      "ETA: ${getETA()}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.map),
                  label: const Text("View on Map"),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.directions),
                  label: const Text("Get Directions"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
