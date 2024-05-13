import 'dart:convert';

import 'package:mobile_app/models/product/product.dart';
import 'package:mobile_app/repositories/products/interface/i_products_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _productsKey = 'products';

class LocalProductsRepo implements IProductsRepo {
  const LocalProductsRepo();

  @override
  Future<void> addProduct({required Product product}) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    var productsJson = sharedPreferences.getStringList(_productsKey) ?? [];
    final products = productsJson
        .map((e) => Product.fromJson(jsonDecode(e) as Map<String, dynamic>))
        .toList();

    if (products.indexWhere((e) => e.uid == product.uid) < 0) {
      products.add(product);
    }

    productsJson = products.map((e) => jsonEncode(e.toJson())).toList();
    sharedPreferences.setStringList(_productsKey, productsJson);
  }

  @override
  Future<List<Product>> fetchProducts() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    final productsJson = sharedPreferences.getStringList(_productsKey) ?? [];
    final products = productsJson
        .map((e) => Product.fromJson(jsonDecode(e) as Map<String, dynamic>))
        .toList();

    return products;
  }

  @override
  Future<void> removeProduct({required Product product}) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    var productsJson = sharedPreferences.getStringList(_productsKey) ?? [];
    final products = productsJson
        .map((e) => Product.fromJson(jsonDecode(e) as Map<String, dynamic>))
        .toList();

    products.removeWhere((e) => e.uid == product.uid);
    productsJson = products.map((e) => jsonEncode(e.toJson())).toList();

    await sharedPreferences.setStringList(_productsKey, productsJson);
  }

  @override
  Future<void> updateProduct({required Product product}) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    var productsJson = sharedPreferences.getStringList(_productsKey) ?? [];
    final products = productsJson
        .map((e) => Product.fromJson(jsonDecode(e) as Map<String, dynamic>))
        .toList();

    final index = products.indexWhere((e) => e.uid == product.uid);

    if (index < 0) return;

    products[index] = product;

    productsJson = products.map((e) => jsonEncode(e.toJson())).toList();

    await sharedPreferences.setStringList(_productsKey, productsJson);
  }
}
