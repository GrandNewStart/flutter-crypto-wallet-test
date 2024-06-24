import 'package:flutter_keychain/flutter_keychain.dart';

class KeychainService {

  static Future<String?> getKey(String key) async {
    return await FlutterKeychain.get(key: key);
  }

  static Future<void> saveKey(String key, String value) async {
    return await FlutterKeychain.put(key: key, value: value);
  }

  static Future<void> removeKey(String key) async {
    return await FlutterKeychain.remove(key: key);
  }

  static Future<void> clear() async {
    return await FlutterKeychain.clear();
  }

  static Future<void> test() async {
    await KeychainService.saveKey('test', 'hello, hello');
    print("SAVED");
    final key = await KeychainService.getKey('test');
    print("KEY: $key");
    await KeychainService.removeKey('test');
    print("REMOVED");
  }

}