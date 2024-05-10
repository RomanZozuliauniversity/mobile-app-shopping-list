import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/models/product/product.dart';
import 'package:mobile_app/providers/products/interface/i_products_provider.dart';
import 'package:uuid/uuid.dart';

class ProductController {
  final imageUrlController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  Product? product;
  VoidCallback? callback;

  bool isEditingMode = false;

  Future<void> init(BuildContext context) async {
    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments == null) return;
    if (arguments is! Map<String, dynamic>) return;

    product = arguments['product'] as Product?;
    callback = arguments['callback'] as VoidCallback;

    if (product is! Product) return;

    imageUrlController.text = product?.imageUrl ?? '';
    titleController.text = product?.title ?? '';
    descriptionController.text = product?.description ?? '';
    priceController.text = product?.price.toStringAsFixed(1) ?? '';
  }

  void dispose() {
    imageUrlController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
  }

  String? validateImageUrl(String? value) {
    if (value is! String || value.isEmpty) return null;

    if (Uri.tryParse(value) is! Uri) {
      return 'Image url should be valid url';
    }

    return null;
  }

  String? validateTitle(String? value) {
    if (value is! String || value.trim().isEmpty) {
      return 'Title is required';
    }

    return null;
  }

  String? validateDescription(String? value) {
    if (value is! String || value.trim().isEmpty) {
      return 'Description is required';
    }

    return null;
  }

  String? validatePrice(String? value) {
    if (value is! String || value.trim().isEmpty) {
      return 'Price is required';
    }

    if (double.tryParse(value) is! double) {
      return 'Price should be valid digit';
    }

    return null;
  }

  void onEnterEditingMode() {
    isEditingMode = !isEditingMode;
  }

  void onSaveTap({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required IProductsProvider provider,
  }) {
    void onSaveFinished() {
      Fluttertoast.showToast(msg: 'Product saved');

      if (callback is VoidCallback) callback!();

      Navigator.of(context).pop();
    }

    Product createProduct() {
      final uid = product?.uid ?? const Uuid().v4();

      if (imageUrlController.text.trim().isEmpty) {
        imageUrlController.text = 'https://picsum.photos/seed/$uid/200/300';
      }

      if (product is Product) {
        return product!.copyWith(
          imageUrl: imageUrlController.text.trim(),
          title: titleController.text.trim(),
          description: descriptionController.text.trim(),
          price: double.tryParse(priceController.text.trim()) ?? 0,
        );
      }

      return Product(
        uid: uid,
        imageUrl: imageUrlController.text.trim(),
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        price: double.tryParse(priceController.text.trim()) ?? 0,
      );
    }

    if (formKey.currentState?.validate() == false) return;

    if (product is Product) {
      provider
          .updateProduct(product: createProduct())
          .then((value) => onSaveFinished());
    } else {
      provider
          .addProduct(product: createProduct())
          .then((value) => onSaveFinished());
    }
  }

  void onDeleteTap({
    required BuildContext context,
    required IProductsProvider provider,
  }) {
    if (product is! Product) return;

    provider.removeProduct(product: product!).then((value) {
      Fluttertoast.showToast(msg: 'Product deleted');

      if (callback is VoidCallback) callback!();

      Navigator.of(context).pop();
    });
  }
}
