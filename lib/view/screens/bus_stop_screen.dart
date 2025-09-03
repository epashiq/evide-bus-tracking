import 'package:evide_bus_tracking_test/controller/provider/bus_provider.dart';
import 'package:evide_bus_tracking_test/view/screens/bus_details_stop_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BusStopScreen extends StatefulWidget {
  const BusStopScreen({super.key});

  @override
  State<BusStopScreen> createState() => _BusStopScreenState();
}

class _BusStopScreenState extends State<BusStopScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<BusProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.fetchBusStops();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "🚍 Bus Stops",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by stop name...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                context.read<BusProvider>().searchStops(value);
              },
            ),
          ),
        ),
      ),
      body: Consumer<BusProvider>(
        builder: (context, busPro, _) {
          if (busPro.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (busPro.filteredStops.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.bus_alert, size: 64, color: Colors.grey),
                  const SizedBox(height: 12),
                  Text(
                    'No bus stops found',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: busPro.filteredStops.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final stop = busPro.filteredStops[index];
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundColor: colorScheme.primary.withOpacity(0.15),
                        child: Icon(
                          Icons.location_on,
                          color: colorScheme.primary,
                        ),
                      ),
                      title: Text(
                        stop.stopname,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        "Lat: ${stop.latitude}, Lng: ${stop.longitude}",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          stop.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: stop.isFavorite
                              ? Colors.red
                              : Colors.grey.shade500,
                        ),
                        onPressed: () {
                          context.read<BusProvider>().toggleFavorite(stop);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                stop.isFavorite
                                    ? "Removed from favorites"
                                    : "Added to favorites",
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
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
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
