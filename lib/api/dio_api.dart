import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dioObj;
  static init() {
    dioObj = Dio(BaseOptions(baseUrl: 'https://newsapi.org/'));
    dioObj.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          print(
            "🖨️baseURL: ${options.baseUrl}\n 🖨️path : ${options.path}\n 🖨️paramrters : ${options.queryParameters}",
          );
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          print(
            "🖨️response Status code : ${response.statusCode} ",
            //\n 🖨️response : ${response.data}
          );
          return handler.next(response);
        },
        onError: (error, handler) {
          print("🖨️Error : $error");
          return handler.next(error);
        },
      ),
    );
  }

  static Future<Response> getCategoryData({required String category}) async {
    return await dioObj.get(
      'v2/top-headlines',
      queryParameters: {
        'category': category,
        'country': 'us',
        'apiKey': "0c4f7a13d5774eebb87a0ddf38be2b3a",
      },
    );
  }

  static Future<Response> getEveryThingData() async {
    return await dioObj.get(
      'v2/everything',
      queryParameters: {
        'q': 'EveryThing',
        'apiKey': "0c4f7a13d5774eebb87a0ddf38be2b3a",
      },
    );
  }

  static Future<Response> searchDatainEverything({
    required String query,
  }) async {
    return dioObj.get(
      'v2/everything',
      queryParameters: {
        'q': query,
        'apiKey': "0c4f7a13d5774eebb87a0ddf38be2b3a",
      },
    );
  }
}
