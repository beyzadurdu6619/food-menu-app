import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../HomeScreen/titlemenu.dart';

class persondetails extends StatelessWidget {
  const persondetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
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
                  .doc('k9cByRmwx8SQxNGpM9SjsAHOBKQ2')
                  .get(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData && snapshot.data!.exists) {
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  return titlemenu(text:"   "+ data['numara'], kntrl: false);
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
