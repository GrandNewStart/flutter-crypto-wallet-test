import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../wallet/Wallet.dart';

class WalletAddressCard extends StatelessWidget {

  final Wallet? wallet;
  final Function() createWallet;

  const WalletAddressCard({super.key, this.wallet, required this.createWallet});

  Widget whenWalletIsNull() {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.blueGrey[100],
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          splashColor: Colors.blueGrey[200],
          onTap: createWallet,
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tap here to create new wallet',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                  textAlign: TextAlign.center
                ),
                Icon(
                  Icons.wallet,
                  color: Colors.blueGrey,
                  size: 64.0
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget whenWalletIsNotNull() {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.blueGrey[100],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('My Wallet', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24.0),),
              QrImageView(
                data: wallet!.deriveAddress("m/44'/0'/0'/0"),
                version: QrVersions.auto,
                size: 128,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (wallet == null) {
      return whenWalletIsNull();
    } else {
      return whenWalletIsNotNull();
    }
  }
}

