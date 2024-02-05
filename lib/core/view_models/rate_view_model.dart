import 'package:currency_conversion_app3/core/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RateVm extends ChangeNotifier {
  num rate = 0;

  ApiClient client = ApiClient();

  findRate(inputCurrency, outputCurrency) async {
    // try{
    rate = await client.findRate(inputCurrency, outputCurrency);
    notifyListeners();
    // }
    // catch (e){
    // throw Exception("Oops, couldn't fetch the rate");
    //}
  }
}
