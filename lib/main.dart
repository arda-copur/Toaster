import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toaster/config/app_config.dart';
import 'package:toaster/config/app_theme.dart';
import 'package:toaster/l10n/app_localization_config.dart';
import 'presentation/bloc/media_bloc.dart';
import 'presentation/screens/media_screen.dart';
import 'di/dependency_injection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.title,
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: AppConfig.debugShowCheckedModeBanner,
      localizationsDelegates: AppLocalizationConfig.localizationsDelegates,
      supportedLocales: AppLocalizationConfig.supportedLocales,
      home: BlocProvider(
        create: (context) => MediaBloc(
          DependencyInjection.createCompressMediaUseCase(),
          DependencyInjection.createDownloadMediaUseCase(),
        ),
        child: const MediaScreen(),
      ),
    );
  }
}
