import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app/models/product/product.dart';
import 'package:mobile_app/repositories/products/interface/i_products_repo.dart';

class FirebaseProductsRepo implements IProductsRepo {
  const FirebaseProductsRepo();

  @override
  Future<void> addProduct({required Product product}) async {
    final collection =
        FirebaseFirestore.instance.collection('products').withConverter(
              fromFirestore: (snapshot, options) =>
                  Product.fromJson(snapshot.data() ?? {}),
              toFirestore: (value, options) => value.toJson(),
            );

    await collection.doc(product.uid).set(product);
  }

  @override
  Future<List<Product>> fetchProducts() async {
    final collection =
        FirebaseFirestore.instance.collection('products').withConverter(
              fromFirestore: (snapshot, options) =>
                  Product.fromJson(snapshot.data() ?? {}),
              toFirestore: (value, options) => value.toJson(),
            );

    final productsSnapshot = await collection.get();
    return productsSnapshot.docs.map((e) => e.data()).toList();
  }

  @override
  Future<void> removeProduct({required Product product}) async {
    final collection =
        FirebaseFirestore.instance.collection('products').withConverter(
              fromFirestore: (snapshot, options) =>
                  Product.fromJson(snapshot.data() ?? {}),
              toFirestore: (value, options) => value.toJson(),
            );

    await collection.doc(product.uid).delete();
  }

  @override
  Future<void> updateProduct({required Product product}) async {
    final collection =
        FirebaseFirestore.instance.collection('products').withConverter(
              fromFirestore: (snapshot, options) =>
                  Product.fromJson(snapshot.data() ?? {}),
              toFirestore: (value, options) => value.toJson(),
            );

    collection.doc(product.uid).update(product.toJson());
  }
}
