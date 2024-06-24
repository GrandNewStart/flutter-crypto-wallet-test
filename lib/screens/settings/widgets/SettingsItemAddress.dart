import 'package:flutter/material.dart';

import '../../../wallet/Wallet.dart';

class SettingsItemAddress extends StatelessWidget {

  final Wallet wallet;

  const SettingsItemAddress(this.wallet, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.blueGrey[200],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Wallet Address', style: TextStyle(fontWeight: FontWeight.w800)),
              Text(wallet.deriveAddress("m/44'/0'/0'/0"))
            ],
          ),
        ),
      ),
    );
  }
}