// import 'package:flutter/material.dart';

// import 'moneybox.dart';
// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "My App",
//       home: const MyHomePage(),
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.blue,
//         ),
//       ),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "my account",
//           style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//         ),
//       ),

//       body: Padding(
//         padding: const EdgeInsets.all(8.0),

//         child: Column(children: [
//           MoneyBox("title", 100000, Colors.blue, 120),
//           const SizedBox(height: 5,),
//           MoneyBox("title", 100000, Colors.lightBlue, 120),
//            const SizedBox(height: 5,),
//           MoneyBox("title", 100000, Colors.green, 120),
//            const SizedBox(height: 5,),
//           MoneyBox("title", 0, Colors.lightGreen, 120),
//         ]),
//       ),
//     );
//   }
// }

// ignore_for_file: avoid_print

// import 'package:flutter/material.dart';
// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "My App",
//       home: const MyHomePage(),
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.blue,
//         ),
//       ),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int number = 0;
//   @override
//   void initState() {
//     super.initState();
//     print("one time");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             "my account",
//             style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(children: [
//             Text(
//               number.toString(),
//               style: const TextStyle(fontSize: 30),
//             )
//           ]),
//         ),
//         floatingActionButton: FloatingActionButton(
//             onPressed: () {
//               setState(() {
//                 number++;
//                 if(number ==100){ print('you so free time');number=0;}
//               });
//             },
//             child: const Icon(Icons.add)));
//   }
// }

// void  main() async {
//     print(await Login());
// }

//   Login() async {
//   var user = await getUserFromDatabase();
//   return "name :" +user;
// }

// Future<String> getUserFromDatabase() {
//   return Future.delayed(const Duration(seconds: 10), () => "sssss");
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_1/moneybox.dart';
import 'package:http/http.dart' as http;
import 'ExchangeRate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "MyApp",
        home: const MyHomePage(),
        theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.blue,
            )));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ExchangeRate? _dataFromAPI;
  @override
  void initState() {
    super.initState();
    getExchangeRate();
  }

  Future getExchangeRate() async {
    var url = "https://open.er-api.com/v6/latest/USD";
    Uri uri = Uri.parse(url);
    var response = await http.get(uri);
    _dataFromAPI = exchangeRateFromJson(response.body);
    return _dataFromAPI;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "my account",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
          future: getExchangeRate(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var result = snapshot.data;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    MoneyBox("USD", 1, Colors.blue, 120),
                    MoneyBox("AED", result.rates["AED"], Colors.blue, 120)
                    ],
                ),
              );
            }
            return const LinearProgressIndicator();
          }),
    );
  }
}
