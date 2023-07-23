import 'package:flutter/material.dart';
import 'package:lap9/View/Order/yemekListesi.dart';
import 'package:lap9/components/appbar.dart';
import '../HomeScreen/database.dart';

class ProductSema extends StatelessWidget {
  final String? categoryId;
  final String? text;

  const ProductSema({Key? key, required this.categoryId, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Products> categoryProducts = getProductsByCategoryId(categoryId ?? "");
    List<Products> filteredProducts = productsDatabase.where((product) => product.categoryId == categoryId).toList();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                appbarr(text: text ?? ""),
                YemekListesi(text:text,categoryId: categoryId ?? "", filteredProducts: filteredProducts, favoriteProducts: [], cartProducts: [], onAddToFavorite: () {  }, onAddToCart: () {  }, onRemoveFromCart: () {  },),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
