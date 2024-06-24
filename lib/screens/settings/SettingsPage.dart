import 'package:flutter/material.dart';
import 'package:flutter_test_wallet/wallet/Wallet.dart';
import 'widgets/SettingsItemAddress.dart';
import 'widgets/SettingsItemDelete.dart';
import 'widgets/SettingsItemMnemonic.dart';

class SettingsPage extends StatefulWidget {

  final Wallet? _wallet;
  final Function() _onDelete;

  const SettingsPage(this._wallet, this._onDelete, {super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();

}

class _SettingsPageState extends State<SettingsPage> {

  Future<void> _confirmDeleteWallet() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Wallet'),
          content: const Text('Are you sure you want to delete the wallet? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async => Navigator.pop(context, true),
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      await widget._onDelete();
      Navigator.pop(context);
    }
  }

  AppBar appBar() {
    return AppBar(
      title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white)),
      backgroundColor: Colors.blueGrey[500],
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (widget._wallet == null)
              const ListTile(
                title: Text('The wallet is not yet created', style: TextStyle(fontWeight: FontWeight.w800)),
              )
            else
              SettingsItemAddress(widget._wallet!),
              SettingsItemMnemonic(widget._wallet!),
              SettingsItemDelete(_confirmDeleteWallet)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: appBar(),
      body: body(),
      backgroundColor: Colors.blueGrey[300]
  );
}
