import 'package:flutter_test_wallet/extensions/String+.dart';
import 'package:flutter_test_wallet/extensions/Uint8List+.dart';
import 'package:flutter_test_wallet/services/CryptoService.dart';
import 'package:flutter_test_wallet/services/KeychainService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {

  static const kSecretKey = 'shared_preference_key';

  static Future<void> saveString(String key, String string) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? secretKey = await KeychainService.getKey(kSecretKey);
    if (secretKey == null) {
      print("shared_preference_key generated");
      secretKey = (await CryptoService.generateKey(CryptoAlgorithm.aes_256_gcm)).toHex();
      await KeychainService.saveKey(kSecretKey, secretKey);
    }
    print("shared_preference_key: $secretKey");

    final encrypted = await CryptoService.encrypt(CryptoAlgorithm.aes_256_gcm, string.bytes(), secretKey.hexToBytes());
    await prefs.setString(key, encrypted.toHex());
  }

  static Future<String?> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? secretKey = await KeychainService.getKey(kSecretKey);
    if (secretKey == null) {
      print("shared_preference_key not found");
      return null;
    }
    print("shared_preference_key: $secretKey");

    String? encrypted = prefs.getString(key);
    if (encrypted == null) {
      return null;
    }

    final decrypted = await CryptoService.decrypt(CryptoAlgorithm.aes_256_gcm, encrypted.hexToBytes(), secretKey.hexToBytes());
    return decrypted.toUTF8();
  }

  static Future<void> removeString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final success = await prefs.remove(key);
    if (success) {
      print("StorageService: successfully removed value for'$key'");
    } else {
      print("StorageService: failed to remove value for '$key'");
    }
  }

  static void test() async {
    print("=== StorageService test ===");
    String? value = await StorageService.getString('test');
    if (value == null) {
      print('   #1 VALUE NOT STORED');
      await StorageService.saveString('test', 'Hello, World!');
      print('   #2 VALUE STORED');
      value = await StorageService.getString('test');
      print('   #3 VALUE FETCHED: $value');
      await StorageService.removeString('test');
      value = await StorageService.getString('test');
      if (value == null) {
        print('   #4 VALUE REMOVED');
      } else {
        print('   #4 VALUE REMOVAL FAILED');
      }
    } else {
      print('   #1 VALUE FETCHED: $value');
      await StorageService.removeString('test');
      value = await StorageService.getString('test');
      if (value == null) {
        print('   #2 VALUE REMOVED');
      } else {
        print('   #2 VALUE REMOVAL FAILED');
      }
    }
  }

}