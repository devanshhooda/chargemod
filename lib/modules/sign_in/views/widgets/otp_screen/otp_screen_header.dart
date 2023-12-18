import 'package:flutter/material.dart';

class OtpHeader extends StatelessWidget {
  const OtpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
              iconSize: 30,
              color: Colors.white70,
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back)),
          const Padding(
            padding: EdgeInsets.only(left: 75),
            child: Text("Verification",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 18,
                    letterSpacing: 1)),
          ),
        ],
      ),
    );
  }
}
