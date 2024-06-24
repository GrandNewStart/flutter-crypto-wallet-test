import 'package:flutter/material.dart';
import 'package:flutter_test_wallet/screens/home/widgets/AddAssetCard.dart';
import 'package:flutter_test_wallet/screens/home/widgets/NetworkDropdown.dart';
import 'package:flutter_test_wallet/screens/home/widgets/AssetCard.dart';
import 'package:flutter_test_wallet/screens/home/widgets/WalletAddressCard.dart';
import 'package:flutter_test_wallet/screens/newAsset/NewAssetPage.dart';
import 'package:flutter_test_wallet/screens/settings/SettingsPage.dart';
import 'package:flutter_test_wallet/services/WalletService.dart';
import 'package:flutter_test_wallet/wallet/Network.dart';
import 'package:flutter_test_wallet/wallet/Asset.dart';
import 'package:flutter_test_wallet/wallet/Wallet.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Wallet? _wallet;
  final List<Asset> _coins = [
    Asset('Bitcoin', 'BTC', null, 5),
    Asset('Ripple', 'XRP', null, 5),
    Asset('Ethereum', 'ETH', null, 5),
  ];
  final List<Asset> _tokens = [
    Asset('Exp1Token', 'EXP1', 'contract-address-1', 5),
    Asset('Exp2Token', 'EXP2', 'contract-address-2', 5),
    Asset('Exp3Token', 'EXP3', 'contract-address-3', 5),
  ];
  int _networkIndex = 0;
  final List<Network> _networks = [
    Network('Ethereum Mainnet', 'eth-rpc-url', 1, 'ETH', 'block-explorer-url'),
    Network('Example1 Network', 'exp1-rpc-url', 101, 'EXP1', 'block-explorer-url'),
    Network('Example2 Network', 'exp2-rpc-url', 102, 'EXP2', 'block-explorer-url'),
    Network('Example3 Network', 'exp3-rpc-url', 103, 'EXP3', 'block-explorer-url'),
  ];

  _HomePageState() {
    WalletService.getWallet().then((wallet) =>
    {
      setState(() {
        _wallet = wallet;
      })
    });
  }

  void createWallet() async {
    final wallet = await WalletService.createNewWallet();
    setState(() {
      _wallet = wallet;
    });
    Fluttertoast.showToast(msg: 'new wallet created');
  }

  void deleteWallet() async {
    await WalletService.removeWallet();
    setState(() {
      _wallet = null;
    });
    Fluttertoast.showToast(msg: 'wallet removed');
  }

  void addNewAsset() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
        NewAssetPage(addNewAsset: (name, symbol, contract, decimals) =>
          {
            setState(() {
              _tokens.add(Asset(name, symbol, contract, decimals));
              Navigator.pop(context);
            })
          }
        )
      )
    );
  }

  void changeNetwork(int index) {
    if (index >= _networks.length) return;
    setState(() {
      _networkIndex = index;
    });
  }

  AppBar appBar() {
    return AppBar(
      title: const Text('Test Wallet',
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white)),
      backgroundColor: Colors.blueGrey,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SettingsPage(_wallet, deleteWallet)),
            );
          },
        ),
      ],
    );
  }

  Widget body() {
    return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: WalletAddressCard(wallet: _wallet, createWallet: createWallet),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)
                )
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    if (_wallet != null)
                      NetworkDropdown(_networks, _networkIndex, changeNetwork),
                    if (_wallet != null)
                      ..._coins.map((asset) => AssetCard(asset: asset)),
                    if (_wallet != null)
                      ..._tokens.map((asset) => AssetCard(asset: asset)),
                    if (_wallet != null)
                      AddAssetCard(addNewAsset),
                    const SizedBox(height: 64)
                  ],
                ),
              ),
            ),
          )
      ]
    );
  }

  Widget body2() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: WalletAddressCard(wallet: _wallet, createWallet: createWallet),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)
              )
            ),
            child: Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  if (_wallet != null)
                    NetworkDropdown(_networks, _networkIndex, changeNetwork),
                  if (_wallet != null)
                    ..._coins.map((asset) => AssetCard(asset: asset)),
                  if (_wallet != null)
                    ..._tokens.map((asset) => AssetCard(asset: asset)),
                  if (_wallet != null)
                    AddAssetCard(addNewAsset),
                ],
              ),
            ),
          )
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: appBar(),
          body: body2(),
          backgroundColor: Colors.blueGrey[300]);
}
