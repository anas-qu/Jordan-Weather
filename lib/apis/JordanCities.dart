import 'dart:convert';
import 'package:flutter/services.dart'as root;

Future<List<City>>readJason()async
{
final jsonData = await root.rootBundle.loadString('asstes/jordan_cities.json');
final data =  json.decode(jsonData)as List<dynamic>;
return data.map((e) => City.fromJson(e)).toList();
}

List<City> cityFromJson(String str) => List<City>.from(json.decode(str).map((x) => City.fromJson(x)));



class City {
  City({
    required this.id,
    required this.name,
    required this.state,
    required this.country,
    required this.coord,
    required this.image,
  });

  int id;
  String name;
  String state;
  String country;
  String image;
  Coord coord;

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    state: json["state"],
    country: json['country'],
    image: json['image'],
    coord: Coord.fromJson(json["coord"]),
  );
}

class Coord {
  Coord({
    required this.lon,
    required this.lat,
  });

  double lon;
  double lat;

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
    lon: json["lon"].toDouble(),
    lat: json["lat"].toDouble(),
  );



}

