import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/injection.dart';

void main() {
  configureInjection(Environment.prod);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Empty Material App'),
        ),
        body: const Center(
          child: Text('EmptyPage'),
        ),
      ),
    );
  }
}
