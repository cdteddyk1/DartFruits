import 'package:flutter/material.dart';
import 'fruit.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class FruitPreview extends StatefulWidget {
  const FruitPreview({
    Key? key,
    required this.fruit,
    required this.onAddFruit,
  }) : super(key: key);

  final Fruit fruit;
  final Function(int, Fruit, double) onAddFruit;

  @override
  State<StatefulWidget> createState() => _FruitPreviewState();
}

class _FruitPreviewState extends State<FruitPreview> {
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fruit.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Expanded(

                child: Row(

              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  
                Image.asset(
                  'fruits/${widget.fruit.name.toLowerCase()}.png',
                ),

                Expanded(

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround ,

                    children: [

                      Text(
                        'Origin: ${widget.fruit.origin.name }',
                        style: const TextStyle(fontSize: 20),
                      ),

                      Text(
                        'Saison: ${widget.fruit.season}',
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.right,
                      ),

                      Text(
                        'Stock: ${widget.fruit.stock.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 20),
                      ),

                      Text(
                        "Tarif à l'unité : ${widget.fruit.price.toStringAsFixed(2)}",
                        style: const TextStyle(fontSize: 20),
                      ),

                      Text(
                        "Quantité : ${widget.fruit.quantity}",
                        style: const TextStyle(fontSize: 20),
                      ),

                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _quantity++;
                            widget.onAddFruit(widget.fruit.id, widget.fruit,
                                widget.fruit.price);
                          });
                        },
                        child: const Text('Add to Cart'),
                      ),

                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            )),

            Expanded(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(
                      widget.fruit.origin.location.coordinates[0] > 90
                          ? 90
                          : widget.fruit.origin.location.coordinates[0],
                      widget.fruit.origin.location.coordinates[1] < -90
                          ? 90
                          : widget.fruit.origin.location.coordinates[1]),
                  zoom: 9.2,
                ),
                nonRotatedChildren: [
                  AttributionWidget.defaultWidget(
                    source: 'OpenStreetMap contributors',
                    onSourceTapped: null,
                  ),
                ],

                children: [

                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(
                            widget.fruit.origin.location.coordinates[0] > 90
                                ? 90
                                : widget.fruit.origin.location.coordinates[0],
                            widget.fruit.origin.location.coordinates[1] < -90
                                ? 90
                                : widget.fruit.origin.location.coordinates[1]),
                        builder: (ctx) => const Icon(Icons.location_on),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
