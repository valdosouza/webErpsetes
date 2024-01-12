import 'dart:async';
import 'dart:math';
import 'package:appweb/app/core/shared/theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartMonthSalesInfo extends StatefulWidget {
  const BarChartMonthSalesInfo({super.key});

  List<Color> get availableColors => const <Color>[
        kContentColorPurple,
        kContentColorYellow,
        kContentColorBlue,
        kContentColorOrange,
        kContentColorPink,
        kContentColorRed,
      ];

  final Color barBackgroundColor = kPrimaryBgDashBoard;
  final Color barColor = kSecondaryBgDashBoard;
  final Color touchedBarColor = kContentColorGreen;

  @override
  State<StatefulWidget> createState() => BarChartMonthSalesInfoState();
}

class BarChartMonthSalesInfoState extends State<BarChartMonthSalesInfo> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: BarChart(
                isPlaying ? randomData() : mainBarData(),
                swapAnimationDuration: animDuration,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(12, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 5, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 5, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 7.5, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 9, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 11.5, isTouched: i == touchedIndex);
          case 7:
            return makeGroupData(7, 11.5, isTouched: i == touchedIndex);
          case 8:
            return makeGroupData(8, 11.5, isTouched: i == touchedIndex);
          case 9:
            return makeGroupData(9, 11.5, isTouched: i == touchedIndex);
          case 10:
            return makeGroupData(10, 11.5, isTouched: i == touchedIndex);
          case 11:
            return makeGroupData(11, 11.5, isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String monthYear;
            switch (group.x) {
              case 0:
                monthYear = 'Janeiro';
                break;
              case 1:
                monthYear = 'Fevereiro';
                break;
              case 2:
                monthYear = 'Março';
                break;
              case 3:
                monthYear = 'Abril';
                break;
              case 4:
                monthYear = 'Maio';
                break;
              case 5:
                monthYear = 'Junho';
                break;
              case 6:
                monthYear = 'Julho';
                break;
              case 7:
                monthYear = 'Agosto';
                break;
              case 8:
                monthYear = 'Setembro';
                break;
              case 9:
                monthYear = 'Outubro';
                break;
              case 10:
                monthYear = 'Novembro';
                break;
              case 11:
                monthYear = 'Dezembro';
                break;

              default:
                throw Error();
            }
            return BarTooltipItem(
              '$monthYear\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: TextStyle(
                    color: widget.touchedBarColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getBottomTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getLeftTitles,
            reservedSize: 100,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('JAN', style: style);
        break;
      case 1:
        text = const Text('FEV', style: style);
        break;
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 3:
        text = const Text('ABR', style: style);
        break;
      case 4:
        text = const Text('MAI', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 6:
        text = const Text('JUL', style: style);
        break;
      case 7:
        text = const Text('AGO', style: style);
        break;
      case 8:
        text = const Text('SET', style: style);
        break;
      case 9:
        text = const Text('OUT', style: style);
        break;
      case 10:
        text = const Text('NOV', style: style);
        break;
      case 11:
        text = const Text('DEZ', style: style);
        break;

      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  Widget getLeftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('1.000', style: style);
        break;
      case 1:
        text = const Text('2.000', style: style);
        break;
      case 2:
        text = const Text('3.000', style: style);
        break;
      case 3:
        text = const Text('4.000', style: style);
        break;
      case 4:
        text = const Text('5.000', style: style);
        break;
      case 5:
        text = const Text('6.000', style: style);
        break;
      case 6:
        text = const Text('7.000', style: style);
        break;
      case 7:
        text = const Text('8.000', style: style);
        break;
      case 8:
        text = const Text('9.000', style: style);
        break;
      case 9:
        text = const Text('10.000', style: style);
        break;
      case 10:
        text = const Text('11.000', style: style);
        break;
      case 11:
        text = const Text('12.000', style: style);
        break;

      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getBottomTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 100,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(12, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
              0,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 1:
            return makeGroupData(
              1,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 2:
            return makeGroupData(
              2,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 3:
            return makeGroupData(
              3,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 4:
            return makeGroupData(
              4,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 5:
            return makeGroupData(
              5,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 6:
            return makeGroupData(
              6,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 7:
            return makeGroupData(
              7,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 8:
            return makeGroupData(
              8,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 9:
            return makeGroupData(
              9,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 10:
            return makeGroupData(
              10,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 11:
            return makeGroupData(
              11,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );

          default:
            return throw Error();
        }
      }),
      gridData: const FlGridData(show: false),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
      animDuration + const Duration(milliseconds: 50),
    );
    if (isPlaying) {
      await refreshState();
    }
  }
}
