import 'package:mobile_app/models/product/product.dart';
import 'package:mobile_app/providers/products/interface/i_products_provider.dart';
import 'package:mobile_app/repositories/products/interface/i_products_repo.dart';
import 'package:mobile_app/repositories/products/src/firebase_products_repo.dart';
// import 'package:mobile_app/repositories/products/src/local_products_repo.dart';

class ProductsProvider implements IProductsProvider {
  final IProductsRepo _repo;

  const ProductsProvider({
    IProductsRepo repo = const FirebaseProductsRepo(),
  }) : _repo = repo;

  @override
  Future<void> addProduct({required Product product}) =>
      _repo.addProduct(product: product);

  @override
  Future<List<Product>> fetchProducts() => _repo.fetchProducts();

  @override
  Future<void> removeProduct({required Product product}) =>
      _repo.removeProduct(product: product);

  @override
  Future<void> updateProduct({required Product product}) =>
      _repo.updateProduct(product: product);
}
