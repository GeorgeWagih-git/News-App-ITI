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
            "🖨️response Status code : ${response.statusCode} \n 🖨️response : ${response.data}",
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
