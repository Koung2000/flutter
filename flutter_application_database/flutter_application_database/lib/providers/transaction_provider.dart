import 'package:flutter/foundation.dart';
import 'package:flutter_application_database/database/transation_db.dart';
import 'package:flutter_application_database/models/transactions.dart';

class TransactionProvider with ChangeNotifier {
  //exsample data
  List<Transactions> transaction = [
    // Transaction(title: "book name", amount: 500, date: DateTime.now()),
    // Transaction(title: "shirt", amount: 900, date: DateTime.now()),
    // Transaction(title: "song", amount: 400, date: DateTime.now())
  ];
//put data
List<Transactions> getTransaction(){
  return transaction;
}

initData() async{
  var db = TransactionDB(dbName: "transaction");
  
  //pull date to display or Show results
  transaction = await db.loadAllData();
  notifyListeners();
}

  addTransaction(Transactions statement) async{
  var db = TransactionDB(dbName: "transaction");
  // save database
   await db.inertData(statement);
  // transaction.add(statement);

  //pull date to display or Show results
  transaction = await db.loadAllData();
  // report  consumer
  notifyListeners();
}
}
