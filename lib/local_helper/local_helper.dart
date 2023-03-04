import 'package:coin_follower/local_helper/preferecences_helper.dart';

class LocalHelper{
  static saveLocal({
    required String keyToSaveLocal,
    required String valueToSaveLocal,
  }) async {
    await PreferencesHelper.put(
        keyToSaveLocal, valueToSaveLocal);
  }
}