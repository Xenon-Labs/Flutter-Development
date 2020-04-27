import 'package:flutter/material.dart';
import 'package:transitions_app/customPageTransitionsBuilder.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transitions Tutorial',
      theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(builders: {
        TargetPlatform.iOS: CustomPageTransitionsBuilder(),
        TargetPlatform.android: CustomPageTransitionsBuilder(),
      })),
      home: MyHomePage(title: 'Transitions Tutorial'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var rnd = Random();
    return Scaffold(
        backgroundColor: Color.fromARGB(rnd.nextInt(256), rnd.nextInt(256),
            rnd.nextInt(256), rnd.nextInt(256)),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              RaisedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          MyHomePage(title: "New Page"),
                    )),
                child: Text("New Page"),
              )
            ])));
  }
}
