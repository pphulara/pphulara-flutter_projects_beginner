import 'package:flutter/material.dart';
import 'package:frivia/pages/homepage.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frivia',
      theme: ThemeData(fontFamily: 'Architect'),
      home: HomePage(),
    );
  }


}