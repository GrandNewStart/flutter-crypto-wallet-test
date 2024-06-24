import 'package:flutter/material.dart';

class SettingsItemDelete extends StatelessWidget {

  final VoidCallback onDelete;

  const SettingsItemDelete(this.onDelete, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[200],
      child: InkWell(
        onTap: onDelete,
        borderRadius: BorderRadius.circular(10.0),
        splashColor: Colors.blueGrey[300],
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Delete Wallet', style: TextStyle(fontWeight: FontWeight.w800)),
              Icon(Icons.delete_outline, color: Colors.black, size: 24,)
            ],
          ),
        ),
      ),
    );
  }

}