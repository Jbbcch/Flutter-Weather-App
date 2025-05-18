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
        leading: Icon(Icons.error),
        title: Text("Error"),
      ),
      body: Center(
        child: Container(
          height: 200,
          child: Column(
            spacing: 10,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Text(
                  "It seems the app ran\ninto an error. Restart?",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueAccent
                  ),
                ),
              ),
              ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blueAccent
                ),
                onPressed: function, 
                child: Text(
                  "Restart Services",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}