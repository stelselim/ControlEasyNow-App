import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:controlapp/classes/systemTF.dart';

Future<StepResponse> stepresponse(TFModel tfModel) async {
  String numParams = tfModel.toNum;
  String denParams = tfModel.toDen;
  // print(numParams);
  // print(denParams);

  var url =
      "https://controlalgo.ey.r.appspot.com/stepresponse?num=$numParams&den=$denParams";
  print(url);
  var res = await http.get(url, headers: {
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*"
  });
  if (jsonDecode(res.body)["Error"] != null)
    throw (jsonDecode(res.body)["Error"]);
  return StepResponse.fromJson(res.body);
}

class StepResponse {
  List<double> x;
  List<double> y;
  StepResponse({
    this.x,
    this.y,
  });

  Map<String, dynamic> toMap() {
    return {
      'x': x,
      'y': y,
    };
  }

  factory StepResponse.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StepResponse(
      x: List<double>.from(map['x']),
      y: List<double>.from(map['y']),
    );
  }

  String toJson() => json.encode(toMap());

  factory StepResponse.fromJson(String source) =>
      StepResponse.fromMap(json.decode(source));
}
