import 'package:flutter/material.dart';

class Urun extends StatefulWidget {
  @override
  _UrunState createState() => _UrunState();
}

class _UrunState extends State<Urun> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 8),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  void _scrollToPosition() {
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resim Hareketi'),
      ),
      body: ListView.builder(
        itemCount: 5, // Replace with the actual number of items in your row
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: _scrollToPosition,
            child: SlideTransition(
              position: _animation,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset('assets/pizza.png'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
