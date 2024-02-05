class Conversion{
  late  String inputCurrency;
  late  String outputCurrency;
  late  String inputAmount;
  late  String outputAmount;
  late  String date;
  late  String time;
  Conversion({required this.inputAmount, required this.inputCurrency, required this.outputCurrency, required this.outputAmount, required this.date, required this.time});
  Conversion.fromMap(map){
    outputAmount=map["outputAmount"];
    inputAmount=map["inputAmount"]; 
    inputCurrency=map["inputCurrency"];
    outputCurrency=map["outputCurrency"];
    date=map["date"]; 
    time=map["time"];    
  }

  Map<String,String> toMap()=>{
     "inputAmount":inputAmount,
     "outputAmount":outputAmount,
     "inputCurrency":inputCurrency,
     "outputCurrency":outputCurrency,
     "date":date,
     "time":time,
  };
}