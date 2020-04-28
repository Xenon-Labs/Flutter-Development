import 'package:flutter/material.dart';
import 'package:transitions_app/rotationFadeTransitionBuilder.dart';
import 'package:transitions_app/zoomSlideUpTransitionBuilder.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'dart:math';

void main() {
  //Speed of animation has been slowed for demoing purposes
  timeDilation = 3.0;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transitions Tutorial',
      theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(builders: {
        TargetPlatform.iOS: ZoomSlideUpTransitionsBuilder(),
        TargetPlatform.android: RotationFadeTransitionBuilder(),

        //Example of using default animations
        //TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        //TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      })),
      home: MyHomePage(title: 'Transitions Tutorial'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  final rnd = Random();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String randomIntString;

  @override
  void initState() {
    randomIntString = widget.rnd.nextInt(10000).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(widget.title + " " + randomIntString),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF282a57), Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              MyHomePage(title: "New Page"),
                        )),
                    child: Text("New Page"),
                  ),
                  Text(
                    "Random Number: " + randomIntString,
                    style: TextStyle(color: Colors.white),
                  )
                ])));
  }
}
