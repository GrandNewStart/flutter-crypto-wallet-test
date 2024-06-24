import 'package:flutter/material.dart';
import 'package:flutter_test_wallet/wallet/Network.dart';

class NetworkDropdown extends StatefulWidget {

  final List<Network> _networks;
  int _networkIndex = 0;
  final Function(int) _didSelectedNetwork;

  NetworkDropdown(this._networks, this._networkIndex, this._didSelectedNetwork, {super.key});

  @override
  State<NetworkDropdown> createState() => _NetworkDropdownState();
}

class _NetworkDropdownState extends State<NetworkDropdown> {

  void changeNetwork(Network? network) {
    if (network == null) return;
    setState(() {
      widget._networkIndex = widget._networks.indexOf(network);
      widget._didSelectedNetwork(widget._networkIndex);
    });
  }

  Widget dropdownItem(Network network, int selected) {
    return InkWell(
      splashColor: Colors.blueGrey[500],
      borderRadius: BorderRadius.circular(20.0),
      child: Text(network.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey[100],
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: DropdownButton(
            items: widget._networks.map((Network network) {
              return DropdownMenuItem<Network>(
                  value: network,
                  child: dropdownItem(network, widget._networkIndex)
              );
            }).toList(),
            onChanged: changeNetwork,
            value: widget._networks[widget._networkIndex],
            dropdownColor: Colors.blueGrey[100],
            borderRadius: BorderRadius.circular(20.0),
            isExpanded: false,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          ),
        ),
        const SizedBox(height: 8)
      ],
    );
  }
}