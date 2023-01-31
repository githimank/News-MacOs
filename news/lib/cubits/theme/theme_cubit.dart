import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubits/theme/theme_state.dart';

abstract class ThemeEvent {
  ThemeMode getThemeMode();
  String getName();
}

class DarkThemeEvent extends ThemeEvent {
  ThemeMode themeMode = ThemeMode.dark;

  @override
  String getName() {
    return "dark";
  }

  @override
  ThemeMode getThemeMode() {
    return themeMode;
  }
}

class LightThemeEvent extends ThemeEvent {
  ThemeMode themeMode = ThemeMode.light;

  @override
  String getName() {
    return "light";
  }

  @override
  ThemeMode getThemeMode() {
    return themeMode;
  }
}

class SystemThemeEvent extends ThemeEvent {
  ThemeMode themeMode = ThemeMode.system;

  @override
  String getName() {
    return "System";
  }

  @override
  ThemeMode getThemeMode() {
    return themeMode;
  }
}

class ChangeThemeBloc extends Bloc<ThemeEvent, ChangeThemeState> {
  ChangeThemeBloc()
      : super(ChangeThemeState(name: "Initial", mode: ThemeMode.system)) {
    on<SystemThemeEvent>((event, emit) => emit(
        ChangeThemeState(name: event.getName(), mode: event.getThemeMode())));
    on<DarkThemeEvent>((event, emit) => emit(
        ChangeThemeState(name: event.getName(), mode: event.getThemeMode())));
    on<LightThemeEvent>((event, emit) => emit(
        ChangeThemeState(name: event.getName(), mode: event.getThemeMode())));
  }
}
