import 'package:flutter/material.dart';
import 'package:lap9/View/Rigester/login.dart';
import 'dart:async';

import 'package:lottie/lottie.dart';




class SplashScreen extends StatelessWidget {
  const SplashScreen( {super.key});



  @override
  Widget build(BuildContext context) {
    // Ekranı 3 saniye göstermek için Future.delayed kullanılıyor.
    // Ardından Navigator ile diğer ekrana geçiş yapılıyor.
    Timer(Duration(seconds: 6), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>LoginPage()),
      );
    });

    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            Lottie.asset(
              'assets/baslangic.json',
              width: 500,
              height: 500


            ),


          ],
        ),
      ),
    );
  }
}

