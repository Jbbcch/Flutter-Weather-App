import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

//error dialog
void showErrorDialog(BuildContext context, Object error, VoidCallback onRetry) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      title: const Text("Error"),
      content: Text(error.toString()),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Geolocator.openAppSettings();
            onRetry();
          },
          child: Text("App Settings"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onRetry();
          },
          child: Text("Retry"),
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceBetween,
    ),
  );
}

//error dialog wrapper

