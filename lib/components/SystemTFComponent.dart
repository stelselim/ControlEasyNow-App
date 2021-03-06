import 'package:controlapp/classes/systemTF.dart';
import 'package:flutter/material.dart';

class SystemTFComponent extends StatelessWidget {
  // System in Transfer Function Model
  final TFModel system;

  const SystemTFComponent({
    Key key,
    @required this.system,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Numerator
          Container(
            child: Text(
              system.numeratorText,
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),

          // Divider
          !(system.numeratorText != "" || system.denominatorText != "")
              ? Container()
              : Divider(
                  endIndent: MediaQuery.of(context).size.width / 9,
                  indent: MediaQuery.of(context).size.width / 9,
                  color: Colors.black,
                ),

          // Denominator
          Container(
            child: Text(
              system.denominatorText,
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          )
        ],
      ),
    );
  }
}
