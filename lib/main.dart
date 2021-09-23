import 'package:flutter/material.dart';
import 'apis/JordanCities.dart';
import 'screens/detail_screen.dart';
import 'screens/Splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/favorite_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jordan Weather',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
    );
  }
}

class JordanCities extends StatefulWidget {
  @override
  _JordanCitiesState createState() => _JordanCitiesState();
}

class _JordanCitiesState extends State<JordanCities> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Jordan Cities...'),
          actions: [
            IconButton(
              icon: Icon(Icons.favorite,color: Colors.pinkAccent,),
                onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteCitiesPage()),);
                },)
          ]),
      body: FutureBuilder(
        future: readJason(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text('${snapshot.error} has occurred.'),
            );
          else if (snapshot.hasData) {
            final List<City> cityData = snapshot.data as List<City>;
            return ListView.builder(
                itemCount: cityData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10,),
                        InkWell(
                            child: Container(
                              width: size.width*0.8,
                              height:size.height*0.3 ,
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
                                    height:size.height*0.19 ,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                    ),

                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network('${cityData[index].image}',
                                        errorBuilder: (context,exception,stackTrace)
                                        {
                                          return ClipRRect(
                                              borderRadius: BorderRadius.circular(10.0),
                                              child: Image.asset('asstes/images/JordanFlag.jpg', fit: BoxFit.cover));
                                        },
                                        fit: BoxFit.cover,

                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text('${cityData[index].name}', style: TextStyle(fontSize: 17),)
                                ],
                              ),
                            ),

                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(),
                                    settings: RouteSettings(
                                      arguments: cityData[index].id,
                                    ),
                                  )
                              );
                            }
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
}
