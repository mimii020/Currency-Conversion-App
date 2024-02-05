import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserVm extends ChangeNotifier{
   String username="";
   String defaultInputCurrency="TND";
   String defaultOutputCurrency="TND";

  //UserVm({required this.username, required this. defaultInputCurrency, required this.defaultOutputCurrency});
  changeSettings(username,from,to){
    this.username=username;
    this.defaultInputCurrency=from;
    this.defaultOutputCurrency=to;
    notifyListeners();
  }
  setUsername(newUserName) async {
    final prefs=await SharedPreferences.getInstance();
    username=newUserName;
    prefs.setString("username", username);
    notifyListeners();
  }

  setDefaultInputCurrency(from) async {
    final prefs=await SharedPreferences.getInstance();
    defaultInputCurrency=from;
    prefs.setString("default_input_currency", defaultInputCurrency);
    notifyListeners();
  }

  setDefaultOutputCurrency(to) async {
    final prefs=await SharedPreferences.getInstance();
    defaultOutputCurrency=to;
    prefs.setString("default_output_currency", defaultOutputCurrency);
    notifyListeners();
  }

  loadDefaults() async {
    final prefs=await SharedPreferences.getInstance();
     String? input=prefs.getString("default_input_currency");
    if (input!=null){
      defaultInputCurrency=input;
      }
    String? output=prefs.getString("default_output_currency");
    if (output!=null){
      defaultOutputCurrency=output;
      }
    String? user=prefs.getString("username");
    if (user!=null){
      username=user;
      }
    notifyListeners();

  }

}