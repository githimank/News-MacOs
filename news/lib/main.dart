import 'dart:io';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:news/cubits/news/news_cubit.dart';
import 'package:news/cubits/theme/theme_cubit.dart';
import 'package:news/cubits/theme/theme_state.dart';
import 'package:news/screens/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isMacOS) {
    await DesktopWindow.setMinWindowSize(const Size(600, 600));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChangeThemeBloc(),
        ),
        BlocProvider(
          create: (context) => NewsCubit(),
        ),
      ],
      child: BlocBuilder<ChangeThemeBloc, ChangeThemeState>(
        builder: (context, state) {
          return MacosApp(
            debugShowCheckedModeBanner: false,
            color: Colors.yellow,
            title: 'Flutter Demo',
            theme: MacosThemeData.light(),
            darkTheme: MacosThemeData.dark(),
            themeMode: state.mode,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
