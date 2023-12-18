import 'package:devanshhooda/modules/home/views/widgets/tile_button.dart';
import 'package:flutter/material.dart';

class TileButtonsContainer extends StatelessWidget {
  const TileButtonsContainer({super.key, required this.tileButtonsData});
  final Map<String, IconData> tileButtonsData;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27.5)),
      child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final String tileText = tileButtonsData.keys.elementAt(index);
            return TileButton(
                tileIcon: tileButtonsData[tileText]!, tileText: tileText);
          },
          separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Divider(),
              ),
          itemCount: tileButtonsData.keys.length),
    );
  }
}
