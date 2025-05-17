import 'package:flutter/material.dart';

//a placeholder error page
//TODO: make it more distinct
class ErrorPlaceholder extends StatelessWidget {
  final function;

  const ErrorPlaceholder({super.key, required this.function});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search),
        title: Text("Error"),
      ),
      body: Align(
        child: ElevatedButton(
          onPressed: function, 
          child: Text("Restart Services"),
        ),
        alignment: Alignment(0, -0.2),
      ),
    );
  }
}