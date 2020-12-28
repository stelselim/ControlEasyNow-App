import 'dart:convert';

import 'package:controlapp/classes/tfModel.dart';
import 'package:controlapp/components/SystemTFModel.dart';
import 'package:controlapp/utility/makeSFunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class System extends StatefulWidget {
  @override
  _SystemState createState() => _SystemState();
}

class _SystemState extends State<System> {
  TextEditingController numeratorController = TextEditingController();
  TextEditingController denominatorController = TextEditingController();

  var system = TFModel(
    numeratorText: "",
    denominatorText: "",
    numeratorCoeffs: [],
    denominatorCoeffs: [],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("System"),
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.all(10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: numeratorController,
                    decoration: InputDecoration(labelText: "Numerator"),
                    onChanged: (val) {
                      setState(() {
                        try {
                          system.numeratorText = makeSfunction(val);
                          system.numeratorCoeffs = getCoeffs(val);
                        } catch (e) {}
                      });
                    },
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: denominatorController,
                    decoration: InputDecoration(labelText: "Denominator"),
                    onChanged: (val) {
                      setState(() {
                        try {
                          system.denominatorText = makeSfunction(val);
                          system.denominatorCoeffs = getCoeffs(val);
                        } catch (e) {}
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              SystemTfModel(
                system: system,
              ),
              SizedBox(
                height: 50,
              ),
              !system.isProper
                  ? Container()
                  : Container(
                      height: 450,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(
                            child: Text("Step Info"),
                            onPressed: () async {
                              try {
                                String numParams = system.toNum;
                                String denParams = system.toDen;
                                print(numParams);
                                print(denParams);
                                var url =
                                    "https://controlalgo.ey.r.appspot.com/stepinfo?num=$numParams&den=$denParams";
                                print(url);
                                var res = await http.get(url, headers: {
                                  "Accept": "application/json",
                                  "Access-Control-Allow-Origin": "*"
                                });

                                print(jsonDecode(res.body));
                              } catch (e) {
                                print(e);
                              }
                            },
                          ),
                          RaisedButton(
                            child: Text("Step Response"),
                            onPressed: () async {
                              try {} catch (e) {}
                            },
                          ),
                          RaisedButton(
                            child: Text("Ramp Response"),
                            onPressed: () {},
                          ),
                          RaisedButton(
                            child: Text("Impulse Response"),
                            onPressed: () {},
                          ),
                          RaisedButton(
                            child: Text("BodePlot"),
                            onPressed: () {},
                          ),
                          RaisedButton(
                            child: Text("RootLocus"),
                            onPressed: () {},
                          ),
                          RaisedButton(
                            child: Text("Nyquist"),
                            onPressed: () {},
                          ),
                          RaisedButton(
                            child: Text("Poles Zeros"),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
