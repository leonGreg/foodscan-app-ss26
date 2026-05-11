import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(ThemeMode.light)) {
    on<ToggleThemeEvent>(_onToggleTheme);
    on<SetThemeEvent>(_onSetTheme);
  }

  void _onToggleTheme(ToggleThemeEvent event, Emitter<ThemeState> emit) {
    final newMode = state.themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    emit(ThemeState(newMode));
  }

  void _onSetTheme(SetThemeEvent event, Emitter<ThemeState> emit) {
    emit(ThemeState(event.themeMode));
  }
}
