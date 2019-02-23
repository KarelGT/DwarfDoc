import 'package:dwarf_doc/application.dart';
import 'package:dwarf_doc/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() async {
  await Application.getInstance().init();
  Application.getInstance().isDebug = true;
  debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dwarf Doc',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.grey,
        primaryColor: Colors.grey[400],
        highlightColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        bottomAppBarColor: Colors.white,
      ),
      home: HomePage(),
    );
  }
}
