import 'package:flutter/material.dart';
import '../apis/selected_city_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../moudle/favorite.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'favorite_screen.dart';




class DetailScreen extends StatefulWidget
{
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String? name;

  double? temp ;

  int? humidity ;

  double? feelsLike;
 String? weatherMain;





  @override
  Widget build(BuildContext context)
  {
    Size size = MediaQuery.of(context).size;
    final id = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () =>Navigator.pop(context),
          icon: Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.deepOrangeAccent
          ),
        ),

      ),
      body: FutureBuilder(
        future: getweather(id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError)
            return Stack(
              children: [
                Container(
                  width: size.width,
                    height: size.height,
                    child: Image.asset('assets/images/Lost-in-the-Fog.jpg',fit: BoxFit.cover,),
                ),
                Center(
                  child:Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Error 404!',style: TextStyle(fontSize: 20,color: Colors.deepOrangeAccent,fontWeight: FontWeight.bold),),
                        Text('No data for this city is not available now...',style: TextStyle(fontSize: 10,color: Colors.deepOrangeAccent,fontWeight: FontWeight.bold),)
                      ],
                    ),

                ),
              ],
            );
          else if (snapshot.hasData) {
            final Weather data = snapshot.data as Weather;
            name= data.name;
            temp= data.main.temp;
            humidity=data.main.humidity;
            feelsLike=data.main.feelsLike;


            return ListView.builder(
                itemCount: data.weather.length,
                itemBuilder: (BuildContext context, int index) {
                  weatherMain= data.weather[index].main.toString();
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10,),
                         Container(
                              width: size.width*0.8,
                              height:size.height*0.9 ,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                boxShadow: [
                                  BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 5, blurRadius: 7, offset: Offset(0, 3)),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: size.width*0.8,
                                    height:size.height*0.1 ,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                    ),
                                      child: data.weather[index].main=='Clear'?Image.asset('assets/images/sun.png'):Image.asset('assets/images/cloud.png')
                                    ),
                           ListTile(
                             title: Text(
                               'Name: ${name= data.name}',
                               style: TextStyle(fontSize: 10),
                             ),
                           ),
                           ListTile(
                             title: Text(
                               'Base : ${data.base}',
                               style: TextStyle(fontSize: 10),
                             ),
                           ),
                           ListTile(
                             title: Text(
                               'Description: ${data.weather[index].description}',
                               style: TextStyle(fontSize: 10),
                             ),
                           ),
                           ListTile(
                             title: Text(
                               'Main: ${data.weather[index].main}',
                               style: TextStyle(fontSize: 10),
                             ),
                           ),
                           ListTile(
                             title: Text(
                               'Feels Like: ${data.main.feelsLike}',
                               style: TextStyle(fontSize: 10),
                             ),
                           ),
                           ListTile(
                             title: Text(
                               'Humidity: ${data.main.humidity}',
                               style: TextStyle(fontSize: 10),
                             ),
                           ),
                           ListTile(
                             title: Text(
                               'Pressure: ${data.main.pressure}',
                               style: TextStyle(fontSize: 10),
                             ),
                           ),
                           ListTile(
                             title: Text(
                               'Temperature: ${data.main.temp}',
                               style: TextStyle(fontSize: 10),
                             ),
                           ),
                                  IconButton(onPressed:(){
                                    postFavoriteToFirestore();
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteCitiesPage(),
                                    ),);
                                  },icon:Icon(Icons.favorite,color: Colors.pinkAccent,))
                                ],
                              ),
                            ),
                        SizedBox(height: 10,),
                      ],
                    ) ,
                  );
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),

    );
  }

  postFavoriteToFirestore() async
  {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    Favorite favorite = Favorite();

    //writing all the values
    favorite.cityName = name;
    favorite.temp=temp.toString();
    favorite.humidity=humidity.toString();
    favorite.feelsLike=feelsLike.toString();
    favorite.data=DateTime.now().toString().split(' ')[0];
    favorite.hour='${DateTime.now().hour}:${DateTime.now().minute}';
    favorite.weatherMain=weatherMain;


    await firebaseFirestore
        .collection("favorite")
        .doc()
        .set(favorite.toMap());

    Fluttertoast.showToast(msg: "Favorite added successfully.");
  }
}

