import 'package:controlapp/classes/tfModel.dart';
import 'package:controlapp/components/tfSystem.dart';
import 'package:controlapp/utility/makeSFunction.dart';
import 'package:flutter/material.dart';

class System extends StatefulWidget {
  @override
  _SystemState createState() => _SystemState();
}

class _SystemState extends State<System> {
  TextEditingController numeratorController = TextEditingController();
  TextEditingController denominatorController = TextEditingController();

  String numeratorText = "";
  List<double> numeratorCoeffs = [];
  String denominatorText = "";
  List<double> denominatorCoeffs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("System"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                controller: numeratorController,
                decoration: InputDecoration(labelText: "Numerator"),
                onChanged: (val) {
                  setState(() {
                    numeratorText = makeSfunction(val);
                    numeratorCoeffs = getCoeffs(val);
                  });
                },
              ),
              TextField(
                controller: denominatorController,
                decoration: InputDecoration(labelText: "Denominator"),
                onChanged: (val) {
                  setState(() {
                    denominatorText = makeSfunction(val);
                    denominatorCoeffs = getCoeffs(val);
                  });
                },
              ),
              SizedBox(
                height: 50,
              ),
              SystemTfModel(
                system: TFModel(
                  numeratorText: numeratorText,
                  denominatorText: denominatorText,
                  numeratorCoeffs: numeratorCoeffs,
                  denominatorCoeffs: denominatorCoeffs,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
