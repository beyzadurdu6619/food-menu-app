import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initializeDatabase();
    return _database;
  }

  DatabaseHelper.internal();

  Future<Database> initializeDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my_database.db');

    // Veritabanını oluştur
    Database database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  void _onCreate(Database db, int version) async {
    // Tablo oluşturma işlemleri
    await db.execute('CREATE TABLE products (id INTEGER PRIMARY KEY, name TEXT, price REAL)');
  }
  Future<int> addProduct(Product product) async {
    final db = await database;
    return db!.insert('products', product.toMap());
  }
}

class Product {
  final int id;
  final String name;
  final double price;
  late final bool isFavorite;
  final bool isCard;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.isFavorite,
    required this.isCard,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'isFavorite': isFavorite,
      'isCard': isCard,
    };
  }
}

Product product = Product(id: 1, name: 'Ürün Adı', price: 10.99,isFavorite:false,isCard:false);
Future<void> main() async {
  DatabaseHelper dbHelper = DatabaseHelper();
  Database? database = await dbHelper.database; // Veritabanını başlat

  if (database != null) {
    Product product = Product(id: 1, name: 'Ürün Adı', price: 10.99, isFavorite: false, isCard: false);

    int insertedId = await dbHelper.addProduct(product);
    print('Eklenen ürünün ID\'si: $insertedId');
  } else {
    print('Veritabanı başlatılamadı!');
  }
}

