import 'package:currency_conversion_app3/core/view_models/currencies_view_model.dart';
import 'package:flutter/material.dart';

class CustomCurrenciesBtns extends StatefulWidget {
  late final String inputDialogMessage;
  late final String outputDialogMessage;
  late final List<String> list;
  //late   Function onChanged1;
  //late   Function onChanged2;
  late String inputCurrency;
  late String outputCurrency;
  //late  Widget child1;
  //late  Widget child2;

  CustomCurrenciesBtns({
    Key? key,
    required this.inputDialogMessage,
    required this.outputDialogMessage,
    required this.list,
    required this.inputCurrency,
    required this.outputCurrency,
    /* required this.onChanged1, 
     required this.onChanged2, 
     required this.child1, 
     required this.child2*/
  }) : super(key: key);

  @override
  State<CustomCurrenciesBtns> createState() => _CustomCurrenciesBtnsState();
}

class _CustomCurrenciesBtnsState extends State<CustomCurrenciesBtns> {
  late final CurrenciesVm currenciesVm;
  String groupVal = "TND";

  @override
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xff7E6BEF)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)))),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text("${widget.inputDialogMessage}"),
                          content: SizedBox(
                            height: 200,
                            width: 200,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: widget.list.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Radio<String>(
                                      value: widget.list[index],
                                      groupValue: groupVal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          groupVal = value!;
                                          widget.inputCurrency = value;
                                          // widget.onChanged1(value);
                                        });
                                      },
                                    ),
                                    title: Column(
                                      children: [
                                        Text(widget.list[index]),
                                        Divider(color: Color(0xff7E6BEF)),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ));
              },
              child: Text(widget.inputCurrency) //widget.child1,
              ),
        ),
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff7E6BEF)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)))),
            onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text("${widget.outputDialogMessage}"),
                      content: SizedBox(
                        height: 200,
                        width: 200,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.list.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Radio<String>(
                                  value: widget.list[index],
                                  groupValue: groupVal,
                                  onChanged: (String? value) {
                                    setState(() {
                                      groupVal = value!;
                                      widget.outputCurrency = value;
                                    });
                                  },
                                ),
                                title: Column(
                                  children: [
                                    Text(widget.list[index]),
                                    Divider(color: Color(0xff7E6BEF)),
                                  ],
                                ),
                              );
                            }),
                      ),
                    )),
            child: Text(widget.outputCurrency),
          ),
        )
      ],
    );
  }
}
