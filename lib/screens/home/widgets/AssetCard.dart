import 'package:flutter/material.dart';
import 'package:flutter_test_wallet/wallet/Asset.dart';

class AssetCard extends StatefulWidget {

  final Asset asset;

  const AssetCard({super.key, required this.asset});

  @override
  State<AssetCard> createState() => _AssetCardState();
}

class _AssetCardState extends State<AssetCard> {

  double _balance = 0;

  void getBalance() async {
    setState(() {
      _balance = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {

    getBalance();

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Card(
            color: widget.asset.contract == null ? Colors.amber[400] : Colors.blueGrey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 2,
            child: InkWell(
              onTap: () {},
              splashColor: widget.asset.contract == null ? Colors.amber[600] : Colors.blueGrey[500],
              borderRadius: BorderRadius.circular(20.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.asset.name,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$_balance ${widget.asset.symbol}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}