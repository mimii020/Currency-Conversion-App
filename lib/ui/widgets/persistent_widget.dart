import 'package:currency_conversion_app3/core/view_models/currencies_view_model.dart';
import 'package:currency_conversion_app3/core/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class PersistentWidget extends AppBar {
  late final Function navigateTo;
  PersistentWidget({Key? key, required this.navigateTo}) : super(key: key);

  @override
  State<PersistentWidget> createState() => _PersistentWidgetState();
}

class _PersistentWidgetState extends State<PersistentWidget> {
  TextEditingController usernameController = TextEditingController();
  late UserVm userVm = context.read<UserVm>();
  late CurrenciesVm currenciesVm = context.read<CurrenciesVm>();
  late String inputCurrency;
  late String outputCurrency;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDefaults();
    inputCurrency = userVm.defaultInputCurrency;
    outputCurrency = userVm.defaultOutputCurrency;
    print("deaultsssssss ${inputCurrency}");
    getCurrencies();
  }

  getCurrencies() async {
    await currenciesVm.getCurrencies();
  }

  loadDefaults() async {
    userVm.loadDefaults();
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
    return AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(
            "Currency Conversion App",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            width: 5,
          ),
          IconButton(
            icon: Icon(Icons.archive),
            onPressed: () {
              widget.navigateTo();
            },
          ),
          IconButton(
            onPressed: () {
              usernameController.clear();
              showDialog(
                  context: context,
                  builder: (context) => StatefulBuilder(
                        builder: (context, setState) => AlertDialog(
                          icon: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(
                                  Icons.clear,
                                )),
                          ),
                          title: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Change Settings",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          content: SizedBox(
                            height: 300,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(children: [
                                SizedBox(
                                  height: 50,
                                  child: TextField(
                                    keyboardType: TextInputType.name,
                                    controller: usernameController,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                    decoration: InputDecoration(
                                        hintText: "please, enter your username",
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                                color: Color(0xffA3D0F1))),
                                        suffixIcon: IconButton(
                                          onPressed: () =>
                                              usernameController.clear(),
                                          icon: Icon(
                                            Icons.clear,
                                          ),
                                        )),
                                  ),
                                ),
                                SizedBox(height: 50),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                        child: DropdownButton(
                                      value: inputCurrency,
                                      items: currenciesVm.currencies
                                          .map<DropdownMenuItem<String>>(
                                              (e) => DropdownMenuItem(
                                                    value: e,
                                                    child: Text(
                                                      e,
                                                    ),
                                                  ))
                                          .toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          inputCurrency = value!;
                                        });
                                      },
                                      isExpanded: true,
                                      padding: EdgeInsets.all(20.0),
                                    )),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            swap();
                                          });
                                        },
                                        icon: Icon(Icons.swap_horiz)),
                                    Expanded(
                                      child: DropdownButton(
                                        value: outputCurrency,
                                        items: currenciesVm.currencies
                                            .map<DropdownMenuItem<String>>(
                                                (e) => DropdownMenuItem(
                                                    value: e, child: Text(e)))
                                            .toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            outputCurrency = value!;
                                          });
                                        },
                                        isExpanded: true,
                                        padding: EdgeInsets.all(20.0),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                        elevatedButtonTheme:
                                            ElevatedButtonThemeData(
                                                style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xff6BEFA0),
                                      side: BorderSide.none,
                                    ))),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await userVm.setDefaultInputCurrency(
                                            inputCurrency);
                                        await userVm.setDefaultOutputCurrency(
                                            outputCurrency);
                                        await userVm.setUsername(
                                            usernameController.text);
                                        Navigator.pop(context);
                                      },
                                      child: Text("Save Settings",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ));
            },
            icon: Icon(Icons.settings),
          ),
        ]),
        backgroundColor: Colors.transparent);
  }
}
