import 'dart:typed_data';

import 'package:flutter_test_wallet/extensions/Uint8List+.dart';

class KeyPair {

  Uint8List privateKey;
  Uint8List publicKey;

  KeyPair(this.privateKey, this.publicKey);

  @override
  String toString() {
    return 'privateKey=${privateKey.toHex()}, publicKey=${publicKey.toHex()}';
  }
}