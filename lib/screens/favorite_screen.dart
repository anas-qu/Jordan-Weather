import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FavoriteCitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Cities'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('favorite').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView(
                children: snapshot.data!.docs.map((cityData) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10,),
                        Container(
                          width: size.width,
                          height:size.height*0.45,
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
                                  width: size.width,
                                  height:size.height*0.1 ,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                  ),
                                  child: cityData['weatherMain']=='Clear'?Image.asset('assets/images/sun.png'):Image.asset('assets/images/cloud.png')
                              ),
                              Text('Name:${cityData['cityName'].toString()}',
                                  style: TextStyle(fontSize: 20)),
                              Text('Data:${cityData['data'].toString()} ${cityData['hour'].toString()}',
                                  style: TextStyle(fontSize: 20)),
                              Text('Temperature:${cityData['temp'].toString()}',
                                  style: TextStyle(fontSize: 20)),
                              Text('Feels Like:${cityData['feelsLike']
                                  .toString()}', style: TextStyle(fontSize: 20)),
                              Text('Humidity:${cityData['humidity'].toString()}',
                                  style: TextStyle(fontSize: 20)),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.deepOrange,
                                  ),
                                  child: Text('Delete'),
                                  onPressed: (){
                                    cityData.reference.delete();
                                    Fluttertoast.showToast(msg: "Favorite Deleted successfully.");
                                  }
                              ),


                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                      ],
                    ) ,
                  );
                }).toList(),
              );

            }
          }
          return Center(
            child: Column(children: [
              Text(
                'You don\'t added cities to favorite yet',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ], mainAxisAlignment: MainAxisAlignment.center),
          );
        },
      ),
    );
  }



}