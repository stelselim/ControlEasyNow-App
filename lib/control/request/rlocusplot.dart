import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:controlapp/classes/systemTF.dart';

Future<Image> rlocusplot(TFModel tfModel) async {
  String numParams = tfModel.toNum;
  String denParams = tfModel.toDen;
  // print(numParams);
  // print(denParams);

  var url =
      "https://controlalgo.ey.r.appspot.com/rlocusplot?num=$numParams&den=$denParams";
  print(url);
  var res = await http.get(url, headers: {"Access-Control-Allow-Origin": "*"});

  var image = Image.memory(res.bodyBytes);
  return image;
}
