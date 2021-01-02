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
    for (int i = 0; i < numeratorCoeffs.length; i++) {
      // If last, no need to put comma
      if (i == numeratorCoeffs.length - 1) {
        var e = numeratorCoeffs.elementAt(i);
        toNum = toNum + "$e";
      } else {
        var e = numeratorCoeffs.elementAt(i);
        toNum = toNum + "$e,";
      }
    }
    return toNum;
  }

  String get toDen {
    String toDen = "";
    for (int i = 0; i < denominatorCoeffs.length; i++) {
      // If last, no need to put comma
      if (i == denominatorCoeffs.length - 1) {
        var e = denominatorCoeffs.elementAt(i);
        toDen = toDen + "$e";
      } else {
        var e = denominatorCoeffs.elementAt(i);
        toDen = toDen + "$e,";
      }
    }
    return toDen;
  }

  bool get isProper {
    // Proper Check For Transfer Function
    if (denominatorCoeffs.length > 1 &&
        numeratorCoeffs.length != 0 &&
        numeratorCoeffs.length <= denominatorCoeffs.length) {
      return true;
    } else {
      return false;
    }
  }

  void clear() {
    numeratorText = "";
    denominatorText = "";

    numeratorCoeffs = [];
    denominatorCoeffs = [];
  }
}
