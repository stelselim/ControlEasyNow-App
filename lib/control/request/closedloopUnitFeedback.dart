import 'dart:convert';

import 'package:controlapp/utility/makeSFunction.dart';
import 'package:http/http.dart' as http;

import 'package:controlapp/classes/systemTF.dart';

Future<TFModel> closedloopUnitFeedback(TFModel tfModel) async {
  String numParams = tfModel.toNum;
  String denParams = tfModel.toDen;
  // print(numParams);
  // print(denParams);

  var url =
      "https://controlalgo.ey.r.appspot.com/closedloop/unitfeedback?num=$numParams&den=$denParams";
  print(url);
  var res = await http.get(url, headers: {
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*"
  });
  if (jsonDecode(res.body)["Error"] != null)
    throw (jsonDecode(res.body)["Error"]);

  TFModel clSystem = TFModel(
    numeratorText:
        makeSfunctionWithCoeffs(jsonDecode(res.body)["systemNumerator"]),
    denominatorText:
        makeSfunctionWithCoeffs(jsonDecode(res.body)["systemDenominator"]),
    numeratorCoeffs: List<double>.from(jsonDecode(res.body)["systemNumerator"]),
    denominatorCoeffs:
        List<double>.from(jsonDecode(res.body)["systemDenominator"]),
  );
  return clSystem;
}
