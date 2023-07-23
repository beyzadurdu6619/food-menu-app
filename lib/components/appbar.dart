import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class appbarr extends StatelessWidget {
  const appbarr({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(


      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 55,
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(

            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset('assets/back.png'),
          ),

          Text(
            text!,

            style: GoogleFonts.bebasNeue(color: Colors.black,fontSize: 25)
    ,
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
