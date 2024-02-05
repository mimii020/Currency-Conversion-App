import 'package:currency_conversion_app3/core/models/conversion.dart';
import 'package:currency_conversion_app3/core/view_models/archived_conversions_view_model.dart';
import 'package:currency_conversion_app3/ui/widgets/persistent_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  late final ArchivedConversionsViewModel archivedConversionsVm =
      context.read<ArchivedConversionsViewModel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadArchive();
    print(archivedConversionsVm.archivedConversions);
  }

  loadArchive() async {
    await archivedConversionsVm.loadArchive();
  }

  @override
  Widget build(BuildContext context) {
    List<Conversion> list = archivedConversionsVm.archivedConversions;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xff161819),
      appBar: PersistentWidget(navigateTo: () {
        Navigator.pushNamed(context, '/archive_screen');
      }),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
            itemCount: archivedConversionsVm.archivedConversions.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Theme(
                data: Theme.of(context).copyWith(
                    elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffA3D0F1),
                    side: BorderSide.none,
                  ),
                )),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                              title: Text("Your saved conversion :"),
                              content: SizedBox(
                                height: 100,
                                width: 200,
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                      ),
                                      children: [
                                        TextSpan(
                                            text:
                                                "from ${list[index].inputAmount} ${list[index].inputCurrency} "),
                                        TextSpan(
                                            text:
                                                "to ${list[index].outputAmount} ${list[index].outputCurrency} "),
                                        TextSpan(
                                            text:
                                                "${list[index].date} at ${list[index].time}"),
                                      ]),
                                ),
                              )));
                    },
                    child: Text(
                      "conversion number " + (index + 1).toString(),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ));
            }),
      ),
    ));
  }
}
