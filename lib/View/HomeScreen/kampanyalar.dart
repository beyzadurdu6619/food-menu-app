import 'package:flutter/material.dart';

import 'foodmenu.dart';
import 'package:flutter/material.dart';

class Kampanyalar extends StatelessWidget {
  const Kampanyalar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 250,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Row(
              children: [
                Image.asset('assets/kampanya3.jpg'),
                Image.asset('assets/kampanya2.jpg'),
                Image.asset('assets/kampanya3.jpg'),


              ],
            ),
          ],
        ),
      ),
    );
  }
}
