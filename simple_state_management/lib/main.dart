import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_state_management/counterNotifier.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CounterNotifier>(
      create: (BuildContext context) => CounterNotifier(),
      child: MaterialApp(
        title: 'Simple State Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Home Page'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SecondPage()));
            },
            child: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white,
              size: 40,
            ),
          )
        ],
      ),
      body: Center(child: SimpleListView()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<CounterNotifier>(context, listen: false)
            .addDateTime(DateTime.now()),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(child: SimpleListView()),
    );
  }
}

class SimpleListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CounterNotifier>(
      builder: (BuildContext context, CounterNotifier counterNotifier,
              Widget child) =>
          ListView.separated(
              padding: EdgeInsets.all(8),
              itemBuilder: (BuildContext context, int val) {
                return Row(
                  children: <Widget>[
                    Text(counterNotifier.counterDateTime[val].toString())
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int val) {
                return Divider();
              },
              itemCount: counterNotifier.counterDateTime.length),
    );
  }
}
