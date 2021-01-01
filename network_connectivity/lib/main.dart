import 'package:app_settings/app_settings.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:network_connectivity/connectivityChangeNotifier.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          ConnectivityChangeNotifier changeNotifier =
              ConnectivityChangeNotifier();
          //Inital load is an async function, can use FutureBuilder to show loading
          //screen while this function running. This is not covered in this tutorial
          changeNotifier.initialLoad();
          return changeNotifier;
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Network Connectivity',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MyHomePage(title: 'Network Connectivity'),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            brightness: Brightness.light),
        body: Center(
          child: Consumer<ConnectivityChangeNotifier>(builder:
              (BuildContext context,
                  ConnectivityChangeNotifier connectivityChangeNotifier,
                  Widget child) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                    child: SvgPicture.asset(connectivityChangeNotifier.svgUrl,
                        fit: BoxFit.contain)),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 20, 30, 100),
                    child: Text(
                      connectivityChangeNotifier.pageText,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                if (connectivityChangeNotifier.connectivity !=
                    ConnectivityResult.wifi)
                  Flexible(
                    child: RaisedButton(
                      child: Text('Open Settings'),
                      onPressed: () => AppSettings.openAppSettings(),
                    ),
                  )
              ],
            );
          }),
        ));
  }
}
