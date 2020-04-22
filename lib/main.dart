import 'dart:math';
import 'package:flutter/material.dart';
import './cardTransaction.dart';
import './transaction.dart';
import './formTransaction.dart';
import './chart.dart';
import './emptyTransaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand'),
      home: MyHomePage(title: 'Personal Expenses'),
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
  List<Transaction> transactions = [];

  var _showChart = false;

  List<Transaction> get _recentTransaction {
    return transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String newtitle, double newamount, DateTime dateTime) {
    var rng = new Random();

    var newTx = Transaction(
        title: newtitle,
        amount: newamount,
        id: rng.nextInt(10000).toString(),
        date: dateTime);

    setState(() {
      transactions.add(newTx);
    });
  }

  void _startAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_bctx) {
          return GestureDetector(
            child: FormTransaction(_addTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final maxHeight = mediaQuery.size.height - mediaQuery.padding.top;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddTransaction(context),
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Container(
            child: mediaQuery.orientation !=
                    Orientation.landscape // Portrait Mode Code
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                              child: Chart(_recentTransaction),
                              height:
                                  (maxHeight - AppBar().preferredSize.height) *
                                      0.3,
                            ),
                      Container(
                        child: transactions.length == 0
                            ? EmptyTransaction()
                            : CardTranaction(transactions, _deleteTransaction),
                            height: (maxHeight - AppBar().preferredSize.height) *0.7,
                      )
                    ],
                  ) // Portrait Mode Ends
                // Landscape Mode Start
                : Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                           Text("Show Chart",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          Switch(
                            value: _showChart,
                            onChanged: (val) {
                              setState(() {
                                _showChart = val;
                              });
                            },
                          ),
                        ],
                      ),
                      _showChart
                          ? Container(
                              child: Chart(_recentTransaction),
                              height:
                                  (maxHeight - AppBar().preferredSize.height) *
                                      0.7,
                            )
                          : Container(
                            child: transactions.length == 0
                                ? EmptyTransaction()
                                : CardTranaction(transactions, _deleteTransaction),
                                height: (maxHeight - AppBar().preferredSize.height) *
                                      0.7 ,
                          )
                    ],
                  )), // Landscape Mode Start
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: mediaQuery.orientation != Orientation.landscape
          ? FloatingActionButton(
              onPressed: () => _startAddTransaction(context),
              tooltip: 'Increment',
              child: Icon(Icons.add),
              backgroundColor: Colors.amber,
            )
          : Container(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
