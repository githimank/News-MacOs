import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_macos_webview/flutter_macos_webview.dart';

import 'package:macos_ui/macos_ui.dart';
import 'package:news/core/universal_widgets.dart/news_tile.dart';
import 'package:news/cubits/news/news_cubit.dart';
import 'package:news/cubits/news/news_state.dart';
import 'package:news/repository/models/new_models.dart';

class NewsByCategory extends StatefulWidget {
  const NewsByCategory({required this.category, super.key});

  final String category;
  @override
  State<NewsByCategory> createState() => _NewsByCategoryState();
}

class _NewsByCategoryState extends State<NewsByCategory> {
  late NewsCubit newsCubit;
  NewsModel? newsByCategoryModel;

  @override
  void initState() {
    newsCubit = BlocProvider.of<NewsCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: ToolBar(
        title: const Text('News by category'),
        titleWidth: 150.0,
        actions: [
          ToolBarIconButton(
            label: 'Toggle Sidebar',
            icon: const MacosIcon(
              CupertinoIcons.sidebar_left,
            ),
            onPressed: () => MacosWindowScope.of(context).toggleSidebar(),
            showLabel: false,
          ),
        ],
      ),
      children: [
        ContentArea(builder: ((context, scrollController) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<NewsCubit, NewsState>(builder: ((context, state) {
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
                  if (state is NewsByCategoryState) {
                    newsByCategoryModel = state.newByCategory;
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: Text(
                          widget.category.toUpperCase().toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      if (newsByCategoryModel != null)
                        Wrap(
                          children: List.generate(
                              newsByCategoryModel?.articles.length ?? 0,
                              (index) => NewsTile(
                                    imgUrl: newsByCategoryModel
                                            ?.articles[index].urlToImage ??
                                        "",
                                    title: newsByCategoryModel
                                            ?.articles[index].title ??
                                        "",
                                    description: newsByCategoryModel
                                            ?.articles[index].description ??
                                        "",
                                    author: newsByCategoryModel
                                            ?.articles[index].author ??
                                        "",
                                    publishedAt: newsByCategoryModel
                                            ?.articles[index].publishedAt ??
                                        DateTime.now(),
                                    height: 550,
                                    width: 300,
                                    onTap: () {
                                      newsCubit.onOpenPressed(
                                          presentationStyle:
                                              PresentationStyle.modal,
                                          url: newsByCategoryModel
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
          );
        }))
      ],
    );
  }
}
