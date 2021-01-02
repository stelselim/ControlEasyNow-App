import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:controlapp/classes/systemTF.dart';

Future<NyquistPlot> nyquistplot(TFModel tfModel) async {
  String numParams = tfModel.toNum;
  String denParams = tfModel.toDen;
  // print(numParams);
  // print(denParams);

  var url =
      "https://controlalgo.ey.r.appspot.com/nyquistplot?num=$numParams&den=$denParams";
  print(url);
  var res = await http.get(url, headers: {
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*"
  });
  if (jsonDecode(res.body)["Error"] != null)
    throw (jsonDecode(res.body)["Error"]);
  return NyquistPlot.fromJson(res.body);
}

class NyquistPlot {
  List<double> real;
  List<double> imag;
  List<double> freq;
  NyquistPlot({
    this.real,
    this.imag,
    this.freq,
  });

  Map<String, dynamic> toMap() {
    return {
      'real': real,
      'imag': imag,
      'freq': freq,
    };
  }

  factory NyquistPlot.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return NyquistPlot(
      real: List<double>.from(map['real']),
      imag: List<double>.from(map['imag']),
      freq: List<double>.from(map['freq']),
    );
  }

  String toJson() => json.encode(toMap());

  factory NyquistPlot.fromJson(String source) =>
      NyquistPlot.fromMap(json.decode(source));

  @override
  String toString() => 'NyquistPlot(real: $real, imag: $imag, freq: $freq)';
}
