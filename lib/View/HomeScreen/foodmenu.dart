import 'package:flutter/material.dart';
import 'package:flutter_provider/flutter_provider.dart';
import 'package:lap9/View/Order/productSema.dart';

import '../../components/Navbar/navBarr.dart';
import 'database.dart';

class menuitem extends StatefulWidget {
  final String categoryId;
  final Color? color;
  final String? text;
  final String? image;

  const menuitem({
    Key? key,
    required this.color,
    required this.text,
    required this.image,
    required this.categoryId,
  }) : super(key: key);

  @override
  _menuitemState createState() => _menuitemState();
}

class _menuitemState extends State<menuitem> {
  String? selectedText;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    return InkWell(
      onTap: () {
        setState(() {
          selectedText = widget.text;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductSema(
              text: widget.text,
              categoryId: widget.categoryId,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(6),
        height: 150,
        width: screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: widget.color!,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(left: 30, top: 30, bottom: 30),
              child: Text(
                selectedText ?? widget.text!,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 120, bottom: 25),
                height: 100,
                width: screenWidth,
                child: Image.asset(
                  widget.image!,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
