import 'package:flutter/material.dart';

class StationBar extends StatelessWidget {
  const StationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.white, width: 1.5),
          borderRadius: BorderRadius.circular(15)),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Station name",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text("Address")
        ],
      ),
    );
  }
}
