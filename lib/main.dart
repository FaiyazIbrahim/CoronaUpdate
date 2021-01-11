import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var total_recovered;
var total_deaths;
var total_confirmed;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'corona',
      theme: ThemeData(
        primarySwatch: Colors.primaryBlack,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'corona update'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //String url = "https://api.covid19api.com/summary";
  String url = "https://api.covid19api.com/summary";

  Future<String> makeReq() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    //print(response.body);
    var extractData = jsonDecode(response.body);
    //print(response.body);

    //print(extractData["Global"]["TotalConfirmed"]);
    //print(extractData["Global"]["TotalDeaths"]);
    //print(extractData["Global"]["TotalRecovered"]);
    total_recovered = extractData["Global"]["TotalRecovered"];
    total_confirmed = extractData["Global"]["TotalConfirmed"];
    total_deaths = extractData["Global"]["TotalDeaths"];
    print(total_recovered);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
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
        floatingActionButton: FloatingActionButton(
          onPressed: makeReq,
          child: Icon(Icons.replay),
          backgroundColor: Colors.black,
        ));
  }
}
