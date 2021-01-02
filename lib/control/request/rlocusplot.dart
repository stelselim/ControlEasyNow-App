import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:controlapp/classes/systemTF.dart';

Future<RlocusPlot> rlocusplot(TFModel tfModel) async {
  String numParams = tfModel.toNum;
  String denParams = tfModel.toDen;
  // print(numParams);
  // print(denParams);

  var url =
      "https://controlalgo.ey.r.appspot.com/rlocusplot?num=$numParams&den=$denParams";
  print(url);
  var res = await http.get(url, headers: {
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*"
  });
  if (jsonDecode(res.body)["Error"] != null)
    throw (jsonDecode(res.body)["Error"]);
  return RlocusPlot.fromJson(res.body);
}

class RlocusPlot {
  List<Point> points;
  RlocusPlot({
    this.points,
  });

  Map<String, dynamic> toMap() {
    return {
      'points': points?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory RlocusPlot.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RlocusPlot(
      points:
          List<Point>.from(map['points']?.map((val) => Point.fromList(val))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RlocusPlot.fromJson(String source) =>
      RlocusPlot.fromMap(json.decode(source));
}

class Point {
  double x;
  double y;
  Point({
    this.x,
    this.y,
  });

  Map<String, dynamic> toMap() {
    return {
      'x': x,
      'y': y,
    };
  }

  factory Point.fromList(List<dynamic> map) {
    if (map == null) return null;

    return Point(
      x: map[0],
      y: map[1],
    );
  }

  String toJson() => json.encode(toMap());

  factory Point.fromJson(String source) => Point.fromList(json.decode(source));

  @override
  String toString() => 'Point(x: $x, y: $y)';
}
