import 'package:controlapp/screens/home.dart';
import 'package:controlapp/screens/system.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Control Easy Now',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/system",
      routes: {
        '/': (context) => Home(title: 'Flutter Demo Home Page'),
        '/system': (context) => System(),
      },
    );
  }
}
