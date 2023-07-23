import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lap9/View/HomeScreen/ilkEkran.dart';
import 'package:lap9/View/Order/productDatabase.dart';
import 'package:lap9/View/Order/yemekGorunum.dart';
import 'package:lap9/components/Navbar/navBarr.dart';
import 'package:lap9/components/Navbar/unuseblenavBar.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';


import 'View/HomeScreen/dataBaseHelper.dart';
import 'View/HomeScreen/database.dart';
import 'View/HomeScreen/foodmenu.dart';

class FavoritesProvider with ChangeNotifier {
  List<Products> _favoriteProducts = [];

  List<Products> get favoriteProducts => _favoriteProducts;

  bool isFavorite(Products product) {
    return favoriteProducts.contains(product);
  }

  void addToFavorites(Products product) {
    _favoriteProducts.add(product);
    notifyListeners();
  }

  void removeFromFavorites(int productId) {
    _favoriteProducts.removeWhere((favProduct) => favProduct.id == productId);
    notifyListeners();
  }
}

class CartProvider with ChangeNotifier {
  List<Products> _cartProducts = [];

  List<Products> get cartProducts => _cartProducts;

  bool isInCart(Products product) {
    return _cartProducts.any((cartProduct) => cartProduct.id == product.id);
  }

  void addToCart(Products product) {
    _cartProducts.add(product);
    notifyListeners();
  }

  void removeFromCart(Products product) {
    _cartProducts.removeWhere((cartProduct) => cartProduct.id == product.id);
    notifyListeners();
  }
}

// Örnek kullanım
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final favoritesProvider = FavoritesProvider();
 // Call the initialize method




  await ProductDatabase.instance.database;
  await ProductDatabase.instance.createProduct(Products(
    id: 1,
    name: 'Serpme Kahvaltı',
    price: [100.0, 100.0, 100.0],
    image: 'assets/serpme.jpg',
    isFavorite: false,
    isInCart: false,
    categoryId: '1',
  ));
  await ProductDatabase.instance.createProduct(Products(
    id: 2,
    name: 'Gözleme',
    price: [50.0, 50.0, 50.0],
    image: 'assets/noodles.png',
    isFavorite: false,
    isInCart: false,
    categoryId: '1',
  ));
  await ProductDatabase.instance.createProduct(Products(
    id: 3,
    name: 'Pişi (6 adet)',
    price: [40.0, 40.0, 40.0],
    image: 'assets/pisi.jpeg',
    isFavorite: false,
    isInCart: false,
    categoryId: '1',
  ));
  await ProductDatabase.instance.createProduct(Products(
    id: 4,
    name: 'Menemen',
    price: [50.0, 50.0, 50.0],
    image: 'assets/menemen.jpg',
    isFavorite: false,
    isInCart: false,
    categoryId: '1',
  ));
  await ProductDatabase.instance.createProduct(Products(
    id: 5,
    name: 'Cheeseburger Menu',
    price: [150.0, 150.0, 150.0],
    image: 'assets/cheeseburger-menu.png',
    isFavorite: false,
    isInCart: false,
    categoryId: '2',
  ));
  await ProductDatabase.instance.createProduct(Products(
    id: 6,
    name: 'Rodeo Whopper Menu',
    price: [150.0, 150.0, 150.0],
    image: 'assets/rodeo-whopper-menu.png',
    isFavorite: false,
    isInCart: false,
    categoryId: '2',
  ));
  await ProductDatabase.instance.createProduct(Products(
    id: 7,
    name: 'Tavuk Burger',
    price: [130.0, 130.0, 130.0],
    image: 'assets/tavukburger-menu.png',
    isFavorite: false,
    isInCart: false,
    categoryId: '2',
  ));
  await ProductDatabase.instance.createProduct(Products(
    id: 8,
    name: 'Whopper Menu',
    price: [150.0, 150.0, 150.0],
    image: 'assets/whopper-menu.png',
    isFavorite: false,
    isInCart: false,
    categoryId: '2',
  ));
  await ProductDatabase.instance.createProduct(Products(
    id: 9,
    name: 'Karışık Pizza',
    price: [100.0, 130.0, 160.0],
    image: 'assets/karisik-pizza.png',
    isFavorite: false,
    isInCart: false,
    categoryId: '3',
  ));
  await ProductDatabase.instance.createProduct(Products(
    id: 10,
    name: 'Tavuklu Pizza',
    price: [100.0, 120.0, 140.0],
    image: 'assets/tavuklu-pizzza.png',
    isFavorite: false,
    isInCart: false,
    categoryId: '3',
  ));
  await ProductDatabase.instance.createProduct(Products(
    id: 11,
    name: 'Vejeteryan Pizza',
    price: [90.0, 110.0, 130.0],
    image: 'assets/vejeteryan.jpeg',
    isFavorite: false,
    isInCart: false,
    categoryId: '3',
  ));
  await ProductDatabase.instance.createProduct(Products(
    id: 12,
    name: 'Chumaki',
    price: [100.0, 100.0, 100.0],
    image: 'assets/chumaki.avif',
    isFavorite: false,
    isInCart: false,
    categoryId: '4',
  ));
  await ProductDatabase.instance.createProduct(Products(
    id: 13,
    name: 'Uramaki',
    price: [110.0, 110.0, 110.0],
    image: 'assets/chumaki.avif',
    isFavorite: false,
    isInCart: false,
    categoryId: '4',
  ));
  await ProductDatabase.instance.createProduct(Products(
    id: 14,
    name: 'Nigiri',
    price: [120.0, 120.0, 120.0],
    image: 'assets/chumaki.avif',
    isFavorite: false,
    isInCart: false,
    categoryId: '4',
  ));
  await ProductDatabase.instance.createProduct(Products(
    id: 15,
    name: 'BBQ',
    price: [400.0, 400.0, 400.0],
    image: 'assets/bbq1.png',
    isFavorite: false,
    isInCart: false,
    categoryId: '5',
  ));
  await ProductDatabase.instance.createProduct(Products(
    id: 16,
    name: 'Deniz Mahsullu Noodle',
    price: [150.0, 150.0, 150.0],
    image: 'assets/denizmahsullu-noodle.png',
    isFavorite: false,
    isInCart: false,
    categoryId: '6',
  ));
  await ProductDatabase.instance.createProduct(Products(
    id: 17,
    name: 'Sebzeli Noodle',
    price: [110.0, 110.0, 110.0],
    image: 'assets/sebzeli-noodle.png',
    isFavorite: false,
    isInCart: false,
    categoryId: '6',
  ));
  await ProductDatabase.instance.createProduct(Products(
    id: 18,
    name: 'Frambuazlı Cheesecake',
    price: [80.0, 80.0, 80.0],
    image: 'assets/fram-cheesecake.webp',
    isFavorite: true,
    isInCart: false,
    categoryId: '9',
  ));

  await ProductDatabase.instance.createProduct(Products(
    id: 21,
    name: 'Limonlu Cheesecake',
    price: [80.0, 80.0, 80.0],
    image: 'assets/limonlu-cheesecake.webp',
    isFavorite: false,
    isInCart: false,
    categoryId: '8',
  ));
  await ProductDatabase.instance.createProduct(Products(
    id: 22,
    name: 'Lotuslu Cheesecake',
    price: [80.0, 80.0, 80.0],
    image: 'assets/lotuslu-cheesecake.webp',
    isFavorite: true,
    isInCart: false,
    categoryId: '8',
  ));
  await ProductDatabase.instance.createProduct(Products(
    id: 23,
    name: 'Tavuklu Sezar Salata',
    price: [110.0, 110.0, 110.0],
    image: 'assets/tavuklu-sezar-salata.webp',
    isFavorite: false,
    isInCart: false,
    categoryId: '7',
  ));
  await ProductDatabase.instance.createProduct(Products(
    id: 24,
    name: 'Ton Balıklı Salata',
    price: [120.0, 120.0, 120.0],
    image: 'assets/tonbalikli-salata.webp',
    isFavorite: true,
    isInCart: false,
    categoryId: '7',
  ));

  runApp(
    MultiProvider(
      providers: [
        // Add other providers if needed
        Provider<FavoritesProvider>(create: (_) => FavoritesProvider()),
        Provider<CartProvider>(create: (_) => CartProvider()),
        ChangeNotifierProvider<ProductStateManager>(
          create: (_) => ProductStateManager(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final List<Map<String, dynamic>> favoriteProducts;
  late final List<Products> cartProducts;

  @override
  void initState() {
    super.initState();

  }
  Future<void> initializeSharedPreferences() async {
    await SharedPreferences.getInstance();
  }
  @override

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeSharedPreferences(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Your App Title',
            home: SplashScreen(),
            // Other MaterialApp configurations
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}