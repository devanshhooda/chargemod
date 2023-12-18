import 'package:flutter/material.dart';

class TileButton extends StatelessWidget {
  const TileButton({super.key, required this.tileIcon, required this.tileText});
  final String tileText;
  final IconData tileIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
            backgroundColor: Colors.black38, child: Icon(tileIcon)),
        title: Text(tileText),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16));
  }
}
