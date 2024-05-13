import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mobile_app/models/product/product.dart';
import 'package:mobile_app/providers/products/interface/i_products_provider.dart';
import 'package:uuid/uuid.dart';

class ProductController extends GetxController {
  final _productsProvider =
      Get.find<IProductsProvider>(tag: 'products-provider');

  final _formKey = GlobalKey<FormState>();
  final _isEditingMode = false.obs;

  final imageUrlController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  Product? product;
  VoidCallback? callback;

  GlobalKey<FormState> get formKey => _formKey;
  RxBool get isEditingMode => _isEditingMode;

  @override
  Future<void> onInit() async {
    final arguments = Get.arguments;

    if (arguments == null) return;
    if (arguments is! Map<String, dynamic>) return;

    product = arguments['product'] as Product?;
    callback = arguments['callback'] as VoidCallback;

    if (product is! Product) return;

    imageUrlController.text = product?.imageUrl ?? '';
    titleController.text = product?.title ?? '';
    descriptionController.text = product?.description ?? '';
    priceController.text = product?.price.toStringAsFixed(1) ?? '';

    super.onInit();
  }

  @override
  void onClose() {
    imageUrlController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();

    super.onClose();
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
    _isEditingMode.value = !isEditingMode.value;
  }

  void onSaveTap() async {
    void onSaveFinished() {
      Fluttertoast.showToast(msg: 'Product saved');

      if (callback is VoidCallback) callback!();

      Get.back<void>();
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

    await _productsProvider.addProduct(product: createProduct());
    onSaveFinished();
  }

  void onDeleteTap() async {
    if (product is! Product) return;

    await _productsProvider.removeProduct(product: product!);

    Fluttertoast.showToast(msg: 'Product deleted');

    if (callback is VoidCallback) callback!();

    Get.back<void>();
  }
}
