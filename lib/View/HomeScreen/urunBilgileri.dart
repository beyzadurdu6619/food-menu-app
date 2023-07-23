import 'package:flutter/material.dart';
import 'package:lap9/View/HomeScreen/urun.dart';
class UrunBilgileri extends StatefulWidget {
  final String? productName;
  final String? image;

  const UrunBilgileri({Key? key, this.productName, this.image}) : super(key: key);

  @override
  _UrunBilgileriState createState() => _UrunBilgileriState();
}

class _UrunBilgileriState extends State<UrunBilgileri> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<Offset>(
      begin: Offset(0, -1),
      end: Offset(0, 0),
    ).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productName ?? ""),
      ),
      body: SlideTransition(
        position: _animation,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.green[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.image ?? "",
                      fit: BoxFit.cover,
                      height: 150,
                      width: double.infinity,
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.productName ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ürün Bilgileri",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Ürün adı: ${widget.productName ?? ""}",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Ürün fiyatı: 10\$",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Sepete ekleme işlemi
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Sepete Ekle"),
                            content: Text("Ürünü sepete eklediniz!"),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute (
                                    builder: (BuildContext context) =>  Urun(),
                                  ),);
                                },
                                child: Text("Tamam"),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text("Sepete Ekle"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

