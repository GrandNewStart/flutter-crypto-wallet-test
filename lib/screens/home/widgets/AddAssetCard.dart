import 'package:flutter/material.dart';

class AddAssetCard extends StatelessWidget {

  Function() onClick;

  AddAssetCard(this.onClick, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.blueGrey[100],
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: InkWell(
          onTap: onClick,
          splashColor: Colors.blueGrey[300],
          borderRadius: BorderRadius.circular(20.0),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Icon(Icons.add, size: 48, color: Colors.blueGrey),
            ),
          ),
        ),
      ),
    );
  }
}