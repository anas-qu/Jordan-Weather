import 'package:flutter/material.dart';
import 'dart:async';
import '../main.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigatetohome();
  }

  _navigatetohome()async{
    await Future.delayed(Duration(milliseconds: 1500),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> JordanCities()));
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body:Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      shape:  BoxShape.circle
                  ),
                  child: Image.asset('assets/images/logo.png')
              ),
              SizedBox(height: 200,),
              Text('Created by Anas Qunibi....',style:TextStyle(fontSize: 10,)),
            ],
          )
      ),

    );
  }
}