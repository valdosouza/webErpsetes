import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class CustomDate {
  static String formatDateOut(String date) {
    if (date != "") {
      try {
        //12/01/2023 - 2023-01-27
        if (date.substring(4, 5) != "-") {
          var result =
              "${date.substring(6, 10)}-${date.substring(3, 5)}-${date.substring(0, 2)}";
          return result;
        }
        return date;
      } catch (e, s) {
        FirebaseCrashlytics.instance.recordError(e, s);
        return "";
      }
    }
    return "";
  }

  static String formatDateIn(String date) {
    if (date != "") {
      try {
        //2023-01-12
        var result =
            "${date.substring(8, 10)}/${date.substring(5, 7)}/${date.substring(0, 4)}";

        return result;
      } catch (e, s) {
        FirebaseCrashlytics.instance.recordError(e, s);
        return "";
      }
    }
    return "";
  }

  static String newDate() {
    try {
      initializeDateFormatting('pt_BR,', null);
      DateTime time = DateTime.now();
      return (DateFormat("dd/MM/yyyy").format(time));
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return "";
    }
  }

  static String yesterday(String date) {
    try {
      initializeDateFormatting('pt_BR,', null);

      if (date == "") {
        return (DateFormat("dd/MM/yyyy")
            .format(DateTime.now().subtract(const Duration(days: 1))));
      } else {
        return (DateFormat("dd/MM/yyyy").format(
            DateTime.parse(formatDateOut(date))
                .subtract(const Duration(days: 1))));
      }
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return "";
    }
  }

  String getMonth(String date) {
    initializeDateFormatting('pt_BR,', null);
    var dateMonth = DateTime.parse(formatDateOut(date));
    //return DateFormat('MMM').format(DateTime(0, currentMonthIndex)).toString();
    return DateFormat('MMMM').format(dateMonth);
  }

  static String tomorrow() {
    try {
      initializeDateFormatting('pt_BR,', null);

      DateTime time = DateTime.now().add(const Duration(days: 1));
      return (DateFormat("dd/MM/yyyy").format(time));
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return "";
    }
  }
}
