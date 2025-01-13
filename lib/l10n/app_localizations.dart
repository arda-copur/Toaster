import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  String get appTitle =>
      Intl.message('Toaster', name: 'appTitle', locale: locale.toString());
  String get noMediaSelected => Intl.message('No media selected.',
      name: 'noMediaSelected', locale: locale.toString());
  String mediaPath(String path) => Intl.message('Media Path: $path',
      name: 'mediaPath', args: [path], locale: locale.toString());
  String originalSize(String size) => Intl.message('Original Size: $size KB',
      name: 'originalSize', args: [size], locale: locale.toString());
  String get compressMedia => Intl.message('Compress Media',
      name: 'compressMedia', locale: locale.toString());
  String get compressedMedia => Intl.message('Compressed Media:',
      name: 'compressedMedia', locale: locale.toString());
  String get downloadMedia => Intl.message('Download Media',
      name: 'downloadMedia', locale: locale.toString());
  String downloadedMediaPath(String path) =>
      Intl.message('Downloaded Media Path: $path',
          name: 'downloadedMediaPath', args: [path], locale: locale.toString());
  String get pickImage =>
      Intl.message('Pick Image', name: 'pickImage', locale: locale.toString());
  String get pickVideo =>
      Intl.message('Pick Video', name: 'pickVideo', locale: locale.toString());
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'tr'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture<AppLocalizations>(AppLocalizations(locale));

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
