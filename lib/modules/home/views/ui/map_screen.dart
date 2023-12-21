import 'package:devanshhooda/modules/home/views/widgets/station_bar.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        const Center(child: Text("Map will come here")),
        Positioned(
          left: 7.5,
          right: 7.5,
          top: screenSize.height * 0.75,
          child: SizedBox(
            height: screenSize.height / 10,
            width: screenSize.width - 10,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) => const StationBar()),
                separatorBuilder: ((context, index) => const SizedBox(
                      width: 20,
                    )),
                itemCount: 10),
          ),
        )
      ],
    );
  }
}
