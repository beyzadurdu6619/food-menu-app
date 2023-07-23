import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:lap9/View/Profile/customAction.dart';
import 'package:lap9/View/Profile/personDetails.dart';
import 'package:lap9/View/Rigester/login.dart';

import '../HomeScreen/titlemenu.dart';

class profile extends StatelessWidget {
  const profile({super.key});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 125,
                ),
                persondetails(),
                SizedBox(
                  height: 35,
                ),
                Container(

                  child: Column(
                    children: [
                      FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('Person')
                            .doc('M2aewUWWOgTNEHdAPOs4LWr3Jwp2')
                            .get(),
                        builder: (BuildContext context, AsyncSnapshot<
                            DocumentSnapshot> snapshot) {
                          if (snapshot.hasData && snapshot.data!.exists) {
                            Map<String, dynamic> data = snapshot.data!
                                .data() as Map<String, dynamic>;
                            return titlemenu(
                                text: 'Email: ' + data['email'],
                                kntrl: false);
                          } else {
                            return titlemenu(text: '',
                                kntrl: false); // Return an empty titlemenu widget in case of no data
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('Person')
                            .doc('M2aewUWWOgTNEHdAPOs4LWr3Jwp2')
                            .get(),
                        builder: (BuildContext context, AsyncSnapshot<
                            DocumentSnapshot> snapshot) {
                          if (snapshot.hasData && snapshot.data!.exists) {
                            Map<String, dynamic> data = snapshot.data!
                                .data() as Map<String, dynamic>;
                            return titlemenu(
                                text: 'Phone Number: ' + data['telno'],
                                kntrl: false);
                          } else {
                            return titlemenu(text: '',
                                kntrl: false); // Return an empty titlemenu widget in case of no data
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('Person')
                            .doc('M2aewUWWOgTNEHdAPOs4LWr3Jwp2')
                            .get(),
                        builder: (BuildContext context, AsyncSnapshot<
                            DocumentSnapshot> snapshot) {
                          if (snapshot.hasData && snapshot.data!.exists) {
                            Map<String, dynamic> data = snapshot.data!
                                .data() as Map<String, dynamic>;
                            return titlemenu(text: 'Addres: ' + data['adres'],
                                kntrl: false);
                          } else {
                            return titlemenu(text: '',
                                kntrl: false); // Return an empty titlemenu widget in case of no data
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (contex) => LoginPage()));
                        },
                        child: Container(
                          margin: EdgeInsets.all(15),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 52,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xffECF0F1),
                          ),
                          child: Center(
                            child: Text(
                              'Sign out',
                              style: TextStyle(
                                fontSize: 23,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

  class persondetails extends StatelessWidget {
  const persondetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 54,
              child: Image.asset('assets/user.png'),
            ),

            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('Person')
                  .doc('M2aewUWWOgTNEHdAPOs4LWr3Jwp2')
                  .get(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData && snapshot.data!.exists) {
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  return titlemenu(text:"                     "+ data['userName'], kntrl: false);
                } else {
                  return titlemenu(text: '  ', kntrl: false);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

