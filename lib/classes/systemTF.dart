import 'package:flutter/material.dart';

import 'package:controlapp/control/request/bodeplot.dart';
import 'package:controlapp/control/request/closedloopUnitFeedback.dart';
import 'package:controlapp/control/request/impulseresponse.dart';
import 'package:controlapp/control/request/nyquistplot.dart';
import 'package:controlapp/control/request/polesZeros.dart';
import 'package:controlapp/control/request/rampresponse.dart';
import 'package:controlapp/control/request/stepinfo.dart';
import 'package:controlapp/control/request/stepresponse.dart';

class TFModel {
  String numeratorText;
  String denominatorText;

  StepInfo stepInfo;
  StepResponse stepResponse;
  Image rlocusPlot;
  RampResponse rampResponse;
  PolesZeros polesZeros;
  NyquistPlot nyquistPlot;
  ImpulseResponse impulseResponse;
  ClosedLoop closedLoop;
  BodePlot bodePlot;

  List<double> numeratorCoeffs = [];
  List<double> denominatorCoeffs = [];

  TFModel({
    this.closedLoop,
    this.bodePlot,
    this.impulseResponse,
    this.nyquistPlot,
    this.polesZeros,
    this.rampResponse,
    this.rlocusPlot,
    this.stepResponse,
    this.stepInfo,
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

  TFModel copyWith({
    String numeratorText,
    String denominatorText,
    StepInfo stepInfo,
    StepResponse stepResponse,
    Image rlocusPlot,
    RampResponse rampResponse,
    PolesZeros polesZeros,
    NyquistPlot nyquistPlot,
    ImpulseResponse impulseResponse,
    ClosedLoop closedLoop,
    BodePlot bodePlot,
    List<double> numeratorCoeffs,
    List<double> denominatorCoeffs,
  }) {
    return TFModel(
      numeratorText: numeratorText ?? this.numeratorText,
      denominatorText: denominatorText ?? this.denominatorText,
      stepInfo: stepInfo ?? this.stepInfo,
      stepResponse: stepResponse ?? this.stepResponse,
      rlocusPlot: rlocusPlot ?? this.rlocusPlot,
      rampResponse: rampResponse ?? this.rampResponse,
      polesZeros: polesZeros ?? this.polesZeros,
      nyquistPlot: nyquistPlot ?? this.nyquistPlot,
      impulseResponse: impulseResponse ?? this.impulseResponse,
      closedLoop: closedLoop ?? this.closedLoop,
      bodePlot: bodePlot ?? this.bodePlot,
      numeratorCoeffs: numeratorCoeffs ?? this.numeratorCoeffs,
      denominatorCoeffs: denominatorCoeffs ?? this.denominatorCoeffs,
    );
  }
}
