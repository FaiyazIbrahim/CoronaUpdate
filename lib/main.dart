import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<int> fetchData() async {
  String url = 'https://api.covid19api.com/summary';
  var response = await http
      .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
  print(response.body);
  var extract = json.decode(response.body);
  extract.toString();
  //var data;
  //data = extract["Message"];
  //print(extract["Message"]);
  print(extract["Message"]["Global"]["TotalConfirmed"]);
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    //futureAlbum = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid-19 Alert',
      theme: ThemeData(
        primarySwatch: Colors.primaryBlack,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Covid-19 Alert'),
          backgroundColor: Color.fromARGB(100, 50, 62, 45),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: fetchData,
        ),
        body: Padding(
          padding: const EdgeInsets.only(
              top: 200, bottom: 20, left: 152, right: 150),
        ),
        // body: Center(
        //   child: FutureBuilder<Album>(
        //     future: futureAlbum,
        //     builder: (context, snapshot) {
        //       Text("dzsvsvdsv");

        //       if (snapshot.hasData) {
        //         return Text(
        //           snapshot.data.death.toString(),
        //           style: TextStyle(fontSize: 20),
        //         );
        //       }
        //       if (snapshot.hasError) {
        //         return Text("${snapshot.error}");
        //       }
        //       // By default, show a loading spinner.
        //       return CircularProgressIndicator();
        //     },
        //   ),
        // ),
      ),
    );
  }
}
