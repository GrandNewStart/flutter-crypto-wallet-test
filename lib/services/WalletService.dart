import 'package:flutter_test_wallet/services/StorageService.dart';
import 'package:flutter_test_wallet/wallet/Wallet.dart';

class WalletService {

  static const kMnemonic = 'mnemonic_key';

  static Future<Wallet?> getWallet() async {
    String? value = await StorageService.getString(kMnemonic);
    if (value == null) {
      return null;
    }
    List<String> mnemonic = value.split(' ');
    return Wallet(mnemonic);
  }

  static Future<Wallet> createNewWallet() async {
    String? existingMnemonic = await StorageService.getString(kMnemonic);
    if (existingMnemonic == null) {
      final wallet = Wallet.generate();
      await StorageService.saveString(kMnemonic, wallet.mnemonic.join(' '));
      return wallet;
    } else {
      throw Exception('wallet already created');
    }
  }

  static Future<void> removeWallet() async {
    await StorageService.removeString(kMnemonic);
  }

  static void test() async {
    print("=== WalletService test ===");
    Wallet? wallet = await WalletService.getWallet();
    if (wallet == null) {
      print("   NO WALLET STORED");
      wallet = await createNewWallet();
      print("   WALLET CREATED: ${wallet.mnemonic}");
      await WalletService.removeWallet();
      print("   WALLET REMOVED");
    } else {
      print("   STORED WALLET: ${wallet.mnemonic}");
    }
  }

}