import 'package:dio/dio.dart';

class DioUtil {
  Dio? _instance;
  Dio? getInstance() {
    _instance ??= createDioInstance();
    return _instance;
  }

  Dio createDioInstance() {
    var dio = Dio();
    dio.interceptors.clear();
    return dio
      ..interceptors
          .add(InterceptorsWrapper(onRequest: (options, handler) async {
        // options.headers["Authorization"] =
        //     "Bearer " + headers['token'].toString();

        return handler.next(options); //modify your request
      }, onResponse: (response, handler) {
        return handler.next(response);
      }, onError: (DioError e, handler) async {
        if (e.response != null) {
          // final responseDecode = jsonDecode(e.response.toString());

          handler.resolve(e.response!);
        }
      }));
  }
}
