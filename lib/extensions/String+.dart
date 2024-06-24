import 'dart:convert';
import 'dart:typed_data';

extension StringExtensions on String {

  Uint8List bytes() => utf8.encode(this);

  Uint8List base64toBytes() => base64Decode(this);

  Uint8List hexToBytes() {
    String sanitizedHex = length % 2 == 0 ? this : '0$this';
    return Uint8List.fromList(List<int>.generate(
      sanitizedHex.length ~/ 2,
          (i) => int.parse(sanitizedHex.substring(i * 2, i * 2 + 2), radix: 16),
    ));
  }

  String dropFirst(int bytes) {
    Uint8List inputBytes = utf8.encode(this);
    Uint8List remainingBytes = inputBytes.sublist(4);
    String output = utf8.decode(remainingBytes);
    return output;
  }

}