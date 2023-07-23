import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class titlemenu extends StatelessWidget {
  const titlemenu({super.key, this.text,this.kntrl});
  final String? text;
  final bool? kntrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text!,

            style: TextStyle(


                fontSize: 15,
                color: Color.fromARGB(255, 0, 0,0),
                fontWeight: FontWeight.w900),

          ),
          if(kntrl==true)
            TextButton(onPressed: () {}, child: Text('View All'))


        ],
      ),
    );
  }
}
