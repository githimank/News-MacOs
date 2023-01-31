// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart' hide OverlayVisibilityMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_macos_webview/flutter_macos_webview.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:news/cubits/news/news_cubit.dart';
import 'package:news/cubits/news/news_state.dart';
import 'package:news/repository/models/new_models.dart';
import 'package:news/screens/news/top_headlines.dart';

import '../../core/universal_widgets.dart/news_tile.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late NewsCubit newsCubit;
  NewsModel? newsModel;
  Timer? _debounce;
  NewsModel? newsHeadlines;

  @override
  void initState() {
    newsCubit = BlocProvider.of<NewsCubit>(context);
    newsCubit.getTopHeadLines();
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  _onSearchChanged({required String query}) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      newsModel = null;
      newsCubit.getAllNews(search: query.isEmpty ? "all" : query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: ToolBar(
          title: const Text("News"),
          titleWidth: 150,
          leading: MacosTooltip(
            message: "Toggle Sidebar",
            useMousePosition: false,
            child: MacosIconButton(
              onPressed: () => MacosWindowScope.of(context).toggleSidebar(),
              icon: MacosIcon(
                CupertinoIcons.sidebar_left,
                size: 20.0,
                color: MacosTheme.brightnessOf(context).resolve(
                  const Color.fromRGBO(0, 0, 0, 0.5),
                  const Color.fromRGBO(255, 255, 255, 0.5),
                ),
              ),
              boxConstraints: const BoxConstraints(
                minHeight: 20,
                minWidth: 20,
                maxWidth: 48,
                maxHeight: 38,
              ),
            ),
          ),
          actions: [
            ToolBarIconButton(
                label: "Toggle End Sidebar",
                icon: const MacosIcon(CupertinoIcons.sidebar_right),
                showLabel: false,
                tooltipMessage: "Toogle End SideBar",
                onPressed: (() =>
                    MacosWindowScope.of(context).toggleEndSidebar()))
          ]),
      children: [
        ContentArea(builder: ((context, controller) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<NewsCubit, NewsState>(builder: (context, state) {
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
                    if (state is NewsLoadedState) {
                      newsModel = state.newsModel;
                    }
                    if (state is NewsTopHeadlines) {
                      newsHeadlines = state.newsHeadlines;
                      newsCubit.getAllNews(search: 'all');
                    }
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Article of the day",
                                style: TextStyle(fontSize: 20),
                              ),
                              PushButton(
                                buttonSize: ButtonSize.large,
                                isSecondary: true,
                                child: const Text('See More'),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (_) {
                                      return TopHeadlines(
                                        newsHeadlines: newsHeadlines,
                                      );
                                    },
                                  ));
                                },
                              ),
                            ],
                          ),
                        ),
                        if (newsHeadlines != null)
                          Wrap(
                            children: [
                              NewsTile2(
                                imgUrl:
                                    newsHeadlines?.articles.first.urlToImage ??
                                        '',
                                title:
                                    newsHeadlines?.articles.first.title ?? '',
                                description:
                                    newsHeadlines?.articles.first.description ??
                                        '',
                                author:
                                    newsHeadlines?.articles.first.author ?? '',
                                publishedAt:
                                    newsHeadlines?.articles.first.publishedAt ??
                                        DateTime.now(),
                                height: 500,
                                width: MediaQuery.of(context).size.width,
                                onTap: () {
                                  newsCubit.onOpenPressed(
                                      presentationStyle:
                                          PresentationStyle.sheet,
                                      url: newsHeadlines?.articles.first.url ??
                                          'https://google.com');
                                },
                              ),
                            ],
                          ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 18),
                          child: Text(
                            "Topic Match For You",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 8, 200, 8),
                          child: MacosTextField(
                            prefix: const MacosIcon(CupertinoIcons.search),
                            padding: const EdgeInsets.all(8),
                            clearButtonMode: OverlayVisibilityMode.always,
                            placeholder: 'Type some text here',
                            onChanged: (value) {
                              _onSearchChanged(query: value);
                            },
                          ),
                        ),
                        if ((state is SearchNewsLoadingState) == true)
                          const Center(
                            child: ProgressCircle(),
                          ),
                        if (newsModel != null)
                          Wrap(
                            children: List.generate(
                                newsModel?.articles.length ?? 0,
                                (index) => NewsTile(
                                      imgUrl: newsModel
                                              ?.articles[index].urlToImage ??
                                          "",
                                      title: newsModel?.articles[index].title ??
                                          "",
                                      description: newsModel
                                              ?.articles[index].description ??
                                          "",
                                      author:
                                          newsModel?.articles[index].author ??
                                              "",
                                      publishedAt: newsModel
                                              ?.articles[index].publishedAt ??
                                          DateTime.now(),
                                      height: 550,
                                      width: 300,
                                      onTap: () {
                                        newsCubit.onOpenPressed(
                                            presentationStyle:
                                                PresentationStyle.modal,
                                            url: newsHeadlines
                                                    ?.articles[index].url ??
                                                'https://google.com');
                                      },
                                    )),
                          ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          );
        }))
      ],
    );
  }
}
