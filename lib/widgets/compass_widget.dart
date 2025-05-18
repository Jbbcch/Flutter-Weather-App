import 'package:flutter/material.dart';
import 'dart:math';

class CompassWidget extends StatelessWidget {
  final int angle; //in degrees

  const CompassWidget({super.key, required this.angle});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.8,
      child: Stack(
        alignment: Alignment.center,
        children: [
          //outer circle
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color.fromARGB(255, 255, 255, 255), width: 3),
            ),
          ),
          //directions
          Positioned(top: 12, child: Text("N", style: TextStyle(fontWeight: FontWeight.bold))),
          Positioned(bottom: 12, child: Text("S", style: TextStyle(fontWeight: FontWeight.bold))),
          Positioned(left: 8, child: Text("W", style: TextStyle(fontWeight: FontWeight.bold))),
          Positioned(right: 8, child: Text("E", style: TextStyle(fontWeight: FontWeight.bold))),

          //arrow
          Transform.rotate(
            angle: (angle - 180) * pi / 180, //convert degrees to radians
            child: Icon(
              Icons.navigation, //up-pointing arrow
              size: 30,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
