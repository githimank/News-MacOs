import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_macos_webview/flutter_macos_webview.dart';
import 'package:news/cubits/news/news_state.dart';
import 'package:news/repository/new_repository.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());
  final newsRepository = NewsRepositoy();

  getAllNews({required String search}) async {
    emit(SearchNewsLoadingState());
    final response = await newsRepository.getAllNews(search: search);
    if (response != null) {
      log(response.toMap().toString());
      emit(NewsLoadedState(newsModel: response));
    } else {
      emit(NewsFailedState());
    }
  }

  Future<void> getTopHeadLines() async {
    emit(NewsLoadingState());
    final response = await newsRepository.getTopHeadlinesNews();
    if (response != null) {
      //log(response.toMap().toString());
      emit(NewsTopHeadlines(newsHeadlines: response));
    } else {
      emit(NewsFailedState());
      getAllNews(search: 'all');
    }
  }

  Future<void> getNewsByCategory({required String category}) async {
    emit(NewsLoadingState());
    final response = await newsRepository.getNewsByCategory(category: category);
    if (response != null) {
      //log(response.toMap().toString());
      emit(NewsByCategoryState(newByCategory: response));
    } else {
      emit(NewsFailedState());
    }
  }

// Web View
  Future<void> onOpenPressed(
      {required String url,
      required PresentationStyle presentationStyle}) async {
    final webview = FlutterMacOSWebView(
      onOpen: () => log('Opened'),
      onClose: () => log('Closed'),
      onPageStarted: (url) => log('Page started: $url'),
      onPageFinished: (url) => log('Page finished: $url'),
      onWebResourceError: (err) {
        log(
          'Error: ${err.errorCode}, ${err.errorType}, ${err.domain}, ${err.description}',
        );
      },
    );
    await webview.open(
      url: url,
      presentationStyle: presentationStyle,
      size: const Size(800.0, 800.0),
      userAgent:
          'Mozilla/5.0 (iPhone; CPU iPhone OS 14_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0 Mobile/15E148 Safari/604.1',
    );
  }
}
