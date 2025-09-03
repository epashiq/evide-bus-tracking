import 'package:evide_bus_tracking_test/controller/provider/bus_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BusStopPage extends StatefulWidget {
  const BusStopPage({super.key});

  @override
  State<BusStopPage> createState() => _BusStopPageState();
}

class _BusStopPageState extends State<BusStopPage> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<BusProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.loadStops();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BusProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Bus Stops'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search stop...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  provider.searchStops(value);
                },
              ),
            ),
          ),
        ),
        body: Consumer<BusProvider>(
          builder: (context, busPro, _) {
            if (busPro.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (busPro.stops.isEmpty) {
              return const Center(
                  child: Text(
                'No data available',
                style: TextStyle(color: Colors.red),
              ));
            } else {
              return ListView.builder(
                itemCount: busPro.filteredStops.length,
                itemBuilder: (context, index) {
                  final stop = busPro.filteredStops[index];
                  return ListTile(
                    title: Text(stop.stopname),
                    subtitle:
                        Text('Lat: ${stop.latitude}, Lng: ${stop.longitude}'),
                    onTap: () {},
                  );
                },
              );
            }
          },
        ));
  }
}
