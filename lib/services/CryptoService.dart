import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:flutter_test_wallet/extensions/String+.dart';
import 'package:flutter_test_wallet/extensions/Uint8List+.dart';

class CryptoService {

  static Future<Uint8List> generateKey(CryptoAlgorithm algorithm) async {
    SecretKey key;

    switch (algorithm) {
      case CryptoAlgorithm.aes_256_gcm:
        final algo = AesGcm.with256bits();
        key = await algo.newSecretKey();
      case CryptoAlgorithm.chacha20_poly1305:
        final algo = Chacha20.poly1305Aead();
        key = await algo.newSecretKey();
    }

    final bytes = await key.extractBytes();
    return Uint8List.fromList(bytes);
  }

  static Future<Uint8List> encrypt(CryptoAlgorithm algorithm, Uint8List plainBytes, Uint8List keyBytes) async {
    final key = SecretKey(keyBytes);
    List<int> nonce;
    SecretBox box;

    switch (algorithm) {
      case CryptoAlgorithm.aes_256_gcm:
        final algo = AesGcm.with256bits();
        nonce = algo.newNonce();
        box = await algo.encrypt(plainBytes, secretKey: key, nonce: nonce);
      case CryptoAlgorithm.chacha20_poly1305:
        final algo = Chacha20.poly1305Aead();
        nonce = algo.newNonce();
        box = await algo.encrypt(plainBytes, secretKey: key, nonce: nonce);
    }

    return box.concatenation();
  }

  static Future<Uint8List> decrypt(CryptoAlgorithm algorithm,Uint8List cipherBytes, Uint8List keyBytes) async {
    final key = SecretKey(keyBytes);
    final nonce = cipherBytes.firstBytes(12);
    final mac = cipherBytes.lastBytes(16);
    final cipherText = cipherBytes.sublist(12, cipherBytes.length-16);
    SecretBox box;
    List<int> clearBytes;

    switch (algorithm) {
      case CryptoAlgorithm.aes_256_gcm:
        final algo = AesGcm.with256bits();
        box = SecretBox(cipherText, nonce: nonce, mac: Mac(mac));
        clearBytes = await algo.decrypt(box, secretKey: key);
      case CryptoAlgorithm.chacha20_poly1305:
        final algo = Chacha20.poly1305Aead();
        box = SecretBox(cipherText, nonce: nonce, mac: Mac(mac));
        clearBytes = await algo.decrypt(box, secretKey: key);
    }

    return Uint8List.fromList(clearBytes);
  }

  static void test(CryptoAlgorithm algorithm) async {
    const plainText = 'Hello, World!';
    final key = await CryptoService.generateKey(algorithm);
    final encrypted = await CryptoService.encrypt(algorithm, plainText.bytes(), key);
    final decrypted = await CryptoService.decrypt(algorithm, encrypted, key);
    print("=== CryptoService test ===");
    print("   ALGORITHM: ${algorithm.description}");
    print("   PLAIN TEXT: $plainText");
    print("   KEY: ${key.toHex()}");
    print("   ENCRYPTED: ${encrypted.toHex()}");
    print("     NONCE: ${encrypted.firstBytes(12).toHex()}");
    print("     CIPHER TEXT: ${encrypted.sublist(12, encrypted.length-16).toHex()}");
    print("     MAC: ${encrypted.lastBytes(16).toHex()}");
    print("   DECRYPTED: ${decrypted.toUTF8()}");
  }

}

enum CryptoAlgorithm {

  /*
  Key: 32 bytes
  Nonce: 12 bytes
  MAC: 16 bytes
  * */
  aes_256_gcm('AES-256-GCM'),

  /*
  Key: 32 bytes
  Nonce: 12 bytes
  MAC: 16 bytes
  * */
  chacha20_poly1305('ChaCha20-Poly1305');

  final String description;

  const CryptoAlgorithm(this.description);

}