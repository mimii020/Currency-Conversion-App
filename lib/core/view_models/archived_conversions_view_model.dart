import 'dart:convert';

import 'package:currency_conversion_app3/core/models/conversion.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArchivedConversionsViewModel extends ChangeNotifier {
  List<Conversion> archivedConversions = [];
  addToArchive(Conversion conversion) async {
    final prefs = await SharedPreferences.getInstance();
    archivedConversions.add(conversion);
    prefs.setStringList("saved_conversions",
        archivedConversions.map((e) => jsonEncode(e.toMap())).toList());
    notifyListeners();
  }

  //deleteFromArchive();
  loadArchive() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? conversionList = prefs.getStringList("saved_conversions");
    if (conversionList != null) {
      archivedConversions =
          conversionList.map((e) => Conversion.fromMap(jsonDecode(e))).toList();
    }
    notifyListeners();
  }
}
