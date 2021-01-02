String makeSfunction(String value) {
  /// Remove Blank Spaces
  value = value.trim();

  /// Split Text to Coeffs
  /// Comma (',') or Space (' ')
  var values = value.contains(',') ? value.split(',') : value.split(' ');

  String text = ""; // Return text;
  int order = 0; // order follows order of s

  for (int i = 0; i < values.length; i++) {
    // Each number will be double first
    var n = double.tryParse(values[i]);

    // Order value takes order of s
    order = values.length - i - 1;

    // If number n = 0; Coeffs do not need to add to text.
    if (n == 0) continue;

    // This if will represent Constant Coeffs,
    // For example: + 5, -2, 2.5
    if (order == 0) {
      // Sign is important to take before adding number to text.
      // Because, plus or minus sign changes by sign of Constant Variable
      String sign = n.isNegative ? "-" : "+";

      // If number is POSITIVE, and i==0 (Which means the highest order term),
      // A Sign is not needed to put.
      // For example:
      //      + 2  => Wrong
      //        2  => Correct
      // If number is NEGATIVE, sign is needed
      //      - 2  => Correct

      if (i == 0 && !n.isNegative) sign = "";

      // Sign added properly, just take absolute value of number
      n = n.isNegative ? -1 * n : n;

      /// Text to be concatenated
      /// IF there is no sign, it's okay
      text = text + " $sign $n";
    }
    // This if will represent s Terms Coeffs,
    // For example: s^2 + 2*s
    else {
      // Sign is important to take before adding number to text.
      // Because, plus or minus sign changes by sign of s Terms Coeffs
      String sign = n.isNegative ? "-" : "+";

      // If number is POSITIVE, and i==0 (Which means the highest order term),
      // A Sign is not needed to put.
      // For example:
      //      + 2 * s^2  + 5 => Wrong
      //      2 * s^2  + 5 => Correct
      // If number is NEGATIVE, sign is needed
      //      - 2 * s^2  + 5 => Correct
      if (i == 0 && !n.isNegative) sign = "";

      // Sign added properly, just take absolute value of number
      n = n.isNegative ? -1 * n : n;

      // IF coeffs n==1:
      // No need to say: 1*s^2  or  1*s^6
      if (n == 1) {
        text = text + " $sign s^$order";
      }
      // Need to say: 2*s^2  or  22.1*s^6
      else {
        text = text + " $sign $n s^$order";
      }
    }
  }

  // and Returns Text
  return text;
}

String makeSfunctionWithCoeffs(List<dynamic> values) {
  String text = ""; // Return text;
  int order = 0; // order follows order of s

  for (int i = 0; i < values.length; i++) {
    // Each number will be double first
    var n = values[i];

    // Order value takes order of s
    order = values.length - i - 1;

    // If number n = 0; Coeffs do not need to add to text.
    if (n == 0) continue;

    // This if will represent Constant Coeffs,
    // For example: + 5, -2, 2.5
    if (order == 0) {
      // Sign is important to take before adding number to text.
      // Because, plus or minus sign changes by sign of Constant Variable
      String sign = n.isNegative ? "-" : "+";

      // If number is POSITIVE, and i==0 (Which means the highest order term),
      // A Sign is not needed to put.
      // For example:
      //      + 2  => Wrong
      //        2  => Correct
      // If number is NEGATIVE, sign is needed
      //      - 2  => Correct

      if (i == 0 && !n.isNegative) sign = "";

      // Sign added properly, just take absolute value of number
      n = n.isNegative ? -1 * n : n;

      /// Text to be concatenated
      /// IF there is no sign, it's okay
      text = text + " $sign $n";
    }
    // This if will represent s Terms Coeffs,
    // For example: s^2 + 2*s
    else {
      // Sign is important to take before adding number to text.
      // Because, plus or minus sign changes by sign of s Terms Coeffs
      String sign = n.isNegative ? "-" : "+";

      // If number is POSITIVE, and i==0 (Which means the highest order term),
      // A Sign is not needed to put.
      // For example:
      //      + 2 * s^2  + 5 => Wrong
      //      2 * s^2  + 5 => Correct
      // If number is NEGATIVE, sign is needed
      //      - 2 * s^2  + 5 => Correct
      if (i == 0 && !n.isNegative) sign = "";

      // Sign added properly, just take absolute value of number
      n = n.isNegative ? -1 * n : n;

      // IF coeffs n==1:
      // No need to say: 1*s^2  or  1*s^6
      if (n == 1) {
        text = text + " $sign s^$order";
      }
      // Need to say: 2*s^2  or  22.1*s^6
      else {
        text = text + " $sign $n s^$order";
      }
    }
  }

  // and Returns Text
  return text;
}

List<double> getCoeffs(String value) {
  /// Remove Blank Spaces
  value = value.trim();

  /// Split Text to Coeffs
  /// Comma (',') or Space (' ')
  var values = value.contains(',') ? value.split(',') : value.split(' ');
  return values.map((e) => double.tryParse(e)).toList();
}
