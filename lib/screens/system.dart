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
import 'package:controlapp/provider/appstate.dart';
import 'package:controlapp/screens/analysis.dart';
import 'package:controlapp/utility/makeSFunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

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
              // Clear Transfer Function Button
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

              // Space
              SizedBox(
                height: 15,
              ),
              // Numerator Textfield
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
              // Denominator Textfield
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
              // Space
              SizedBox(
                height: 50,
              ),
              // TF Component
              SystemTFComponent(
                system: system,
              ),
              // Space
              SizedBox(
                height: 50,
              ),
              // Functions
              !system.isProper
                  ? Container()
                  : GridView(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: 35),
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 15,
                      ),
                      children: [
                        // Step Info
                        RaisedButton(
                          child: Text(
                            "Step Info",
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () async {
                            try {
                              var res = await stepinfo(system);
                              Provider.of<AppState>(context, listen: false)
                                  .setNewSystem(
                                system.copyWith(stepInfo: res),
                              );
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                        // Step Response
                        RaisedButton(
                          child: Text("Step Response"),
                          onPressed: () async {
                            try {
                              var res = await stepresponse(system);
                              Provider.of<AppState>(context, listen: false)
                                  .setNewSystem(
                                system.copyWith(stepResponse: res),
                              );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Analysis(
                                      system: Provider.of<AppState>(context,
                                              listen: false)
                                          .system,
                                      stepResponse: res,
                                    ),
                                  ));
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                        // Ramp Response
                        RaisedButton(
                          child: Text("Ramp Response"),
                          onPressed: () async {
                            try {
                              var res = await rampresponse(system);
                              Provider.of<AppState>(context, listen: false)
                                  .setNewSystem(
                                system.copyWith(rampResponse: res),
                              );
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                        // Impulse Response
                        RaisedButton(
                          child: Text("Impulse Response"),
                          onPressed: () async {
                            try {
                              var res = await impulseresponse(system);
                              Provider.of<AppState>(context, listen: false)
                                  .setNewSystem(
                                system.copyWith(impulseResponse: res),
                              );
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                        // Bode Plot
                        RaisedButton(
                          child: Text("Bode Plot"),
                          onPressed: () async {
                            try {
                              var res = await bodeplot(system);
                              Provider.of<AppState>(context, listen: false)
                                  .setNewSystem(
                                system.copyWith(bodePlot: res),
                              );
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                        // Rootlocus
                        RaisedButton(
                          child: Text("RootLocus"),
                          onPressed: () async {
                            try {
                              var res = await rlocusplot(system);
                              Provider.of<AppState>(context, listen: false)
                                  .setNewSystem(
                                system.copyWith(rlocusPlot: res),
                              );
                              await showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                        child: Container(
                                          height: 320,
                                          child: PhotoView(
                                            imageProvider: res.image,
                                          ),
                                        ),
                                      ));
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                        // Nyquist Plot
                        RaisedButton(
                          child: Text("Nyquist Plot"),
                          onPressed: () async {
                            try {
                              var res = await nyquistplot(system);
                              Provider.of<AppState>(context, listen: false)
                                  .setNewSystem(
                                system.copyWith(nyquistPlot: res),
                              );
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                        // Poles Zeros
                        RaisedButton(
                          child: Text(
                            "Poles Zeros",
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () async {
                            try {
                              var res = await poleszeros(system);
                              Provider.of<AppState>(context, listen: false)
                                  .setNewSystem(
                                system.copyWith(polesZeros: res),
                              );
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),

                        // Closed Loop
                        RaisedButton(
                          child: Text("Closed Loop"),
                          onPressed: () async {
                            try {
                              var res = await closedloopUnitFeedback(system);
                              Provider.of<AppState>(context, listen: false)
                                  .setNewSystem(
                                system.copyWith(closedLoop: res),
                              );
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
