import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:controlapp/classes/systemTF.dart';

Future<PolesZeros> poleszeros(TFModel tfModel) async {
  String numParams = tfModel.toNum;
  String denParams = tfModel.toDen;
  // print(numParams);
  // print(denParams);

  var url =
      "https://controlalgo.ey.r.appspot.com/poleszeros?num=$numParams&den=$denParams";
  print(url);
  var res = await http.get(url, headers: {
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*"
  });
  if (jsonDecode(res.body)["Error"] != null)
    throw (jsonDecode(res.body)["Error"]);
  return PolesZeros.fromJson(res.body);
}

class PolesZeros {
  List<ComplexNumber> poles;
  List<ComplexNumber> zeros;
  PolesZeros({
    this.poles,
    this.zeros,
  });

  Map<String, dynamic> toMap() {
    return {
      'poles': poles?.map((x) => x?.toMap())?.toList(),
      'zeros': zeros?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory PolesZeros.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PolesZeros(
      poles: List<ComplexNumber>.from(
        map['poles']?.map((x) => ComplexNumber.fromMap(x)),
      ),
      zeros: List<ComplexNumber>.from(
        map['zeros']?.map((x) => ComplexNumber.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PolesZeros.fromJson(String source) =>
      PolesZeros.fromMap(json.decode(source));

  @override
  String toString() => 'PolesZeros(poles: $poles, zeros: $zeros)';
}

class ComplexNumber {
  double real;
  double imag;
  ComplexNumber({
    this.real,
    this.imag,
  });

  Map<String, dynamic> toMap() {
    return {
      'real': real,
      'imag': imag,
    };
  }

  factory ComplexNumber.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ComplexNumber(
      real: map['real'],
      imag: map['imag'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ComplexNumber.fromJson(String source) =>
      ComplexNumber.fromMap(json.decode(source));

  @override
  String toString() => 'ComplexNumber(real: $real, imag: $imag)';
}
