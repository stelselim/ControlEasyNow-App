import 'package:controlapp/classes/tfModel.dart';
import 'package:flutter/material.dart';

class SystemTfModel extends StatelessWidget {
  // System in Transfer Function Model
  final TFModel system;

  const SystemTfModel({
    Key key,
    @required this.system,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Text(
              system.numeratorText,
              textScaleFactor: 2,
            ),
          ),
          Divider(),
          Container(
            child: Text(
              system.denominatorText,
              textScaleFactor: 2,
            ),
          )
        ],
      ),
    );
  }
}
