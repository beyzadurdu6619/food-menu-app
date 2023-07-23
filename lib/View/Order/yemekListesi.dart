import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lap9/View/HomeScreen/dataBaseHelper.dart';
import 'package:lap9/View/Order/productDatabase.dart';
import 'package:lap9/components/appbar.dart';

import '../HomeScreen/database.dart';

class Urun extends StatefulWidget {
  final Products product;
  final VoidCallback onAddToFavorite;
  final VoidCallback onAddToCart;
  final VoidCallback onRemoveFromCart;

  Urun({
    required this.product,
    required this.onAddToFavorite,
    required this.onAddToCart,
    required this.onRemoveFromCart,
  });

  @override
  _UrunState createState() => _UrunState();
}

class _UrunState extends State<Urun> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  bool isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1.2),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  void _scrollToPosition() async {
    _animationController.forward();
    await _animationController.forward().whenComplete(() {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => YeniSayfa(
              product: widget.product,
              initialOffset: _animation.value,
              isFavorite: false,
              isInCart: false,
            )
        ),
      ).then((_) {
        _animationController.reverse();
      });
    });
  }
  void addToFavorite() {
    widget.onAddToFavorite();
  }

  void addToCart() {
    widget.onAddToCart();
  }

  void removeFromCart() {
    widget.onRemoveFromCart();
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _scrollToPosition();
      },
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHovered = false;
          });
        },
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 200,
            height: 350,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
                Positioned(
                  top: 35,
                  left: 30,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 120, // Uygun genişlik için istediğiniz değeri belirleyebilirsiniz
                        child: Text(
                          widget.product.name,
                          style: GoogleFonts.bebasNeue(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SlideTransition(
                      position: _animation,
                      child: Image.asset(
                        widget.product.image,
                        fit: BoxFit.scaleDown,

                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class YemekListesi extends StatefulWidget {
  final String? text;
  final String? categoryId;
  final List<Products> filteredProducts;
  final List<Map<String, dynamic>> favoriteProducts;
  final List<Products> cartProducts;
  final VoidCallback onAddToFavorite;
  final VoidCallback onAddToCart;
  final VoidCallback onRemoveFromCart;

  YemekListesi({
    Key? key,
    this.categoryId,
    required this.filteredProducts,
    required this.favoriteProducts,
    required this.cartProducts,
    required this.onAddToFavorite,
    required this.onAddToCart,
    required this.onRemoveFromCart, this.text,
  }) : super(key: key);

  @override
  _YemekListesiState createState() => _YemekListesiState();
}

class _YemekListesiState extends State<YemekListesi> {
  late PageController _pageController;
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.4);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _addToFavorite(Products product) {
    setState(() {
      widget.favoriteProducts.add({
        'id': product.id,
        'name': product.name,
        'image': product.image,
        'price': product.price,
        'isFavorite': true,
      });
    });
  }

  void _removeFromFavorite(Products product) {
    setState(() {
      widget.favoriteProducts.removeWhere((favProduct) => favProduct['id'] == product.id);
    });
  }

  void _addToCart(Products product) {
    setState(() {
      widget.cartProducts.add(product);
    });
  }

  void _removeFromCart(Products product) {
    setState(() {
      widget.cartProducts.removeWhere((p) => p.id == product.id);
    });
  }

  Future<void> _navigateToProductDetails(BuildContext context, Products product) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => YeniSayfa(
          product: product,
          initialOffset: Offset(0, 1),
          isFavorite: widget.favoriteProducts.any((favProduct) => favProduct['id'] == product.id),
          isInCart: widget.cartProducts.any((cartProduct) => cartProduct.id == product.id),
        ),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      final bool updatedFavorite = result['isFavorite'];
      final bool updatedInCart = result['isInCart'];
      if (updatedFavorite != product.isFavorite) {
        if (updatedFavorite) {
          _addToFavorite(product);
        } else {
          _removeFromFavorite(product);
        }
      }
      if (updatedInCart != product.isInCart) {
        if (updatedInCart) {
          _addToCart(product);
        } else {
          _removeFromCart(product);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Products> filteredProducts = widget.filteredProducts
        .where((product) => product.categoryId == widget.categoryId)
        .toList();

    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;

    return Container(
      height: screenHeight,
      color: Colors.red,
      child: PageView.builder(
        controller: _pageController,
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          final Products product = filteredProducts[index];
          final bool isFavorite = widget.favoriteProducts.any((favProduct) => favProduct['id'] == product.id);
          final bool isInCart = widget.cartProducts.any((cartProduct) => cartProduct.id == product.id);

          return GestureDetector(
            onTap: () {
              _navigateToProductDetails(context, product);
            },
            child: AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                double value = 1.0;
                if (_pageController.position.haveDimensions) {
                  value = _currentPage - index;
                  value = (1 - (value.abs() * 0.4)).clamp(0.0, 1.0);
                }
                return Transform.scale(
                  scale: Curves.easeInOutSine.transform(value) * 1.2,
                  child: child,
                );
              },
              child: Container(
                child: Urun(
                  product: product,
                  onAddToFavorite: () => _addToFavorite(product),
                  onAddToCart: () => _addToCart(product),
                  onRemoveFromCart: () => _removeFromCart(product),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class YeniSayfa extends StatefulWidget {
  final Products product;
  final Offset initialOffset;
  final bool isFavorite;
  final bool isInCart;

  YeniSayfa({
    required this.product,
    required this.initialOffset,
    required this.isFavorite,
    required this.isInCart,
  });

  @override
  _YeniSayfaState createState() => _YeniSayfaState();
}
class _YeniSayfaState extends State<YeniSayfa> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  String selectedSize = 'M';
  Map<String, double> sizePrices = {
    'S': 5.0,
    'M': 10.0,
    'L': 15.0,
  };

  bool isFavorite = product.isFavorite;
  bool isInCard = product.isCard;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = Tween<Offset>(
      begin: Offset(widget.initialOffset.dx, -2),
      end: Offset(widget.initialOffset.dx, 0.7),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
    isFavorite = widget.product.isFavorite; // Initialize isFavorite from the product's property
    isInCard = widget.isInCart; // Initialize isInCard from the widget's property
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void selectSize(String size) {
    setState(() {
      selectedSize = size;
    });
  }

  double getCurrentPrice() {
    return sizePrices[selectedSize] ?? 0.0;
  }

  Future<void> _goBackToPreviousPage() async {
    _animationController.reverse();
    await Future.delayed(Duration(milliseconds: 1000));
    Navigator.pop(context, {
      'isFavorite': isFavorite, // Pass updated favorite status
      'isInCart': isInCard, // Pass updated cart status
    });
  }

  void addToCart() {
    setState(() {
      isInCard = true;
    });
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _goBackToPreviousPage();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.red,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 5),
              Stack(
                children: [
                  Card(
                    margin: EdgeInsets.only(top: 100),
                    color: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Column(
                        children: [
                          SizedBox(height: 250),

                          Text(
                            'Product Name:',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          Text(
                            widget.product.name,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Product Price:',

                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,

                            ),
                          ),
                          Text(
                            '${getCurrentPrice()} €',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () => selectSize('S'),
                                style: ElevatedButton.styleFrom(
                                  primary: selectedSize == 'S' ? null : Colors
                                      .white,
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(10),
                                  side: selectedSize == 'S'
                                      ? BorderSide(
                                      color: Colors.red, width: 2.0)
                                      : BorderSide.none,
                                ),
                                child: Text(
                                  'S',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: selectedSize == 'S'
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              ElevatedButton(
                                onPressed: () => selectSize('M'),
                                style: ElevatedButton.styleFrom(
                                  primary: selectedSize == 'M' ? null : Colors
                                      .white,
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(10),
                                  side: selectedSize == 'M'
                                      ? BorderSide(
                                      color: Colors.red, width: 2.0)
                                      : BorderSide.none,
                                ),
                                child: Text(
                                  'M',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: selectedSize == 'M' ? null : Colors
                                        .black,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              ElevatedButton(
                                onPressed: () => selectSize('L'),
                                style: ElevatedButton.styleFrom(
                                  primary: selectedSize == 'L' ? null : Colors
                                      .white,
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(10),
                                  side: selectedSize == 'L'
                                      ? BorderSide(
                                      color: Colors.red, width: 2.0)
                                      : BorderSide.none,
                                ),
                                child: Text(
                                  'L',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: selectedSize == 'L'
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: toggleFavorite,
                                icon: Icon(
                                  isFavorite ? Icons.favorite : Icons
                                      .favorite_border,
                                  color: isFavorite ? Colors.red : null,
                                  size: 35,
                                ),
                              ),
                              SizedBox(width: 20),
                              ElevatedButton.icon(
                                onPressed: () {
                                  if (isInCard) {
                                    Navigator.pop(context);
                                  } else {
                                    addToCart();
                                  }
                                },
                                icon: Icon(
                                  isInCard ? Icons.remove_shopping_cart : Icons
                                      .add_shopping_cart,
                                  size: 24,
                                ),
                                label: Text(
                                  isInCard ? '' : '',
                                  style: TextStyle(
                                      fontSize: 15, fontFamily: 'Roboto'),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: isInCard ? Colors.red : Colors
                                      .transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 10),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SlideTransition(
                        position: _animation,
                        child: SizedBox(
                          width: 250,
                          height: 230,
                          child: Image.asset(widget.product.image),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
