import 'package:flutter/material.dart';

class TFModel {
  String numeratorText;
  String denominatorText;

  List<double> numeratorCoeffs = [];
  List<double> denominatorCoeffs = [];

  TFModel({
    @required this.numeratorText,
    @required this.denominatorText,
    @required this.numeratorCoeffs,
    @required this.denominatorCoeffs,
  });

  String get toNum {
    String toNum = "";
    for (var e in numeratorCoeffs) {
      // If last, no need to put comma
      if (e == numeratorCoeffs.last) {
        toNum = toNum + "$e";
      } else {
        toNum = toNum + "$e,";
      }
    }
    return toNum;
  }

  String get toDen {
    String toDen = "";
    for (var e in numeratorCoeffs) {
      // If last, no need to put comma
      if (e == numeratorCoeffs.last) {
        toDen = toDen + "$e";
      } else {
        toDen = toDen + "$e,";
      }
    }
    return toDen;
  }
}
