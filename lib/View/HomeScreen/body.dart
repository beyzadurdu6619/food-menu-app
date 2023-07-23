import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lap9/View/HomeScreen/category.dart';
import 'package:lap9/View/HomeScreen/foodmenu.dart';
import 'package:lap9/View/HomeScreen/itemss.dart';
import 'package:lap9/View/HomeScreen/location.dart';
import 'package:lap9/View/HomeScreen/nearme.dart';
import 'package:lap9/View/HomeScreen/titlemenu.dart';
import 'package:lap9/View/Order/iitem.dart';
import 'package:lap9/components/defultLableText.dart';
import 'package:lap9/View/HomeScreen/kampanyalar.dart';
import '../../components/Navbar/navBarr.dart';
import 'package:lap9/View/HomeScreen/location.dart';
class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  _homescreenState createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  TextEditingController t1 = TextEditingController();
  String gelenIsim = "";

  void yaziGetir() {
    FirebaseFirestore.instance
        .collection('Person')
        .doc(t1.text)
        .get()
        .then((gelenVeri) {
      setState(() {
        gelenIsim = gelenVeri.data()!['userName'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  aramaEkrani(context),
                  FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('Person')
                        .doc('M2aewUWWOgTNEHdAPOs4LWr3Jwp2')
                        .get(),
                    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasData && snapshot.data!.exists) {
                        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                        return titlemenu(text: "Welcome " + data['userName'], kntrl: false);
                      } else {
                        return titlemenu(text: '  ', kntrl: false);
                      }
                    },
                  ),
                  Container(
                    height: 300, // İstediğiniz yüksekliği belirleyebilirsiniz
                    //buraya google map haritası gelsin
                    child:HomePage(),
                  ),
                  Row(
                    children: [

                    ],
                  ),
                  titlemenu(text: "CAMPAIGNS", kntrl: true),
                  Kampanyalar(),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget aramaEkrani(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 25),
      margin: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xffECF0F1),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.search),
          hintText: 'Search',
          hintStyle: TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
