import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient{
     var currenciesUrl=Uri.https("api.fastforex.io", "/currencies",{"api_key":"1078eaf67b-466d9f8a9c-s8e0fl"});

     getCurrencies() async{
        var response=await http.get(currenciesUrl);
       
     if(response.statusCode==200){
      var body=jsonDecode(response.body);
      var currenciesList=body["currencies"].keys.toList();
      return currenciesList;
     }
     else{
      throw Exception("couldn't load the currencies, ${response.statusCode}");
     }
     }

     Future<num> findRate(String input,String output) async {
     var fetchUrl=Uri.https("api.fastforex.io","/fetch-multi",{"api_key":"1078eaf67b-466d9f8a9c-s8e0fl","from":input,"to":output});
     var  response=await http.get(fetchUrl);
     if(response.statusCode==200){
      var body=jsonDecode(response.body);
      num result=body["results"][output];
      return result;
     }
      else {
        throw Exception("couldn't find the desired result");
      }
     }

}