import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<Personaje> fetchPerson() async {
  final response =
      await http.get(Uri.parse('https://rickandmortyapi.com/api/character/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Personaje.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Personaje {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final dynamic origin;
  final dynamic location;
  final String image;
  final List episode;
  final String url;
  final String created;

  const Personaje({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory Personaje.fromJson(Map<String, dynamic> json) {
    return Personaje(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['name'],
      type: json['type'],
      gender: json['gender'],
      origin: json['origin'],
      location: json['location'],
      image: json['image'],
      episode: json['episode'],
      url: json['url'],
      created: json['created'],
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Personaje> futurePersonaje;

  @override
  void initState() {
    super.initState();
    futurePersonaje = fetchPerson();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Personaje>(
            future: futurePersonaje,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    Text(snapshot.data!.name),
                    Text(snapshot.data!.status),
                    Text(snapshot.data!.species),
                    Image.network(snapshot.data!.image)
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
