import 'package:controlapp/provider/appstate.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({
    Key key,
  }) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  List<FlSpot> makeData() {
    var x = res['x'];
    var y = res['y'];
    List<FlSpot> dat = [];
    for (int i = 0; i < x.length; i += 1) {
      dat.add(FlSpot(x.elementAt(i), (y.elementAt(i) * 10000).round() / 10000));
    }
    return dat;
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        // touchSpotThreshold: 0.5,
        touchTooltipData: LineTouchTooltipData(),
      ),
      gridData: FlGridData(
        show: true,
        // drawVerticalLine: true,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 2,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) => value.toString(),
          margin: 3,
        ),
        leftTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => const TextStyle(
                  color: Color(0xff67727d),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
            getTitles: (value) {
              return (value).toStringAsFixed(2).toString();
            },
            interval: 0.1
            // reservedSize: 28,
            // margin: 12,
            ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1),
      ),
      minX: 0,
      maxX: res['x'].last,
      minY: 0,
      maxY: 0.51,
      lineBarsData: [
        LineChartBarData(
          spots: makeData(),
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 120,
          ),
          Center(
            child: LineChart(
              mainData(),
            ),
          ),
        ],
      ),
    );
  }
}

var res = {
  "x": [
    0.0,
    0.0707070707070707,
    0.1414141414141414,
    0.2121212121212121,
    0.2828282828282828,
    0.35353535353535354,
    0.4242424242424242,
    0.4949494949494949,
    0.5656565656565656,
    0.6363636363636364,
    0.7070707070707071,
    0.7777777777777778,
    0.8484848484848484,
    0.9191919191919191,
    0.9898989898989898,
    1.0606060606060606,
    1.1313131313131313,
    1.202020202020202,
    1.2727272727272727,
    1.3434343434343434,
    1.4141414141414141,
    1.4848484848484849,
    1.5555555555555556,
    1.6262626262626263,
    1.6969696969696968,
    1.7676767676767675,
    1.8383838383838382,
    1.909090909090909,
    1.9797979797979797,
    2.0505050505050506,
    2.121212121212121,
    2.191919191919192,
    2.2626262626262625,
    2.333333333333333,
    2.404040404040404,
    2.4747474747474745,
    2.5454545454545454,
    2.616161616161616,
    2.686868686868687,
    2.7575757575757573,
    2.8282828282828283,
    2.898989898989899,
    2.9696969696969697,
    3.04040404040404,
    3.111111111111111,
    3.1818181818181817,
    3.2525252525252526,
    3.323232323232323,
    3.3939393939393936,
    3.4646464646464645,
    3.535353535353535,
    3.606060606060606,
    3.6767676767676765,
    3.7474747474747474,
    3.818181818181818,
    3.888888888888889,
    3.9595959595959593,
    4.03030303030303,
    4.101010101010101,
    4.171717171717171,
    4.242424242424242,
    4.313131313131313,
    4.383838383838384,
    4.454545454545454,
    4.525252525252525,
    4.595959595959596,
    4.666666666666666,
    4.737373737373737,
    4.808080808080808,
    4.878787878787879,
    4.949494949494949,
    5.02020202020202,
    5.090909090909091,
    5.161616161616162,
    5.232323232323232,
    5.303030303030303,
    5.373737373737374,
    5.444444444444445,
    5.515151515151515,
    5.585858585858586,
    5.656565656565657,
    5.727272727272727,
    5.797979797979798,
    5.8686868686868685,
    5.9393939393939394,
    6.0101010101010095,
    6.08080808080808,
    6.151515151515151,
    6.222222222222222,
    6.292929292929292,
    6.363636363636363,
    6.434343434343434,
    6.505050505050505,
    6.575757575757575,
    6.646464646464646,
    6.717171717171717,
    6.787878787878787,
    6.858585858585858,
    6.929292929292929,
    7.0
  ],
  "y": [
    0.0,
    0.002383010303165308,
    0.009074743453747548,
    0.01941353158996414,
    0.03277401628751674,
    0.048571095915585887,
    0.06626279011568843,
    0.08535212418945634,
    0.10538813631764075,
    0.12596610921322607,
    0.14672712524684325,
    0.16735704047274075,
    0.18758496851666814,
    0.2071813601385555,
    0.2259557586146315,
    0.24375430504333015,
    0.2604570614004341,
    0.27597521277055936,
    0.2902482037694368,
    0.30324085783594534,
    0.3149405218928347,
    0.32535427291635655,
    0.33450621727166313,
    0.3424349083059059,
    0.34919090267742015,
    0.35483447126092055,
    0.359433476220577,
    0.36306142199305613,
    0.3657956844723533,
    0.3677159196330136,
    0.36890265015873724,
    0.36943602634581507,
    0.3693947556083858,
    0.3688551933054452,
    0.36789058631609467,
    0.3665704597864036,
    0.36496013673419825,
    0.36312037970229755,
    0.36110714337129785,
    0.358971426955334,
    0.3567592152842589,
    0.3545114977001462,
    0.3522643542427584,
    0.35004909904665915,
    0.3478924714023713,
    0.3458168655272187,
    0.3438405907315765,
    0.34197815433807494,
    0.3402405604012821,
    0.3386356179715045,
    0.33716825333805056,
    0.3358408213655285,
    0.33465341169379276,
    0.3336041462016331,
    0.33268946473105465,
    0.3319043966290101,
    0.3312428161837346,
    0.33069768051137416,
    0.33026124888420705,
    0.3299252828840135,
    0.32968122711328995,
    0.3295203705038354,
    0.32943398852805705,
    0.32941346684484024,
    0.32945040710103185,
    0.3295367157637634,
    0.3296646769804636,
    0.3298270105550676,
    0.33001691619329904,
    0.33022810520967255,
    0.33045482090673567,
    0.3306918488356724,
    0.330934518129288,
    0.33117869506604236,
    0.3314207699795287,
    0.33165763857379366,
    0.3318866786432053,
    0.3321057231280663,
    0.3323130303655597,
    0.3325072523214373,
    0.3326874015124946,
    0.3328528172545321,
    0.33300313179622504,
    0.33313823682701643,
    0.33325825077755283,
    0.33336348726492504,
    0.3334544249725276,
    0.3335316791960958,
    0.3335959752336679,
    0.3336481237480235,
    0.3336889981856425,
    0.33371951429642205,
    0.3337406117632065,
    0.33375323791952327,
    0.3337583335075945,
    0.3337568204065168,
    0.3337495912422236,
    0.33373750077621644,
    0.33372135895878613,
    0.33370192552426536
  ]
};
