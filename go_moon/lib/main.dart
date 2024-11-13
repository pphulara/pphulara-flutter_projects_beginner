import 'package:flutter/material.dart';
import './pages/home_page.dart';

void main() {
  runApp(const App());
}
class App extends StatelessWidget{
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GO MOON",
      theme: ThemeData(scaffoldBackgroundColor: const Color.fromARGB(200, 31, 31, 31)),
      home: HomePage(),
    );
  }
}