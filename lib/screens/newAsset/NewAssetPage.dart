import 'package:flutter/material.dart';

class NewAssetPage extends StatefulWidget {

  final Function(String, String, String, int) addNewAsset;

  const NewAssetPage({super.key, required this.addNewAsset});

  @override
  State<StatefulWidget> createState() => _NewAssetPageState();
}

class _NewAssetPageState extends State<NewAssetPage> {

  String? _name;
  String? _symbol;
  String? _contract;
  int? _decimals;

  void addNewToken() {
    if (_name == null || _symbol == null || _contract == null || _decimals == null) return;
    widget.addNewAsset(_name!, _symbol!, _contract!, _decimals!);
  }

  AppBar appBar() {
    return AppBar(
      title: const Text('New Token', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white)),
      backgroundColor: Colors.blueGrey,
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top content
          Column(
            children: [
              textField('Name', TextInputType.text, (text) {
                setState(() {
                  _name = text;
                });
              }),
              const SizedBox(height: 16),
              textField('Symbol', TextInputType.text, (text) {
                setState(() {
                  _symbol = text;
                });
              }),
              const SizedBox(height: 16),
              textField('Contract Address', TextInputType.text, (text) {
                setState(() {
                  _contract = text;
                });
              }),
              const SizedBox(height: 16),
              textField('Decimals', TextInputType.number, (text) {
                setState(() {
                  _decimals = int.tryParse(text);
                });
              }),
            ],
          ),
          // Bottom button
          Column(
            children: [
              MaterialButton(
                onPressed: addNewToken,
                color: Colors.blueGrey,
                minWidth: double.infinity,
                height: 50,
                child: const Text('Confirm', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 18)),
              ),
              const SizedBox(height: 32)
            ],
          ),
        ],
      ),
    );
  }

  Widget textField(String key, TextInputType inputType, Function(String) onTextChange) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(key, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white)),
        const SizedBox(height: 8),
        TextField(
            style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
            keyboardType: inputType,
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            ),
            onChanged: onTextChange,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: appBar(),
    body: body(),
    backgroundColor: Colors.blueGrey[300]
  );

}