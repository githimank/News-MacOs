import 'dart:convert';
import 'dart:developer';

import 'package:news/core/basic-service/dio_utils_service.dart';
import 'package:news/core/routes/api_routes.dart';
import 'package:news/repository/models/new_models.dart';

class NewsRepositoy {
  final dio = DioUtil().getInstance();

// get all news
  Future<NewsModel?> getAllNews({required String search}) async {
    try {
      final apiUrl = "${ApiRoutes().news}&q=$search";
      final response = await dio!.get(apiUrl);
      final jsonResponse = jsonDecode(response.toString());
      log(jsonResponse.toString());
      return NewsModel.fromJson(jsonResponse);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

// get all news
  Future<NewsModel?> getTopHeadlinesNews() async {
    try {
      final apiUrl = ApiRoutes().newsTopHeadlines;
      final response = await dio!.get(apiUrl);
      final jsonResponse = jsonDecode(response.toString());
      // log(jsonResponse.toString());
      return NewsModel.fromJson(jsonResponse);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // get all news
  Future<NewsModel?> getNewsByCategory({required String category}) async {
    try {
      final apiUrl = "${ApiRoutes().newsByCategory}&category=$category";
      final response = await dio!.get(apiUrl);
      final jsonResponse = jsonDecode(response.toString());
      // log(jsonResponse.toString());
      return NewsModel.fromJson(jsonResponse);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
