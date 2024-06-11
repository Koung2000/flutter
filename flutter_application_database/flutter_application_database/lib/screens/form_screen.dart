import 'package:flutter/material.dart';
import 'package:flutter_application_database/main.dart';
import 'package:flutter_application_database/models/transactions.dart';
import 'package:flutter_application_database/providers/transaction_provider.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FromScreen extends StatelessWidget {
  FromScreen({Key? key}) : super(key: key);
  final formatter = NumberFormat("#,###");
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("page 2"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(children: [
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  hintText: "Enter your name",
                  labelText: "Name",
                ),
                controller: titleController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return "keyname";
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Enter your name",
                  labelText: "price",
                ),
                controller: amountController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return "keyprice";
                  }
                  if (double.parse(str) <= 0) {
                    return "large than 0";
                  }

                  return null;
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: const Color.fromARGB(255, 6, 161, 45),
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    var title = titleController.text;
                    var amount = amountController.text;
                    //data

                    Transactions statement = Transactions(
                        title: title,
                        amount: double.parse(amount),
                        date: DateTime.now());
                    //user provider
                    var provider = Provider.of<TransactionProvider>(context,
                        listen: false);
                    provider.addTransaction(statement);
                         Navigator.push(
                        context,
                        MaterialPageRoute(
                            fullscreenDialog: false,
                            builder: (context) {
                              return  const MyApp();
                            }));
                  
                     
                            
                        
                  }
                },
                child: const Text('Gradient'),
              )
            ]),
          ),
        ));
  }
}
