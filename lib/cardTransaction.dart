import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './transaction.dart';

class CardTranaction extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  CardTranaction(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 450,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return Card(
              elevation: 4,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      '\$ ${transactions[index].amount.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColorDark,
                            width: 5),
                        borderRadius: BorderRadius.circular(30)),
                    padding: EdgeInsets.all(10),
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                transactions[index].title,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Text(
                                DateFormat.yMMMd()
                                    .format(transactions[index].date),
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                  Container(
                      child: MediaQuery.of(context).orientation !=Orientation.landscape ? IconButton(
                    icon: Icon(Icons.delete ,color: Colors.red,),
                    onPressed: () {
                      deleteTransaction(transactions[index].id);
                    },
                  ) : FlatButton.icon(onPressed: (){deleteTransaction(transactions[index].id);}, icon: Icon(Icons.delete ,color: Colors.white,), label: Text("Delete" , style: TextStyle(color: Colors.white),) ,color: Colors.red,)) ,
                ],
              ),
              // color: Theme.of(context).accentColor,
            );
          },
          itemCount: transactions.length,
        ));
  }
}
