import 'dart:async';
import 'dart:convert';

import 'package:coin_follower/constants/strings.dart';
import 'package:coin_follower/utils/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesHelper {

  static _PrefAdapter? _prefAdapter;
  static final log = getLogs();

  static Future<String?> put(String key, dynamic value) async {
    final _PrefAdapter prefs = _getInstance();

    String? original = await prefs.get(key);

    await prefs.put(key, jsonEncode(value));
      log.i("${Strings.cPreferencesHelper} PUT $key is $value");

    return original;
  }

  static Future<String?> get(String key, {defaultResult}) async {
    final _PrefAdapter prefs = _getInstance();

    String? result = (await prefs.get(key)) ?? defaultResult;

      log.i("${Strings.cPreferencesHelper} GET $key is $result");

    try {
      result = jsonDecode(result!);
      log.i(" PreferencesHelper result is :$result");

      return result;
    } catch (e) {}
    return result;
    // return result[key];
  }

  static Future<String> remove(String key) async {
    final _PrefAdapter prefs = _getInstance();

    String original = await prefs.get(key);
    await prefs.remove(key);
    log.i("${Strings.cPreferencesHelper}  REMOVE is $key");

    try {
      original = jsonDecode(original);
    } catch (e) {}
    return original;
  }

  static Future<bool> removeAll() async {
    final _PrefAdapter prefs = _getInstance();

    await prefs.removeAll();
      log.i("${Strings.cPreferencesHelper} == REMOVED ALL PREFERENCES ==");

    return true;
  }

  static _getInstance() => _prefAdapter ??= _PrefAdapter();
}

/// Helper class to intelligently switch between plugins
class _PrefAdapter {
  static const String FSS_PREFIX = "_fss_"; //Flutter Secure Storage PREFIX
  static const String SP_PREFIX = "_sp_"; //shared Preferences PREFIX

  Completer pluginFuture = Completer();

  bool isSecure = false;

  _PrefAdapter() {
    setupPlugin();
  }

  void setupPlugin() async {
    this.isSecure = false;
    this.pluginFuture.complete(await SharedPreferences.getInstance());
  }

  Future put(String key, dynamic value) async {
    final plugin = await pluginFuture.future;
    if (plugin is FlutterSecureStorage)
      plugin.write(key: "$FSS_PREFIX/$key", value: value);
    else if (plugin is SharedPreferences)
      plugin.setString("$SP_PREFIX/$key", value);
  }

  Future<dynamic> get(String key) async {
    final plugin = await pluginFuture.future;

    String? result;
    if (plugin is FlutterSecureStorage)
      result = await plugin.read(key: "$FSS_PREFIX/$key");
    else if (plugin is SharedPreferences)
      result = plugin.getString("$SP_PREFIX/$key");

    return result;
  }

  Future remove(String key) async {
    final plugin = await pluginFuture.future;
    if (plugin is FlutterSecureStorage)
      plugin.delete(key: "$FSS_PREFIX/$key");
    else if (plugin is SharedPreferences) plugin.remove("$SP_PREFIX/$key");
  }

  Future removeAll() async {
    final plugin = await pluginFuture.future;
    if (plugin is FlutterSecureStorage)
      plugin.deleteAll();
    else if (plugin is SharedPreferences) plugin.clear();
  }
}
