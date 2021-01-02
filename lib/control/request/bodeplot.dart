import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:controlapp/classes/systemTF.dart';

Future<BodePlot> bodeplot(TFModel tfModel) async {
  String numParams = tfModel.toNum;
  String denParams = tfModel.toDen;
  // print(numParams);
  // print(denParams);

  var url =
      "https://controlalgo.ey.r.appspot.com/bodeplot?num=$numParams&den=$denParams";
  print(url);
  var res = await http.get(url, headers: {
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*"
  });
  if (jsonDecode(res.body)["Error"] != null)
    throw (jsonDecode(res.body)["Error"]);
  return BodePlot.fromJson(res.body);
}

class BodePlot {
  List<double> mag;
  List<double> phase;
  List<double> omega;
  BodePlot({
    this.mag,
    this.phase,
    this.omega,
  });

  Map<String, dynamic> toMap() {
    return {
      'mag': mag,
      'phase': phase,
      'omega': omega,
    };
  }

  factory BodePlot.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return BodePlot(
      mag: List<double>.from(map['mag']),
      phase: List<double>.from(map['phase']),
      omega: List<double>.from(map['omega']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BodePlot.fromJson(String source) =>
      BodePlot.fromMap(json.decode(source));
}
