import 'package:devanshhooda/data/models/station_model/station_model.dart';
import 'package:flutter/material.dart';

class StationBar extends StatelessWidget {
  const StationBar({super.key, required this.stationData});
  final StationModel stationData;

  @override
  Widget build(BuildContext context) {
    final String fullAddress =
        "${stationData.street1}, ${stationData.street2}, ${stationData.city}";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.white, width: 1.5),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(stationData.name ?? '',
              style:
                  const TextStyle(fontSize: 17.5, fontWeight: FontWeight.bold)),
          Expanded(child: Text(fullAddress))
        ],
      ),
    );
  }
}
