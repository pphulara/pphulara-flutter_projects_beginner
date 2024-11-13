import 'dart:convert';
import 'package:coincap/models/app_config.dart';
import 'package:coincap/pages/homepage.dart';
import 'package:coincap/services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await loadConfig();
  registerhttpservice();
  runApp(const MyApp());
}

Future<void> loadConfig() async {
  String _configContent =
      await rootBundle.loadString("assets/config/main.json");
  Map _configData = jsonDecode(_configContent);
  GetIt.instance.registerSingleton<AppConfig>(
    AppConfig(
      coin_api_base_url: _configData["COIN_API_BASE_URL"],
    ),
  );
}
  void registerhttpservice(){
    GetIt.instance.registerSingleton<HTTPService>(
      HTTPService(),
    );
  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext _context) {
    return MaterialApp(
      title: "CoinCap",
      home: Homepage(),
    );
  }


}  