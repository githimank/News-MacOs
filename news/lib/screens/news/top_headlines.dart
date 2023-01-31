import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_macos_webview/flutter_macos_webview.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:news/core/universal_widgets.dart/news_tile.dart';
import 'package:news/cubits/news/news_cubit.dart';
import 'package:news/cubits/news/news_state.dart';
import 'package:news/repository/models/new_models.dart';

// ignore: must_be_immutable
class TopHeadlines extends StatelessWidget {
  TopHeadlines({required this.newsHeadlines, super.key});

  NewsModel? newsHeadlines;

  Future<void> _onOpenPressed(
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
      size: const Size(600.0, 600.0),
      userAgent:
          'Mozilla/5.0 (iPhone; CPU iPhone OS 14_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0 Mobile/15E148 Safari/604.1',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: const ToolBar(
        title: Text("Top Headlines"),
      ),
      children: [
        ContentArea(
          builder: (context, scrollController) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<NewsCubit, NewsState>(
                        builder: ((context, state) {
                      if (state is NewsLoadingState) {
                        return const Center(
                          child: ProgressCircle(),
                        );
                      }
                      if (state is NewsFailedState) {
                        return const Center(
                          child: Text("No Data"),
                        );
                      }
                      if (state is NewsTopHeadlines) {
                        newsHeadlines = state.newsHeadlines;
                      }
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (newsHeadlines != null)
                            Wrap(
                              children: List.generate(
                                  newsHeadlines?.articles.length ?? 0,
                                  (index) => NewsTile(
                                        imgUrl: newsHeadlines
                                                ?.articles[index].urlToImage ??
                                            "",
                                        title: newsHeadlines
                                                ?.articles[index].title ??
                                            "",
                                        description: newsHeadlines
                                                ?.articles[index].description ??
                                            "",
                                        author: newsHeadlines
                                                ?.articles[index].author ??
                                            "",
                                        publishedAt: newsHeadlines
                                                ?.articles[index].publishedAt ??
                                            DateTime.now(),
                                        height: 550,
                                        width: 300,
                                        onTap: () {
                                          _onOpenPressed(
                                              presentationStyle:
                                                  PresentationStyle.modal,
                                              url: newsHeadlines
                                                      ?.articles[index].url ??
                                                  'https://google.com');
                                        },
                                      )),
                            )
                        ],
                      );
                    }))
                  ],
                ),
              ),
            );
          },
        ),
        ResizablePane(
          minWidth: 180,
          startWidth: 200,
          windowBreakpoint: 700,
          resizableSide: ResizableSide.left,
          builder: (_, __) {
            return const Center(
              child: Text('Resizable Pane'),
            );
          },
        ),
      ],
    );
  }
}
