import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_database/models/transactions.dart';
import 'package:flutter_application_database/providers/transaction_provider.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    @override
  void initState() {

    super.initState();
    Provider.of<TransactionProvider>(context,listen: false).initData();
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("ແອບບັນຊີ"),
          actions: [
            IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  SystemNavigator.pop();
                  })
          ],
        ),
        body: Consumer(
          builder: (context, TransactionProvider provider, Widget? child) {
            var count = provider.transaction.length;
            if (count <=0) {
              return const Center(
                child: Text(
                  "no data",
                  style: TextStyle(fontSize: 40),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: count,
                itemBuilder: (context, index) {
                  Transactions data = provider.transaction[index];

                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(5),
                    
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: FittedBox(
                          child: Text( NumberFormat("#,###").format(data.amount)),
                        ),
                      ), 
                      title: Text(data.title.toString()),
                      subtitle: Text(DateFormat("dd/MM/yyyy").format(data.date)),
                    ),
                  );
                },
              );
            }
          },
        )
        );
  }
}

  