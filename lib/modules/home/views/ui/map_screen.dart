import 'package:devanshhooda/modules/home/core/home_repository.dart';
import 'package:devanshhooda/modules/home/views/widgets/station_bar.dart';
import 'package:devanshhooda/shared_widgets/error_box.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key, required this.homeRepository});
  final HomeRepository homeRepository;

  @override
  Widget build(BuildContext context) {
    if (homeRepository.homePageError != null) {
      return Center(
          child: Column(
        children: [
          ErrorBox(errorMessage: homeRepository.homePageError!),
          const SizedBox(height: 10),
          IconButton(
              onPressed: homeRepository.getAllLocations,
              icon: const Icon(Icons.replay_outlined))
        ],
      ));
    }

    if (homeRepository.isLoading == true ||
        homeRepository.stationsList == null) {
      return const Center(child: CircularProgressIndicator());
    }

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
                itemBuilder: ((context, index) => StationBar(
                      stationData: homeRepository.stationsList![index],
                    )),
                separatorBuilder: ((context, index) => const SizedBox(
                      width: 20,
                    )),
                itemCount: homeRepository.stationsList!.length),
          ),
        )
      ],
    );
  }
}
