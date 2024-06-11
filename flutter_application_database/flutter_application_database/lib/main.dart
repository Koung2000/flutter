import 'package:flutter/material.dart';
import 'package:flutter_application_database/providers/transaction_provider.dart';
import 'package:flutter_application_database/screens/form_screen.dart';
import 'package:flutter_application_database/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider();
        })
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'money'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.blue,
          body: TabBarView(children: [const HomeScreen(), FromScreen()]),
          bottomNavigationBar: const TabBar(tabs: [
            Tab(
              icon:Icon(Icons.list),
              text: "list",
            ),
            Tab(
              icon:Icon(Icons.add),
              text: "save",
            )
          ]),
        ));
  }
}
