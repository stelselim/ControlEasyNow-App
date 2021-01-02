import 'dart:convert';
import 'package:controlapp/classes/systemTF.dart';
import 'package:controlapp/components/SystemTFComponent.dart';
import 'package:controlapp/control/request/bodeplot.dart';
import 'package:controlapp/control/request/closedloopUnitFeedback.dart';
import 'package:controlapp/control/request/impulseresponse.dart';
import 'package:controlapp/control/request/nyquistplot.dart';
import 'package:controlapp/control/request/polesZeros.dart';
import 'package:controlapp/control/request/rampresponse.dart';
import 'package:controlapp/control/request/rlocusplot.dart';
import 'package:controlapp/control/request/stepinfo.dart';
import 'package:controlapp/control/request/stepresponse.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: Column(
            children: [
              !(system.numeratorText != "" || system.denominatorText != "")
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                          child: Text(
                            "Clear",
                            style: ThemeData.light().textTheme.headline1,
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              numeratorController.clear();
                              denominatorController.clear();
                              system.clear();
                            });
                          },
                        ),
                      ],
                    ),
              SizedBox(
                height: 15,
              ),
              Card(
                margin: EdgeInsets.all(10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
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
              SystemTFComponent(
                system: system,
              ),
              SizedBox(
                height: 50,
              ),
              !system.isProper
                  ? Container()
                  : GridView(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: 25),
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 15,
                      ),
                      children: [
                        RaisedButton(
                          child: Text(
                            "Step Info",
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () async {
                            try {
                              var res = await stepinfo(system);
                              print(res);
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                        RaisedButton(
                          child: Text("Step Response"),
                          onPressed: () async {
                            try {
                              var res = await stepresponse(system);
                              print(res);
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                        RaisedButton(
                          child: Text("Ramp Response"),
                          onPressed: () async {
                            try {
                              var res = await rampresponse(system);
                              print(res);
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                        RaisedButton(
                          child: Text("Impulse Response"),
                          onPressed: () async {
                            try {
                              var res = await impulseresponse(system);
                              print(res);
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                        RaisedButton(
                          child: Text("BodePlot"),
                          onPressed: () async {
                            try {
                              var res = await bodeplot(system);
                              print(res);
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                        RaisedButton(
                          child: Text("RootLocus"),
                          onPressed: () async {
                            try {
                              var res = await rlocusplot(system);
                              print(res.points.toString());
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                        RaisedButton(
                          child: Text("Nyquist"),
                          onPressed: () async {
                            try {
                              var res = await nyquistplot(system);
                              print(res.freq);
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                        RaisedButton(
                          child: Text(
                            "Poles Zeros",
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () async {
                            try {
                              var res = await poleszeros(system);
                              print(res.zeros.toString());
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                        RaisedButton(
                          child: Text("Closed Loop"),
                          onPressed: () async {
                            try {
                              var res = await closedloopUnitFeedback(system);
                              print(res.numeratorCoeffs);
                              print(res.denominatorCoeffs);
                              print(res.numeratorText);
                              print(res.denominatorText);
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
