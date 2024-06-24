import 'dart:convert';
import 'dart:typed_data';

extension Uint8listExtension on Uint8List {

  String toBase64() => base64Encode(this);

  String toHex() => map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');

  String toUTF8() => utf8.decode(this);

  Uint8List firstBytes(int bytes) => sublist(0, bytes);

  Uint8List lastBytes(int bytes) => sublist(length - bytes);

}