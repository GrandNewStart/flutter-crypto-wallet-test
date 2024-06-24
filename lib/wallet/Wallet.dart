import 'package:flutter_test_wallet/wallet/KeyPair.dart';
import 'package:hd_wallet_kit/hd_wallet_kit.dart';

class Wallet {

  List<String> mnemonic;

  Wallet(this.mnemonic);

  Wallet.generate() : this(Mnemonic.generate());

  KeyPair rootKey() {
    final seed = Mnemonic.toSeed(mnemonic);
    final wallet = HDWallet.fromSeed(seed: seed);
    final root = wallet.deriveKeyByPath(path: 'm');
    return KeyPair(root.privKeyBytes!, root.pubKey);
  }

  KeyPair deriveKey(String path) {
    final seed = Mnemonic.toSeed(mnemonic);
    final wallet = HDWallet.fromSeed(seed: seed);
    final node = wallet.deriveKeyByPath(path: path);
    return KeyPair(node.privKeyBytes!, node.pubKey);
  }

  String deriveAddress(String path) {
    final seed = Mnemonic.toSeed(mnemonic);
    final wallet = HDWallet.fromSeed(seed: seed);
    final node = wallet.deriveKeyByPath(path: path);
    return node.encodeAddress();
  }

}