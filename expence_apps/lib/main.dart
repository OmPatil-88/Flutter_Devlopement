import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import './Widgets/chart.dart';
import './Widgets/new_transaction.dart';
import './Widgets/transaction_list.dart';

int id = 0;
void main() => runApp(const Expence());

class Expence extends StatelessWidget {
  const Expence({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expence',
      theme: ThemeData(
        errorColor: Colors.red,
        fontFamily: 'PalmSummer',
        appBarTheme: AppBarTheme(
          toolbarTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                headline1: const TextStyle(
                  fontFamily: 'PalmSummer',
                  fontWeight: FontWeight.bold,
                ),
              )
              .bodyText2,
          titleTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                headline1: const TextStyle(
                  fontFamily: 'PalmSummer',
                  fontWeight: FontWeight.bold,
                ),
              )
              .headline6,
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
            .copyWith(secondary: Colors.blueAccent),
      ),
      home: _Expence(),
    );
  }
}

class _Expence extends StatefulWidget {
  @override
  _ExpenceState createState() => _ExpenceState();
}

bool showChart = false;

class _ExpenceState extends State<_Expence> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  final List<Transaction> usertransaction = [];

  List<Transaction> get _recentTransactions {
    return usertransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      usertransaction.removeWhere((tx) => tx.id == id);
    });
  }

  _addNewTransction(String title, double amount, DateTime selectedDate) {
    ++id;
    final newTx = Transaction(
      id: '$id',
      title: title,
      amount: amount,
      date: selectedDate,
    );
    setState(() {
      usertransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransction),
            behavior: HitTestBehavior.opaque);
      },
    );
  }

  List<Widget> _buildLandscapeContent(MediaQueryData mediaQuery,
      PreferredSizeWidget appbar, Widget txListWidget) {
    return [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Show Chart"),
          Switch.adaptive(
              value: showChart,
              onChanged: (val) {
                setState(
                  () {
                    showChart = val;
                  },
                );
              })
        ],
      ),
      showChart
          ? SizedBox(
              height: ((mediaQuery.size.height -
                      appbar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7),
              child: Chart(_recentTransactions))
          : txListWidget
    ];
  }

  List<Widget> _buildPortraiteContent(MediaQueryData mediaQuery,
      PreferredSizeWidget appbar, Widget txListWidget) {
    return [
      SizedBox(
        height: ((mediaQuery.size.height -
                appbar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3),
        child: Chart(_recentTransactions),
      ),
      txListWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appbar = (Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text("Expence App"),
            trailing: Row(
              children: [
                GestureDetector(
                  child: const Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: const Text("Expence App"),
            actions: <Widget>[
              IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: const Icon(Icons.add),
              )
            ],
          )) as PreferredSizeWidget;
    final txListWidget = SizedBox(
      height: ((mediaQuery.size.height -
              appbar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7),
      child: TransactionList(usertransaction, _deleteTransaction),
    );
    final pagebody = SingleChildScrollView(
      child: Column(
        children: <Widget>[
          if (isLandscape)
            ..._buildLandscapeContent(
              mediaQuery,
              appbar,
              txListWidget,
            ),
          if (!isLandscape)
            ..._buildPortraiteContent(
              mediaQuery,
              appbar,
              txListWidget,
            ),
        ],
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pagebody,
            navigationBar: appbar as ObstructingPreferredSizeWidget,
          )
        : Scaffold(
            appBar: appbar,
            body: pagebody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () => _startAddNewTransaction(context),
              child: const Icon(Icons.add),
            ),
          );
  }
}
