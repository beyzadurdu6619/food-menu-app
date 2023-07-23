import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lap9/View/HomeScreen/foodmenu.dart';
import 'package:lap9/View/HomeScreen/itemss.dart';
import 'package:lap9/View/Order/productSema.dart';
import 'package:lap9/View/Rigester/register.dart';

class iitem extends StatelessWidget {
  const iitem({Key? key, this.text}) : super(key: key);
  final String? text;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Container(
      height: screenHeight * 0.8,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                menuitem(
                  categoryId: '1',
                  text: "Breakfast",
                  image: "assets/english-breakfast.png",
                  color: Colors.grey[700],
                ),
                menuitem(
                  categoryId: '2',
                  text: "Burger",
                  image: "assets/hamburger.png",
                  color: Colors.grey[700],
                ),

                menuitem(
                  categoryId: '3',
                  text: "Pizza",
                  image: "assets/pizza.png",
                  color: Colors.grey[700],
                ),
                menuitem(
                  categoryId: '4',
                  text: "Sushi",
                  image: "assets/sushi-roll.png",
                  color: Colors.grey[700],
                ),
                menuitem(
                  categoryId: '5',
                  text: "BBQ",
                  image: "assets/bbq.png",
                  color:Colors.grey[700],
                ),
                menuitem(
                  categoryId: '6',
                  text: "Noodle",
                  image: "assets/noodles.png",
                  color: Colors.grey[700],
                ),
                menuitem(
                  categoryId: '7',
                  text: "Salad",
                  image: "assets/salad.png",
                  color: Colors.grey[700],
                ),
                menuitem(
                  categoryId: '8',
                  text: "Dessert",
                  image: "assets/sweets.png",
                  color: Colors.grey[700],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
