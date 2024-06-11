import 'dart:io';
import 'package:flutter_application_database/models/transactions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransactionDB {
  String dbName;
  TransactionDB({required this.dbName});
  Future<Database> openDatabase() async {
    //select location database
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);
    //create database
    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  //savedata
  inertData(Transactions statement) async {
    //database => Store
    //transaction.db => expense
    var db = await openDatabase();
    var store = intMapStoreFactory.store("expense");

    // json
    var keyId = store.add(db, {
      "title": statement.title,
      "amount": statement.amount,
      "date": statement.date.toIso8601String()
    });
    return keyId;
  }
  //high => low or new to old false 
  //low => high or ld to new true
  //pull data
  Future<List<Transactions>> loadAllData() async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store("expense");
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    List<Transactions> transactionList = [];
    //pull onely one colum
    for (var record in snapshot) {
      transactionList.add(Transactions(
          amount: record["amount"] as double,
          date: DateTime.parse(record["date"] as String),
          title: record["title"] as String));
    }
    return transactionList;
  }
}
