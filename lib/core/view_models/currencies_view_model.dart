import 'package:currency_conversion_app3/core/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrenciesVm extends ChangeNotifier {
  ApiClient client = ApiClient();
  List<String> currencies = [];
  getCurrencies() async {
    currencies = await client.getCurrencies();
    notifyListeners();
  }
}
