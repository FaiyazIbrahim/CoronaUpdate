import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http
      .get('https://covid19-stats-api.herokuapp.com/api/v1/cases?country=');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int cases;
  final int recovered;
  final int death;

  Album({this.cases, this.recovered, this.death});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      cases: json['confirmed'],
      recovered: json['recovered'],
      death: json['deaths'],
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              Text("dzsvsvdsv");

              if (snapshot.hasData) {
                return Text(
                  snapshot.data.death.toString(),
                  style: TextStyle(fontSize: 20),
                );
              }
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
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
