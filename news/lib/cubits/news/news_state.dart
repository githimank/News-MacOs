// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../repository/models/new_models.dart';

abstract class NewsState {}

class NewsInitialState extends NewsState {}

class NewsLoadingState extends NewsState {}

class SearchNewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  final NewsModel newsModel;
  NewsLoadedState({
    required this.newsModel,
  });
}

class NewsFailedState extends NewsState {}

class NewsTopHeadlines extends NewsState {
  final NewsModel newsHeadlines;
  NewsTopHeadlines({
    required this.newsHeadlines,
  });
}

class NewsByCategoryState extends NewsState {
  final NewsModel newByCategory;
  NewsByCategoryState({
    required this.newByCategory,
  });
}
