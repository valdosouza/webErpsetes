import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

const kTitleAppBarStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
  fontSize: 22,
);
const kHintTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'OpenSans',
);

const kAppTitle = AutoSizeText(
  "Consignação e Venda",
  maxFontSize: 18,
  minFontSize: 12,
  style: kTitleAppBarStyle,
);

const kCircleAvatarTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'OpenSans',
);

const kLabelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

const kLabelAvatarStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 12,
  fontFamily: 'OpenSans',
);

const ktittleAppBarStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
  fontSize: 22,
);

const kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  //borderRadius: BorderRadius.circular(10),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

const kBoxDecorationflexibleSpace = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF73AEF5),
      Color(0xFF61A4F1),
      Color(0xFF478DE0),
      Color(0xFF398AE5),
    ],
    stops: [0.1, 0.4, 0.7, 0.9],
  ),
);

const kBoxDecorationAnalyticCard = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF546E7A),
      Color(0xFF263238),
    ],
    //stops: [0.1, 0.4, 0.7, 0.9],
  ),
);

const kBoxDecorationBarChart = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF546E7A),
      Color(0xFF263238),
    ],
  ),
);

const kPrimaryColor = Color(0xFF366CF6);
const kSecondaryColor = Color(0xFFF5F6FC);
const kBgLightColor = Color(0xFFF2F4FC);
const kBgDarkColor = Color(0xFFEBEDFA);
const kBadgeColor = Color.fromRGBO(123, 160, 91, 80);
const kGrayColor = Color(0xFF8793B2);
const kTitleTextColor = Color(0xFF30384D);
const kTextColor = Color(0xFF4D5875);
const kDefaultPadding = 16.0;
const kLightTextColor = Colors.black26;

const Color kContentColorBlack = Colors.black;
const Color kContentColorWhite = Colors.white;
const Color kContentColorBlue = Color(0xFF2196F3);
const Color kContentColorYellow = Color(0xFFFFC300);
const Color kContentColorOrange = Color(0xFFFF683B);
const Color kContentColorGreen = Color(0xFF3BFF49);
const Color kContentColorPurple = Color(0xFF6E1BFF);
const Color kContentColorPink = Color(0xFFFF3AF2);
const Color kContentColorRed = Color(0xFFE80054);
const Color kContentColorCyan = Color(0xFF50E4FF);

const Color kPrimaryBgDashBoard = Color(0xFF263238);
const Color kSecondaryBgDashBoard = Color(0xFF546E7A);

Color getColor(String color) {
  switch (color) {
    case 'green':
      return Colors.green;
    case 'blue':
      return Colors.blue;
    case 'black':
      return Colors.black;
    case 'red':
      return const Color.fromRGBO(123, 160, 91, 80);
  }
  return Colors.black;
}
