import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:controlapp/classes/systemTF.dart';

Future<StepInfo> stepinfo(TFModel tfModel) async {
  String numParams = tfModel.toNum;
  String denParams = tfModel.toDen;
  // print(numParams);
  // print(denParams);

  var url =
      "https://controlalgo.ey.r.appspot.com/stepinfo?num=$numParams&den=$denParams";
  print(url);
  var res = await http.get(url, headers: {
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*"
  });
  if (jsonDecode(res.body)["Error"] != null)
    throw (jsonDecode(res.body)["Error"]);
  return StepInfo.fromJson(res.body);
}

class StepInfo {
  double riseTime;
  double settlingTime;
  double settlingMin;
  double settlingMax;
  double overshoot;
  double undershoot;
  double peak;
  double peakTime;
  double steadyStateValue;
  StepInfo({
    this.riseTime,
    this.settlingTime,
    this.settlingMin,
    this.settlingMax,
    this.overshoot,
    this.undershoot,
    this.peak,
    this.peakTime,
    this.steadyStateValue,
  });

  Map<String, dynamic> toMap() {
    return {
      'RiseTime': riseTime,
      'SettlingTime': settlingTime,
      'SettlingMin': settlingMin,
      'SettlingMax': settlingMax,
      'Overshoot': overshoot,
      'Undershoot': undershoot,
      'Peak': peak,
      'PeakTime': peakTime,
      'SteadyStateValue': steadyStateValue,
    };
  }

  factory StepInfo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StepInfo(
      riseTime: map['RiseTime'],
      settlingTime: map['SettlingTime'],
      settlingMin: map['SettlingMin'],
      settlingMax: map['SettlingMax'],
      overshoot: map['Overshoot'],
      undershoot: map['Undershoot'],
      peak: map['Peak'],
      peakTime: map['PeakTime'],
      steadyStateValue: map['SteadyStateValue'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StepInfo.fromJson(String source) =>
      StepInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StepInfo(riseTime: $riseTime, settlingTime: $settlingTime, settlingMin: $settlingMin, settlingMax: $settlingMax, overshoot: $overshoot, undershoot: $undershoot, peak: $peak, peakTime: $peakTime, steadyStateValue: $steadyStateValue)';
  }
}
