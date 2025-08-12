import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dioObj;
  static init() {
    dioObj = Dio(BaseOptions(baseUrl: 'https://newsapi.org/'));
  }

  static Future<Response> getCategoryData({required String category}) async {
    return await dioObj.get(
      'v2/top-headlines',
      queryParameters: {
        'category': category,
        'country': 'us',
        'apiKey': "277b751d41ae4fc88afc9fd741990638",
      },
    );
  }

  static Future<Response> getEveryThingData() async {
    return await dioObj.get(
      'v2/everything',
      queryParameters: {
        'q': 'bitcoin',
        'apiKey': "277b751d41ae4fc88afc9fd741990638",
      },
    );
  }
}
