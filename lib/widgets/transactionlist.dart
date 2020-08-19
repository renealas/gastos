import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  DateFormat dateFormat;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    print('build() TransactionList');
    initializeDateFormatting();
    dateFormat = new DateFormat.yMMMMd('es');

    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constrains) {
              return Column(
                children: <Widget>[
                  Text(
                    'No hay Transacciones todavia!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: constrains.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              );
            },
          )
        : ListView(
            children: transactions
                .map((tx) => TransactionItem(
                      key: ValueKey(tx.id),
                      transaction: tx,
                      deleteTx: deleteTx,
                      dateFormat: dateFormat,
                    ))
                .toList(),
          );
    // : ListView.builder(
    //     itemCount: transactions.length,
    //     itemBuilder: (ctx, index) {
    //       return TransactionItem(
    //           transaction: transactions[index],
    //           dateFormat: dateFormat,
    //           deleteTx: deleteTx);
    //     },
    //   );
  }
}
