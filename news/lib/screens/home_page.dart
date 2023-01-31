import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:news/cubits/news/news_cubit.dart';
import 'package:news/cubits/theme/theme_cubit.dart';
import 'package:news/screens/news/news_category.dart';
import 'package:news/screens/news/news_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  int radioValue = 0;

  late NewsCubit newsCubit = NewsCubit();
  final List<Widget> pages = [
    CupertinoTabView(
      builder: (_) => const NewsPage(),
    ),
    const NewsByCategory(
      category: 'business',
    ),
    const NewsByCategory(
      category: 'entertainment',
    ),
    const NewsByCategory(
      category: 'general',
    ),
    const NewsByCategory(
      category: 'health',
    ),
    const NewsByCategory(
      category: 'science',
    ),
    const NewsByCategory(
      category: 'sports',
    ),
    const NewsByCategory(
      category: 'technology',
    ),
  ];

  Map<int, String> category = {
    0: "all",
    1: "business",
    2: "entertainment",
    3: "general",
    4: "health",
    5: "science",
    6: "sports",
    7: "technology"
  };

  @override
  void initState() {
    super.initState();
    newsCubit = BlocProvider.of<NewsCubit>(context);
  }

  final TextEditingController searchFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return PlatformMenuBar(
        menus: const [
          PlatformMenu(label: "label", menus: [
            PlatformProvidedMenuItem(type: PlatformProvidedMenuItemType.quit),
            PlatformProvidedMenuItem(
                type: PlatformProvidedMenuItemType.toggleFullScreen)
          ]),
          PlatformMenu(
            label: 'View',
            menus: [
              PlatformProvidedMenuItem(
                type: PlatformProvidedMenuItemType.toggleFullScreen,
              ),
            ],
          ),
          PlatformMenu(
            label: 'Window',
            menus: [
              PlatformProvidedMenuItem(
                type: PlatformProvidedMenuItemType.minimizeWindow,
              ),
              PlatformProvidedMenuItem(
                type: PlatformProvidedMenuItemType.zoomWindow,
              ),
            ],
          ),
        ],
        child: MacosWindow(
            sidebar: Sidebar(
              top: MacosSearchField(
                placeholder: "Search",
                controller: searchFieldController,
                onResultSelected: (result) {
                  switch (result.searchKey) {
                    case "All":
                      setState(() {
                        pageIndex = 0;
                        searchFieldController.clear();
                      });
                      break;
                    case "Business":
                      setState(() {
                        pageIndex = 1;
                        newsCubit.getNewsByCategory(
                            category: category[pageIndex]!);
                        searchFieldController.clear();
                      });
                      break;
                    case "Entertainment":
                      setState(() {
                        pageIndex = 2;
                        newsCubit.getNewsByCategory(
                            category: category[pageIndex]!);
                        searchFieldController.clear();
                      });
                      break;
                    case "General":
                      setState(() {
                        pageIndex = 3;
                        newsCubit.getNewsByCategory(
                            category: category[pageIndex]!);
                        searchFieldController.clear();
                      });
                      break;
                    case "Health":
                      setState(() {
                        pageIndex = 4;
                        newsCubit.getNewsByCategory(
                            category: category[pageIndex]!);
                        searchFieldController.clear();
                      });
                      break;
                    case "Science":
                      setState(() {
                        pageIndex = 5;
                        newsCubit.getNewsByCategory(
                            category: category[pageIndex]!);
                        searchFieldController.clear();
                      });
                      break;
                    case "Sports":
                      setState(() {
                        pageIndex = 6;
                        newsCubit.getNewsByCategory(
                            category: category[pageIndex]!);
                        searchFieldController.clear();
                      });
                      break;
                    case "Technology":
                      setState(() {
                        pageIndex = 7;
                        newsCubit.getNewsByCategory(
                            category: category[pageIndex]!);
                        searchFieldController.clear();
                      });
                      break;
                  }
                },
                results: const [
                  SearchResultItem("All"),
                  SearchResultItem("Business"),
                  SearchResultItem("Entertainment"),
                  SearchResultItem("General"),
                  SearchResultItem("Health"),
                  SearchResultItem("Science"),
                  SearchResultItem("Sports"),
                  SearchResultItem("Technology"),
                ],
              ),
              bottom: const MacosListTile(
                  title: Text("Himank"),
                  subtitle: Text("himank@antino.io"),
                  leading: MacosIcon(CupertinoIcons.profile_circled)),
              minWidth: 200,
              builder: ((context, scrollController) {
                return SidebarItems(
                  scrollController: scrollController,
                  currentIndex: pageIndex,
                  onChanged: (value) {
                    if (value != 0) {
                      newsCubit.getNewsByCategory(category: category[value]!);
                    }
                    setState(() {
                      pageIndex = value;
                    });
                  },
                  items: const [
                    SidebarItem(
                      leading: MacosIcon(CupertinoIcons.bag),
                      label: Text('All'),
                    ),
                    SidebarItem(
                      leading: MacosIcon(CupertinoIcons.envelope),
                      label: Text('Business'),
                    ),
                    SidebarItem(
                      leading: MacosIcon(CupertinoIcons.sportscourt),
                      label: Text('Entertainment'),
                    ),
                    SidebarItem(
                      leading: MacosIcon(CupertinoIcons.sportscourt),
                      label: Text('General'),
                    ),
                    SidebarItem(
                      leading: MacosIcon(CupertinoIcons.sportscourt),
                      label: Text('Health'),
                    ),
                    SidebarItem(
                      leading: MacosIcon(CupertinoIcons.sportscourt),
                      label: Text('Science'),
                    ),
                    SidebarItem(
                      leading: MacosIcon(CupertinoIcons.sportscourt),
                      label: Text('Sports'),
                    ),
                    SidebarItem(
                      leading: MacosIcon(CupertinoIcons.play),
                      label: Text('Technology'),
                    ),
                  ],
                  itemSize: SidebarItemSize.large,
                );
              }),
            ),
            endSidebar: Sidebar(
              startWidth: 200,
              minWidth: 200,
              maxWidth: 300,
              shownByDefault: false,
              builder: (context, scrollController) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Theme'),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('System Theme'),
                          const SizedBox(width: 26),
                          MacosRadioButton(
                            groupValue: radioValue,
                            value: 0,
                            onChanged: (int? value) {
                              radioValue = value!;
                              BlocProvider.of<ChangeThemeBloc>(context)
                                  .add(SystemThemeEvent());
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Light Theme'),
                          const SizedBox(width: 26),
                          MacosRadioButton(
                            groupValue: radioValue,
                            value: 1,
                            onChanged: (int? value) {
                              radioValue = value!;
                              BlocProvider.of<ChangeThemeBloc>(context)
                                  .add(LightThemeEvent());
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Dark Theme'),
                          const SizedBox(width: 26),
                          MacosRadioButton(
                            groupValue: radioValue,
                            value: 2,
                            onChanged: (int? value) {
                              radioValue = value!;
                              BlocProvider.of<ChangeThemeBloc>(context)
                                  .add(DarkThemeEvent());
                            },
                          )
                        ],
                      ),
                      const Spacer(),
                      const Text('End Sidebar')
                    ],
                  ),
                );
              },
            ),
            child: IndexedStack(
              index: pageIndex,
              children: pages,
            )));
  }
}
