import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:controlapp/classes/systemTF.dart';

Future<ImpulseResponse> impulseresponse(TFModel tfModel) async {
  String numParams = tfModel.toNum;
  String denParams = tfModel.toDen;
  // print(numParams);
  // print(denParams);

  var url =
      "https://controlalgo.ey.r.appspot.com/impulseresponse?num=$numParams&den=$denParams";
  print(url);
  var res = await http.get(url, headers: {
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*"
  });
  if (jsonDecode(res.body)["Error"] != null)
    throw (jsonDecode(res.body)["Error"]);
  return ImpulseResponse.fromJson(res.body);
}

class ImpulseResponse {
  List<double> x;
  List<double> y;
  ImpulseResponse({
    this.x,
    this.y,
  });

  Map<String, dynamic> toMap() {
    return {
      'x': x,
      'y': y,
    };
  }

  factory ImpulseResponse.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ImpulseResponse(
      x: List<double>.from(map['x']),
      y: List<double>.from(map['y']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ImpulseResponse.fromJson(String source) =>
      ImpulseResponse.fromMap(json.decode(source));
}
