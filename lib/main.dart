import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'album.dart';

void main() => runApp(MyApp());

Future<Album> fetchAlbum() async{
  String uri = 'https://jsonplaceholder.typicode.com/albums/1';
  final response = await http.get(Uri.parse(uri));
  if(response.statusCode == 200){
    return Album.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('ailed to load album');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Album> futureAlbum;
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Read Data',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Read Data'),
        ),
      body: Center(
        child: FutureBuilder<Album>(
          future: futureAlbum,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(snapshot.data!.userId.toString()),
                  Text(snapshot.data!.title),
                  Text(snapshot.data!.id.toString())
                ],
              );
            }else if(snapshot.hasError){
              return Text('${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
      ),
    );
  }
}

