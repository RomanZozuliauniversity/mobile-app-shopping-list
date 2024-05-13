import 'package:get/get.dart';
import 'package:mobile_app/models/product/product.dart';
import 'package:mobile_app/providers/products/interface/i_products_provider.dart';
import 'package:mobile_app/repositories/products/interface/i_products_repo.dart';
import 'package:mobile_app/repositories/products/src/firebase_products_repo.dart';
import 'package:mobile_app/repositories/products/src/local_products_repo.dart';
import 'package:mobile_app/services/network/interface/i_network_service.dart';

class ProductsProvider implements IProductsProvider {
  final IProductsRepo _repo;
  final IProductsRepo _localRepo = const LocalProductsRepo();

  const ProductsProvider({
    IProductsRepo repo = const FirebaseProductsRepo(),
  }) : _repo = repo;

  @override
  Future<void> addProduct({required Product product}) {
    final networkService = Get.find<INetworkService>(tag: 'network-service');

    if (networkService.isConnected.isTrue) {
      _localRepo.addProduct(product: product);
      return _repo.addProduct(product: product);
    }

    return _localRepo.addProduct(product: product);
  }

  @override
  Future<List<Product>> fetchProducts() async {
    final networkService = Get.find<INetworkService>(tag: 'network-service');

    if (networkService.isConnected.isTrue) {
      final products = await _repo.fetchProducts();

      for (var product in products) {
        _localRepo.addProduct(product: product);
      }

      return products;
    }

    return _localRepo.fetchProducts();
  }

  @override
  Future<void> removeProduct({required Product product}) async {
    final networkService = Get.find<INetworkService>(tag: 'network-service');

    if (networkService.isConnected.isTrue) {
      _localRepo.removeProduct(product: product);
      return _repo.removeProduct(product: product);
    }
  }

  @override
  Future<void> updateProduct({required Product product}) async {
    final networkService = Get.find<INetworkService>(tag: 'network-service');

    if (networkService.isConnected.isTrue) {
      _localRepo.updateProduct(product: product);
      return _repo.updateProduct(product: product);
    }
  }
}
