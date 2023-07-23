import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lap9/View/Profile/body.dart';
import 'package:lap9/components/appbar.dart';
import 'package:provider/provider.dart';
import 'package:lap9/View/HomeScreen/body.dart';
import 'package:lap9/View/Mylist/body.dart';
import 'package:lap9/View/Order/body.dart';
import 'package:lap9/View/Order/yemekListesi.dart';
import '../../View/HomeScreen/database.dart';
import '../../View/Order/productDatabase.dart';
import '../../main.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _toggleFavorite(int productIndex) {
    // Toggle the favorite status of the product at the specified index
    final productStateManager = Provider.of<ProductStateManager>(context, listen: false);
    final favoriteProducts = productStateManager.favoriteProducts;
    final product = favoriteProducts[productIndex];
    productStateManager.toggleFavorite(product);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final productStateManager = Provider.of<ProductStateManager>(context);
    final favoriteProducts = productStateManager.favoriteProducts.map((product) => product.toMap()).toList();
    final cartProducts = productStateManager.cartProducts;
    return Scaffold(
      body: Center(
        child: IndexedStack(
          index: selectedIndex,
          children: <Widget>[
            homescreen(),
            order(text: "MENU"),
            profile(),
            FavoritesPage(favoriteProducts: favoriteProducts, onToggleFavorite: _toggleFavorite),
            SepetSayfasi(cartProducts: cartProducts, onRemoveFromCart: () {
              // Implement your logic to remove products from the cart here
      // For example, clear all products from the cart.
            }),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_rounded),
            label: "Menu",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "User",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
        ],
        currentIndex: selectedIndex,
        elevation: 0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.4),
        selectedFontSize: 16,
        unselectedFontSize: 14,
        onTap: _onItemTapped,
      ),
    );
  }
}


class FavoritesPage extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteProducts;
  final void Function(int productIndex) onToggleFavorite;

  FavoritesPage({required this.favoriteProducts, required this.onToggleFavorite});

  @override
  Widget build(BuildContext context) {
    final List<Products> favoriteProductsList = favoriteProducts.map((map) => Products.fromMap(map)).toList();

    return Scaffold(
      body: Container(
        color: Colors.white, // Use Colors.grey[700] for hex #616161
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
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
                    'Favorites',
                    style: GoogleFonts.bebasNeue(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: favoriteProductsList.length,
                itemBuilder: (context, index) {
                  final product = favoriteProductsList[index];

                  return ListTile(
                    title: Text(product.name),
                    leading: Image.asset(product.image),
                    subtitle: Text('${product.getPriceBySize(1)} TL'),
                    // Display the price for a specific size, e.g., index 1.
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}











class SepetSayfasi extends StatelessWidget {
  final List<Products> cartProducts;
  final VoidCallback onRemoveFromCart; // Add this line to accept the callback

  SepetSayfasi({
    required this.cartProducts,
    required this.onRemoveFromCart,
  });


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Scaffold(
      body: Container(
        height: screenHeight * 0.8,
        color: Colors.white, // Use Colors.grey[700] for hex #616161
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
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
                    'Card',
                    style: GoogleFonts.bebasNeue(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
