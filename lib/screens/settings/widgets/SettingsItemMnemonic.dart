import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../wallet/Wallet.dart';

class SettingsItemMnemonic extends StatelessWidget {

  final Wallet wallet;

  const SettingsItemMnemonic(this.wallet, {super.key});

  void onClick() {
    Clipboard.setData(ClipboardData(text: wallet.mnemonic.join(' ')));
    Fluttertoast.showToast(msg: 'mnemonic copied to clipboard');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[200],
      child: InkWell(
        onTap: onClick,
        splashColor: Colors.blueGrey[300],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Mnemonic', style: TextStyle(fontWeight: FontWeight.w800)),
                    Text(
                      wallet.mnemonic.join(' '),
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.copy, color: Colors.black, size: 18.0),
            ],
          ),
        ),
      ),
    );
  }

}