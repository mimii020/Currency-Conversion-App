import 'package:currency_conversion_app3/core/view_models/user_view_model.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserVm userVm = UserVm();
  @override
  void initState() {
    super.initState();
    firstScreen();
  }

  firstScreen() async {
    await userVm.loadDefaults();
    Future.delayed(Duration(seconds: 3), () {
      if (userVm.username != "" &&
          userVm.defaultInputCurrency != "" &&
          userVm.defaultOutputCurrency != "") {
        Navigator.pushNamed(context, '/main_screen');
      } else {
        Navigator.pushNamed(context, '/init_screen');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset('assets/logo.png'),
        ),
        Text(
          "Convert currencies in real time!",
          style: TextStyle(fontSize: 20),
        )
      ],
    )));
  }
}
