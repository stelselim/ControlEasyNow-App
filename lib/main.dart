import 'package:controlapp/provider/appstate.dart';
import 'package:controlapp/screens/analysis.dart';
import 'package:controlapp/screens/home.dart';
import 'package:controlapp/screens/system.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Control Easy Now',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/system",
        routes: {
          '/': (context) => Home(),
          '/system': (context) => System(),
        },
      ),
    );
  }
}
