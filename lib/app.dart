import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'screens/trading_history_screen/trading_history_screen.dart';

class App extends StatefulWidget {
  const App({ Key? key }) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final ThemeData defaultTheme = ThemeData.light();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(        
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        textTheme: GoogleFonts.montserratTextTheme(
          defaultTheme.textTheme.copyWith(
            headline4: defaultTheme.textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
            headline5: defaultTheme.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
            headline6: defaultTheme.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
            bodyText2: defaultTheme.textTheme.bodyText2!.copyWith(fontSize: 15.0)
          )
        ),
        inputDecorationTheme: getInputDecorationTheme(),
        cardTheme: CardTheme(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))
            )
          )
        ),
        tabBarTheme: const TabBarTheme(labelColor: Colors.blue)
      ),
      routes: <String, Widget Function(BuildContext)>{
        "TradingHistory": (context) => const TradingHistoryScreen()
      },
      initialRoute: "TradingHistory"
    );
  }

  InputDecorationTheme getInputDecorationTheme() {
    return InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black, width: 2.0), 
        borderRadius: BorderRadius.circular(32.0)
      )
    );
  }
}