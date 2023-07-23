import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_provider/flutter_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../main.dart';
import '../HomeScreen/database.dart';

class ProductDatabase {
  static final ProductDatabase instance = ProductDatabase._init();

  static Database? _database;

  ProductDatabase._init();
  Future<List<Products>> getAllProducts() async {
    final db = await instance.database;

    final products = await db.query(tableProducts);

    return products.map((json) => Products.fromMap(json)).toList();
  }


  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('products.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final doubleType = 'REAL NOT NULL';

    await db.execute('''
      CREATE TABLE $tableProducts (
        ${ProductFields.id} $idType,
        ${ProductFields.name} TEXT NOT NULL,
        ${ProductFields.price} TEXT NOT NULL,
        ${ProductFields.image} TEXT NOT NULL,
        ${ProductFields.isFavorite} INTEGER NOT NULL,
        ${ProductFields.isInCart} INTEGER NOT NULL,
        ${ProductFields.categoryId} TEXT NOT NULL
      )
    ''');
  }

  Future<void> createProduct(Products product) async {
    final db = await instance.database;

    await db.insert(
      tableProducts,
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<List<Products>> getFavoriteProducts() async {
    final db = await instance.database;

    final products = await db.query(
      tableProducts,
      where: '${ProductFields.isFavorite} = ?',
      whereArgs: [true], // 1 represents true (favorite).
    );

    return products.map((json) => Products.fromMap(json)).toList();
  }

  Future<List<Products>> getProductsByCategoryId(String categoryId) async {
    final db = await instance.database;

    final products = await db.query(
      tableProducts,
      where: '${ProductFields.categoryId} = ?',
      whereArgs: [categoryId],
    );

    return products.map((json) => Products.fromMap(json)).toList();
  }

  Future<Products> getProductById(int id) async {
    final db = await instance.database;

    final products = await db.query(
      tableProducts,
      where: '${ProductFields.id} = ?',
      whereArgs: [id],
    );

    return Products.fromMap(products.first);
  }


}


class ProductFields {

  static final String id = 'id';
  static final String name = 'name';
  static final String price = 'price';
  static final String image = 'image';
  static final String isFavorite = 'isFavorite';
  static final String isInCart = 'isInCart';
  static final String categoryId = 'categoryId';
}

const String tableProducts = 'products';
class LocalDataManager {
  static final LocalDataManager _instance = LocalDataManager._init();

  factory LocalDataManager() => _instance;

  LocalDataManager._init();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Methods to handle favorite products
  List<int> getFavoriteProductIds() {
    return _prefs?.getStringList('favoriteProducts')?.map((id) => int.parse(id))?.toList() ?? [];
  }

  Future<void> saveFavoriteProductIds(List<int> productIds) async {
    await _prefs?.setStringList('favoriteProducts', productIds.map((id) => id.toString()).toList());
  }

  // Methods to handle cart products
  List<int> getCartProductIds() {
    return _prefs?.getStringList('cartProducts')?.map((id) => int.parse(id))?.toList() ?? [];
  }

  Future<void> saveCartProductIds(List<int> productIds) async {
    await _prefs?.setStringList('cartProducts', productIds.map((id) => id.toString()).toList());
  }
}
class ProductStateManager extends ChangeNotifier {
  static final ProductStateManager _instance = ProductStateManager._init();
  BuildContext? _context; // Nullable variable to hold context
  List<Products> _products = []; // List of products

  factory ProductStateManager() => _instance;

  ProductStateManager._init();

  // Method to set the context when needed
  void setContext(BuildContext context) {
    _context = context;
  }


  List<int> favoriteProductIds = [];
  List<int> cartProductIds = [];
  List<Products> get favoriteProducts {
    return _products.where((product) => favoriteProductIds.contains(product.id)).toList();
  }

  List<Products> get cartProducts {
    return _products.where((product) => cartProductIds.contains(product.id)).toList();
  }
  void toggleFavorite(Products product) {
    final favoritesProvider = Provider.of<FavoritesProvider>(_context!, listen: false);
    if (product.isFavorite) {
      favoritesProvider.removeFromFavorites(product.id);
      favoriteProductIds.remove(product.id);
    } else {
      favoritesProvider.addToFavorites(product);
      favoriteProductIds.add(product.id);
    }
    product.isFavorite = !product.isFavorite;
    LocalDataManager().saveFavoriteProductIds(favoriteProductIds);
    notifyListeners();
  }

  void toggleCart(Products product) {
    final cartProvider = Provider.of<CartProvider>(_context!, listen: false);
    if (product.isInCart) {
      cartProvider.removeFromCart(product.id as Products);
      cartProductIds.remove(product.id);
    } else {
      cartProvider.addToCart(product);
      cartProductIds.add(product.id);
    }
    product.isInCart = !product.isInCart;
    LocalDataManager().saveCartProductIds(cartProductIds);
    notifyListeners();
  }


  void addToFavorite(Products product) {
    favoriteProducts.add(product);
  }

  void removeFromFavorite(int productId) {
    favoriteProducts.removeWhere((product) => product.id == productId);
  }

  void addToCart(Products product) {
    cartProducts.add(product);
  }

  void removeFromCart(int productId) {
    cartProducts.removeWhere((product) => product.id == productId);
  }




}

