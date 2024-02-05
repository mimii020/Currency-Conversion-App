import 'dart:developer';

import 'package:currency_conversion_app3/core/view_models/archived_conversions_view_model.dart';
import 'package:currency_conversion_app3/core/view_models/currencies_view_model.dart';
import 'package:currency_conversion_app3/core/view_models/user_view_model.dart';
import 'package:currency_conversion_app3/ui/screens/archive_screen.dart';
import 'package:currency_conversion_app3/ui/screens/initial_screen.dart';
import 'package:currency_conversion_app3/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/view_models/rate_view_model.dart';
import 'ui/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserVm>(
          create: (_) => UserVm(),
        ),
        ChangeNotifierProvider<CurrenciesVm>(create: (_) => CurrenciesVm()),
        ChangeNotifierProvider<RateVm>(create: (_) => RateVm()),
        ChangeNotifierProvider<ArchivedConversionsViewModel>(
            create: (_) => ArchivedConversionsViewModel()),
      ],
      child: MaterialApp(
        title: 'Currency Conversion App',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          brightness: Brightness.dark,
          primaryColor: const Color(0xffA3D0F1),
          iconTheme: IconThemeData(color: Color(0xffA3D0F1)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Color(0xffA3D0F1)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  textStyle: TextStyle(color: Colors.white))),
        ),
        initialRoute: '/',
        routes: {
          '/init_screen': (context) => const InitialScreen(),
          '/main_screen': (context) => const MainScreen(),
          '/archive_screen': (context) => const ArchiveScreen(),
        },
        home: const SplashScreen(),
      ),
    );
  }
}
