import 'package:flutter/material.dart';
import 'package:flutter_test_wallet/screens/home/HomePage.dart';

void main() => runApp(const TestWallet());

class TestWallet extends StatelessWidget {

  const TestWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Wallet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }

}

