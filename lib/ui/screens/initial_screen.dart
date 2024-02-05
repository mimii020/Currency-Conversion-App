import 'package:currency_conversion_app3/core/view_models/currencies_view_model.dart';
import 'package:currency_conversion_app3/core/view_models/user_view_model.dart';
import 'package:currency_conversion_app3/ui/widgets/persistent_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'dart:async';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final usernameController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String inputCurrency = "TND";
  String outputCurrency = "TND";
  late CurrenciesVm currenciesVm;
  late UserVm userVm;
  String? groupVal = "TND";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userVm = context.read<UserVm>();
    currenciesVm = context.read<CurrenciesVm>();
    getCurrencies();
  }

  getCurrencies() async {
    await currenciesVm.getCurrencies();
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
    userVm = context.watch<UserVm>();
    return SafeArea(
        child: Scaffold(
      appBar: PersistentWidget(navigateTo: () {
        Navigator.pushNamed(context, '/archive_screen');
      }),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
            key: _formkey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(height: 50),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: usernameController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintText: "please, enter your username",
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Color(0xff678DC7))),
                    suffixIcon: IconButton(
                      onPressed: () => usernameController.clear(),
                      icon: Icon(
                        Icons.clear,
                        color: Color(0xff678DC7),
                      ),
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ("please, enter a non empty username");
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text(
                                      "Choose your default input currency"),
                                  content: SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            currenciesVm.currencies.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            leading: Radio<String>(
                                              value: currenciesVm
                                                  .currencies[index],
                                              groupValue: groupVal,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  groupVal = value;
                                                  inputCurrency = value!;
                                                });
                                              },
                                            ),
                                            title: Column(
                                              children: [
                                                Text(currenciesVm
                                                    .currencies[index]),
                                                Divider(
                                                    color: Color(0xff7E6BEF)),
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
                      onPressed: () => swap(), icon: Icon(Icons.swap_horiz)),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title:
                                    Text("Choose your default input currency"),
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
                                            onChanged: (String? value) {
                                              setState(() {
                                                groupVal = value;
                                                outputCurrency = value!;
                                              });
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
                              )),
                      child: Text(outputCurrency,
                          style: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              ),
              SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: Theme(
                  data: Theme.of(context).copyWith(
                      elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff678DC7)),
                  )),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate() == true) {
                        await userVm.setDefaultInputCurrency(inputCurrency);
                        await userVm.setDefaultOutputCurrency(outputCurrency);
                        await userVm.setUsername(usernameController.text);
                        await Navigator.pushNamed(context, '/main_screen');
                      }
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Text(
                "${userVm.username} ${userVm.defaultInputCurrency} ${userVm.defaultOutputCurrency}",
                style: TextStyle(color: Colors.white),
              )
            ])),
      ),
    ));
  }
}
