class Products {
  final int id;
  final String name;
  final List<double> price;
  final String image;
  late final bool isFavorite;
  late final bool isInCart;
  final String categoryId;

  Products({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.isFavorite,
    required this.isInCart,
    required this.categoryId,
  });

  double getPriceBySize(int size) {
    if (size >= 0 && size < price.length) {
      return price[size];
    } else {
      return 0.0;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price.join(','),
      'image': image,
      'isFavorite': isFavorite ? 1 : 0,
      'isInCart': isInCart ? 1 : 0,
      'categoryId': categoryId,
    };
  }

  factory Products.fromMap(Map<String, dynamic> map) {
    return Products(
      id: map['id'],
      name: map['name'],
      price: (map['price'] as String).split(',').map((price) => double.parse(price)).toList(),
      image: map['image'],
      isFavorite: map['isFavorite'] == 1,
      isInCart: map['isInCart'] == 1,
      categoryId: map['categoryId'],
    );
  }
}


List<Products> productsDatabase = [
  //Kahvaltı
  Products(
    id: 1,
    name: 'Serpme Kahvaltı',
    price: [100.0, 100.0, 100.0],
    image: 'assets/serpme.jpg',
    isFavorite: false,
    isInCart: false,
    categoryId: '1',
  ),

  Products(
    id: 2,
    name: 'Gözleme',
    price: [50.0, 50.0, 50.0],
    image: 'assets/gozleme.jpg',
    isFavorite: false,
    isInCart: false,
    categoryId: '1',
  ),
  Products(
    id: 3,
    name: 'Pişi (6 adet)',
    price: [40.0, 40.0, 40.0],
    image: 'assets/pisi.jpeg',
    isFavorite: false,
    isInCart: false,
    categoryId: '1',
  ),

  Products(
    id: 4,
    name: 'Menemen',
    price: [50.0, 50.0, 50.0],
    image: 'assets/menemen.jpg',
    isFavorite: false,
    isInCart: false,
    categoryId: '1',
  ),
  //Burger
  Products(
    id: 5,
    name: 'Cheeseburger Menu',
    price: [150.0, 150.0, 150.0],
    image: 'assets/cheeseburger-menu.png',
    isFavorite: false,
    isInCart: false,
    categoryId: '2',
  ),

  Products(
    id: 6,
    name: 'Rodeo Whopper Menu',
    price: [150.0, 150.0, 150.0],
    image: 'assets/rodeo-whopper-menu.png',
    isFavorite: false,
    isInCart: false,
    categoryId: '2',
  ),
  Products(
    id: 7,
    name: 'Tavuk Burger',
    price: [130.0, 130.0, 130.0],
    image: 'assets/tavukburger-menu.png',
    isFavorite: false,
    isInCart: false,
    categoryId: '2',
  ),

  Products(
    id: 8,
    name: 'Whopper Menu',
    price: [150.0, 150.0, 150.0],
    image: 'assets/whopper-menu.png',
    isFavorite: false,
    isInCart: false,
    categoryId: '2',
  ),
  //Pizzalar
  Products(
    id: 9,
    name: 'Karışık Pizza',
    price: [100.0, 130.0, 160.0],
    image: 'assets/karisik-pizza.jpg',
    isFavorite: false,
    isInCart: false,
    categoryId: '3',
  ),

  Products(
    id: 10,
    name: 'Tavuklu Pizza',
    price: [100.0, 120.0, 140.0],
    image: 'assets/tavuklu-pizzza.jpg',
    isFavorite: false,
    isInCart: false,
    categoryId: '3',
  ),
  Products(
    id: 11,
    name: 'Vejeteryan Pizza',
    price: [90.0, 110.0, 130.0],
    image: 'assets/vejeteryan.jpg',
    isFavorite: false,
    isInCart: false,
    categoryId: '3',
  ),
  //Sushi
  Products(
    id: 12,
    name: 'Chumaki',
    price: [100.0, 100.0, 100.0],
    image: 'assets/chumaki.avif',
    isFavorite: false,
    isInCart: false,
    categoryId: '4',
  ),
  Products(
    id: 13,
    name: 'Uramaki',
    price: [110.0, 110.0, 110.0],
    image: 'assets/uramaki.avif',
    isFavorite: false,
    isInCart: false,
    categoryId: '4',
  ),
  //Burger
  Products(
    id: 14,
    name: 'Nigiri',
    price: [120.0, 120.0, 120.0],
    image: 'assets/nigiri.avif',
    isFavorite: false,
    isInCart: false,
    categoryId: '4',
  ),

  Products(
    id: 15,
    name: 'BBQ',
    price: [400.0, 400.0, 400.0],
    image: 'assets/bbq1.png',
    isFavorite: false,
    isInCart: false,
    categoryId: '5',
  ),
  Products(
    id: 16,
    name: 'Deniz Mahsullu Noodle',
    price: [150.0, 150.0, 150.0],
    image: 'assets/denizmahsullu-noodle.jpg',
    isFavorite: false,
    isInCart: false,
    categoryId: '6',
  ),

  Products(
    id: 17,
    name: 'Sebzeli Noodle',
    price: [110.0, 110.0, 110.0],
    image: 'assets/sebzeli-noodle.jpg',
    isFavorite: false,
    isInCart: false,
    categoryId: '6',
  ),
  Products(
    id: 18,
    name: 'Frambuazlı Cheesecake',
    price: [80.0, 80.0, 80.0],
    image: 'assets/fram-cheesecake.webp',
    isFavorite: false,
    isInCart: false,
    categoryId: '8',
  ),


  Products(
    id: 21,
    name: 'Limonlu Cheesecake',
    price: [80.0, 80.0, 80.0],
    image: 'assets/limonlu-cheesecake.webp',
    isFavorite: false,
    isInCart: false,
    categoryId: '8',
  ),
  Products(
    id: 22,
    name: 'Lotuslu Cheesecake',
    price: [80.0, 80.0, 80.0],
    image: 'assets/lotuslu-cheesecake.webp',
    isFavorite: false,
    isInCart: false,
    categoryId: '8',
  ),

  Products(
    id: 23,
    name: 'Tavuklu Sezar Salata',
    price: [110.0, 110.0, 110.0],
    image: 'assets/tavuklu-sezar-salata.webp',
    isFavorite: false,
    isInCart: false,
    categoryId: '7',
  ),
  Products(
    id: 24,
    name: 'Ton Balıklı Salata',
    price: [120.0, 120.0, 120.0],
    image: 'assets/tonbalikli-salata.jpg',
    isFavorite: false,
    isInCart: false,
    categoryId: '7',
  ),


];

List<Products> getProductsByCategoryId(String categoryId) {
  return productsDatabase.where((product) => product.categoryId == categoryId).toList();
}

Products getProductById(int id) {
  try {
    return productsDatabase.firstWhere((product) => product.id == id);
  } catch (e) {
    // Handle the case when the product with the specified id is not found
    throw Exception("Product with ID $id not found");
  }
}
void showImagesOfProductsByCategoryId(String categoryId) {
  List<Products> products = getProductsByCategoryId(categoryId);

  for (var product in products) {
    print(product.image);
    // Display or use the image here as needed
  }
}
