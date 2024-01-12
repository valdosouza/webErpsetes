import 'package:appweb/app/core/shared/theme.dart';
import 'package:appweb/app/modules/dashboard_sales/presentation/components/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartSalesByPaymentType extends StatefulWidget {
  const PieChartSalesByPaymentType({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: showPieCharts(),
        ),
        Expanded(
          flex: 3,
          child: showSubtitle(),
        ),
      ],
    );
  }

  Widget showSubtitle() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Indicator(
          color: kContentColorBlue,
          text: 'Dinheiro',
          value: 7070,
          isSquare: true,
        ),
        SizedBox(
          height: 4,
        ),
        Indicator(
          color: kContentColorYellow,
          text: 'Dédito',
          value: 8086,
          isSquare: true,
        ),
        SizedBox(
          height: 4,
        ),
        Indicator(
          color: kContentColorPurple,
          text: 'Crédito',
          value: 4090,
          isSquare: true,
        ),
        SizedBox(
          height: 4,
        ),
        Indicator(
          color: kContentColorGreen,
          text: 'Ticket',
          value: 300,
          isSquare: true,
        ),
        SizedBox(
          height: 18,
        ),
      ],
    );
  }

  Widget showPieCharts() {
    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                touchedIndex = -1;
                return;
              }
              touchedIndex =
                  pieTouchResponse.touchedSection!.touchedSectionIndex;
            });
          },
        ),
        borderData: FlBorderData(
          show: false,
        ),
        sectionsSpace: 0,
        centerSpaceRadius: 60,
        sections: showingSections(),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: kContentColorBlue,
            value: 40,
            title: 'R\$ 7.070,00',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: kSecondaryColor,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: kContentColorYellow,
            value: 30,
            title: 'R\$ 8.086,00',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: kSecondaryColor,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: kContentColorPurple,
            value: 15,
            title: 'R\$ 4.900,00',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: kSecondaryColor,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: kContentColorGreen,
            value: 15,
            title: 'R\$ 300,00',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: kSecondaryColor,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
