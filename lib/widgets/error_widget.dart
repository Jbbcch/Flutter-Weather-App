import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

//error dialog
void showErrorDialog(BuildContext context, Object error, VoidCallback onRetry) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Error"),
        content: Text(
          error.toString(),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Geolocator.openAppSettings(); //only place where geolocator package is used here
              onRetry();
            },
            child: Text(
              "App Settings",
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onRetry();
            },
            child: Text(
              "Retry",
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
        ],
        actionsAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  });
}