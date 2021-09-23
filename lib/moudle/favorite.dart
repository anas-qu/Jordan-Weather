class Favorite {
  String? cityName;
  String? humidity;
  String? temp;
  String? feelsLike;
  String? data;
  String? hour;
  String? weatherMain;




  Favorite({this.cityName, this.humidity,this.temp,this.data,this.feelsLike,this.hour,this.weatherMain});

  // receiving data from server
  factory Favorite.fromMap(map) {
    return Favorite(
      cityName: map['cityName'],
      humidity: map['humidity'],
      temp: map['temperature'],
      data: map['data'],
      feelsLike: map['feelsLike'],
      hour: map['hour'],
        weatherMain:map['weatherMain']
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'cityName': cityName,
      'humidity': humidity,
      'temp':temp,
      'data':data,
      'feelsLike':feelsLike,
      'hour':hour,
      'weatherMain':weatherMain,
    };
  }
}