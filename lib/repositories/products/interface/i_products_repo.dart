import 'package:mobile_app/models/product/product.dart';

abstract class IProductsRepo {
  Future<List<Product>> fetchProducts();

  Future<void> addProduct({required Product product});
  Future<void> updateProduct({required Product product});
  Future<void> removeProduct({required Product product});
}
