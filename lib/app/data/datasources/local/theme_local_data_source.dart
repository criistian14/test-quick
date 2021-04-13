import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:testquick/app/core/errors/exceptions.dart';

abstract class ThemeLocalDataSource {
  /// Gets the cached [ThemeMode] which was gotten the last time
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<ThemeMode> getTheme();

  /// Save [ThemeMode] in cache by [FlutterSecureStorage]
  Future<void> setTheme(ThemeMode themeMode);
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final FlutterSecureStorage storage;

  ThemeLocalDataSourceImpl({
    @required this.storage,
  });

  @override
  Future<ThemeMode> getTheme() async {
    try {
      String theme = await storage.read(key: "theme");

      if (theme == null) {
        return ThemeMode.light;
      }

      if (theme.toLowerCase().contains("dark")) {
        return ThemeMode.dark;
      }

      return ThemeMode.light;
    } catch (e) {
      throw (CacheException(
        error: e.toString(),
      ));
    }
  }

  @override
  Future<void> setTheme(ThemeMode themeMode) async {
    try {
      await storage.write(key: "theme", value: themeMode.toString());
    } catch (e) {
      throw (CacheException(
        error: e.toString(),
      ));
    }
  }
}
