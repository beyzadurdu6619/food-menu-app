import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class YemekListesi extends StatelessWidget {
  const YemekListesi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.yellow,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Toplamda göstermek istediğiniz ürün sayısı
        itemBuilder: (context, index) {
          final products = [
            {
              'text': 'Sushi',
              'image': 'assets/sushi-rol.png',
              'color': Color.fromARGB(106, 52, 152, 219),
            },
            {
              'text': 'BBQ',
              'image': 'assets/bbq.png',
              'color': Color.fromARGB(106, 52, 152, 219),
            },
            {
              'text': 'Noodle',
              'image': 'assets/noodles.png',
              'color': Color.fromARGB(117, 156, 89, 182),
            },
            {
              'text': 'Burger',
              'image': 'assets/hamburger.png',
              'color': Color.fromARGB(117, 156, 89, 182),
            },
            {
              'text': 'Fruit',
              'image': 'assets/fruit.png',
              'color': Color.fromARGB(106, 52, 152, 219),
            },
          ];

          final product = products[index % products.length];
          final text = product['text'] as String;
          final image = product['image'] as String;
          final color = product['color'] as Color;

          return Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: menuUrun(
              text: text,
              image: image,
              color: color,
            ),
          );
        },
      ),
    );
  }
}

class menuUrun extends StatefulWidget {
  final Color? color;
  final String? text;
  final String? image;

  const menuUrun({Key? key, this.color, this.text, this.image}) : super(key: key);

  @override
  _menuUrunState createState() => _menuUrunState();
}

class _menuUrunState extends State<menuUrun> {
  late PageController _coffeeController;
  late double _currentPosition;

  @override
  void initState() {
    super.initState();
    _coffeeController = PageController(viewportFraction: 0.6, initialPage: 4);
    _currentPosition = _coffeeController.initialPage.toDouble();
  }

  @override
  void dispose() {
    _coffeeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: widget.color ?? Colors.orange,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          widget.text ?? "",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
