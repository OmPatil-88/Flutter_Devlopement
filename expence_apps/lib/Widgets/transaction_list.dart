import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletetx;
  TransactionList(this.transactions, this.deletetx);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text("List is empty"),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  alignment: Alignment.center,
                  child:
                      Image.asset('assets/Images/DNF.png', fit: BoxFit.cover),
                )
              ],
            )
          : ListView(children: [
              ...transactions
                  .map((tx) => TranscationItem(
                      key: ValueKey(tx.id),
                      transaction: tx,
                      deletetx: deletetx))
                  .toList()
            ]),
    );
  }
}



// return Card(
//                   child: Row(
//                     children: <Widget>[
//                       Container(
//                         margin: EdgeInsets.symmetric(
//                           vertical: 10,
//                           horizontal: 20,
//                         ),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Theme.of(context).primaryColor,
//                             width: 2,
//                           ),
//                         ),
//                         padding: EdgeInsets.all(5),
//                         child: Text(
//                           transactions[index].amount.toStringAsFixed(2) + '\$',
//                           style: TextStyle(
//                             color: Theme.of(context).primaryColor,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Text(
//                             transactions[index].title,
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             DateFormat.yMMMd().format(transactions[index].date),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 );