import 'package:dio/dio.dart';
import '../models/app_config.dart';
import 'package:get_it/get_it.dart';

class HTTPService {
  final Dio dio = Dio();

  AppConfig? _appConfig;
  String? _base_url;

  HTTPService() {
    _appConfig = GetIt.instance.get<AppConfig>();
    _base_url = _appConfig!.coin_api_base_url;
  }

  Future<Response?> get(String _path) async {
    try {
      String _url = "$_base_url$_path";
      Response _response = await dio.get(_url);
      return _response;
    } catch (e) {
      print('HTTPService: Unable to perform get request.');
      print(e);
    }
    return null;
  }
}