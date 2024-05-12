import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app/models/cart/cart.dart';
import 'package:mobile_app/models/cart/cart_item.dart';
import 'package:mobile_app/models/product/product.dart';
import 'package:mobile_app/repositories/cart/interface/i_cart_repo.dart';
import 'package:uuid/uuid.dart';

class FirebaseCartRepo implements ICartRepo {
  const FirebaseCartRepo();

  @override
  Future<void> addCartItem({
    required String uuid,
    required Product product,
  }) async {
    final collection =
        FirebaseFirestore.instance.collection('cart').withConverter(
              fromFirestore: (snapshot, options) =>
                  Cart.fromJson(snapshot.data() ?? {}),
              toFirestore: (value, options) => value.toJson(),
            );

    final doc = collection.doc(uuid);
    final cartSnapshot = await doc.get();

    final cart = cartSnapshot.data() ?? Cart(uuid: uuid, items: []);

    final index = cart.items.indexWhere((e) => e.product.uid == product.uid);
    if (index >= 0) {
      cart.items[index].count++;
    } else {
      cart.items.add(
        CartItem(uid: const Uuid().v4(), count: 1, product: product),
      );
    }

    await doc.set(cart);
  }

  @override
  Future<void> clearCart({required String uuid}) async {
    final collection =
        FirebaseFirestore.instance.collection('cart').withConverter(
              fromFirestore: (snapshot, options) =>
                  Cart.fromJson(snapshot.data() ?? {}),
              toFirestore: (value, options) => value.toJson(),
            );

    await collection.doc(uuid).delete();
  }

  @override
  Future<List<CartItem>> fetchCartItems({required String uuid}) async {
    final collection =
        FirebaseFirestore.instance.collection('cart').withConverter(
              fromFirestore: (snapshot, options) =>
                  Cart.fromJson(snapshot.data() ?? {}),
              toFirestore: (value, options) => value.toJson(),
            );

    final cartSnapshot = await collection.doc(uuid).get();
    return cartSnapshot.data()?.items ?? [];
  }

  @override
  Future<void> removeCartItem({
    required String uuid,
    required CartItem item,
  }) async {
    final collection =
        FirebaseFirestore.instance.collection('cart').withConverter(
              fromFirestore: (snapshot, options) =>
                  Cart.fromJson(snapshot.data() ?? {}),
              toFirestore: (value, options) => value.toJson(),
            );

    final doc = collection.doc(uuid);
    final cartSnapshot = await doc.get();
    final cart = cartSnapshot.data();

    if (cart is! Cart) return;

    cart.items.removeWhere((e) => e.uid == item.uid);

    await doc.update(cart.toJson());
  }

  @override
  Future<void> updateCartItem({
    required String uuid,
    required CartItem item,
  }) async {
    final collection =
        FirebaseFirestore.instance.collection('cart').withConverter(
              fromFirestore: (snapshot, options) =>
                  Cart.fromJson(snapshot.data() ?? {}),
              toFirestore: (value, options) => value.toJson(),
            );

    final doc = collection.doc(uuid);
    final cartSnapshot = await doc.get();
    final cart = cartSnapshot.data();

    if (cart is! Cart) return;

    final index = cart.items.indexWhere((e) => e.uid == item.uid);

    if (index < 0) return;

    cart.items[index] = item;

    await doc.update(cart.toJson());
  }
}
