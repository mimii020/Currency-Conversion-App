import 'package:currency_conversion_app3/core/models/conversion.dart';
import 'package:currency_conversion_app3/core/services/api_client.dart';
import 'package:currency_conversion_app3/core/view_models/archived_conversions_view_model.dart';
import 'package:currency_conversion_app3/core/view_models/currencies_view_model.dart';
import 'package:currency_conversion_app3/core/view_models/rate_view_model.dart';
import 'package:currency_conversion_app3/core/view_models/user_view_model.dart';
import 'package:currency_conversion_app3/ui/widgets/custom_currencies_buttons.dart';
import 'package:currency_conversion_app3/ui/widgets/persistent_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final CurrenciesVm currenciesVm;
  late final UserVm userVm;
  late final ArchivedConversionsViewModel archivedConversionsVm =
      Provider.of<ArchivedConversionsViewModel>(context, listen: false);
  late String inputCurrency;
  late String outputCurrency;
  TextEditingController inputTextController = TextEditingController();
  String inputAmount = "0";
  String outputAmount = "0";
  ApiClient client = ApiClient();
  late RateVm rateVm;
  num rate = 0;
  String? groupVal = "TND";
  late Conversion conversion;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    userVm = context.read<UserVm>();
    currenciesVm = context.read<CurrenciesVm>();
    rateVm = context.read<RateVm>();

    loadDefaults();
    inputCurrency = userVm.defaultInputCurrency;
    outputCurrency = userVm.defaultOutputCurrency;
    findRate();
    rate = rateVm.rate;
    print(inputCurrency);
  }

  loadDefaults() async {
    await userVm.loadDefaults();
  }

  findRate() async {
    await rateVm.findRate(inputCurrency, outputCurrency);
  }

  convert() {
    setState(() {
      rate = rateVm.rate;
      outputAmount = (rate * num.parse(inputAmount)).toString();
    });
  }

  swap() {
    setState(() {
      String aux = inputCurrency;
      inputCurrency = outputCurrency;
      outputCurrency = aux;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PersistentWidget(navigateTo: () {
        Navigator.pushNamed(context, '/archive_screen');
      }),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Choose another input currency"),
                                content: SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: currenciesVm.currencies.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          leading: Radio<String>(
                                            value:
                                                currenciesVm.currencies[index],
                                            groupValue: groupVal,
                                            onChanged: (String? value) async {
                                              setState(() {
                                                groupVal = value;
                                                inputCurrency = value!;
                                              });

                                              await findRate();
                                              print("rateee");
                                              convert();
                                              print(
                                                  context.read<RateVm>().rate);
                                              print(outputAmount);
                                            },
                                          ),
                                          title: Column(
                                            children: [
                                              Text(currenciesVm
                                                  .currencies[index]),
                                              Divider(color: Color(0xff7E6BEF)),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              ));
                    },
                    child: Text(inputCurrency,
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    swap();
                    await findRate();
                    convert();
                  },
                  icon: Icon(
                    Icons.swap_horiz,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Choose another output currency"),
                              content: SizedBox(
                                height: 200,
                                width: 200,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: currenciesVm.currencies.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        leading: Radio<String>(
                                          value: currenciesVm.currencies[index],
                                          groupValue: groupVal,
                                          onChanged: (String? value) async {
                                            setState(() {
                                              groupVal = value;
                                              outputCurrency = value!;
                                            });
                                            print(
                                                "toCurrency " + outputCurrency);
                                            // print("fetching ratee");
                                            await findRate();
                                            print("found ratee" +
                                                context
                                                    .read<RateVm>()
                                                    .rate
                                                    .toString());
                                            convert();
                                            print(context.read<RateVm>().rate);
                                            print(outputAmount);
                                          },
                                        ),
                                        title: Column(
                                          children: [
                                            Text(
                                                currenciesVm.currencies[index]),
                                            const Divider(
                                                color: Color(0xff7E6BEF)),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            )),
                    child: Text(
                      outputCurrency,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 100),
            TextField(
              controller: inputTextController,
              keyboardType: TextInputType.number,
              focusNode: _focusNode,
              onTap: () {
                Scrollable.ensureVisible(_focusNode.context!);
              },
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
              decoration: InputDecoration(
                hintText: "please, enter your input amount",
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Color(0xff678DC7))),
                suffixIcon: IconButton(
                  onPressed: () {
                    inputTextController.clear();
                    setState(() {
                      outputAmount = "0";
                    });
                  },
                  icon: Icon(
                    Icons.clear,
                  ),
                ),
              ),
              onChanged: (value) {
                if (inputTextController.text.isEmpty) {
                  setState(() {
                    outputAmount = "0";
                  });
                }

                inputAmount = value;
                convert();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Calculated output amount :",
                style: TextStyle(color: Color(0xffA3D0F1), fontSize: 17),
              ),
            ),
            Consumer<RateVm>(
              builder: (context, rateVm, child) => Container(
                height: 50,
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xffA3D0F1),
                ),
                child: Text(
                  outputAmount +
                      "  rate: " +
                      rateVm.rate.toString() +
                      "  out currency: " +
                      outputCurrency,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
              ),
            ),
            SizedBox(height: 150),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Theme(
                data: Theme.of(context).copyWith(
                    elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff6BEFA0),
                    side: BorderSide.none,
                  ),
                )),
                child: ElevatedButton(
                  onPressed: () {
                    DateTime now = DateTime.now();
                    String date = "${now.year}-${now.month}-${now.day}";
                    String time = '${now.hour}:${now.minute}:${now.second}';
                    conversion = Conversion(
                      inputAmount: inputAmount,
                      inputCurrency: inputCurrency,
                      outputAmount: outputAmount,
                      outputCurrency: outputCurrency,
                      date: date,
                      time: time,
                    );
                    archivedConversionsVm.addToArchive(conversion);
                  },
                  child: Icon(Icons.save),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Theme(
                data: Theme.of(context).copyWith(
                    elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffEF6B6B),
                    side: BorderSide.none,
                  ),
                )),
                child: ElevatedButton(
                  onPressed: () {
                    inputTextController.clear();
                    setState(() {
                      outputAmount = "0";
                    });
                  },
                  child: const Icon(Icons.delete),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
