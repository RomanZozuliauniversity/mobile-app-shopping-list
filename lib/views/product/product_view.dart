import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/models/product/product.dart';
import 'package:mobile_app/providers/products/interface/i_products_provider.dart';
import 'package:mobile_app/providers/products/src/products_provider.dart';
import 'package:mobile_app/views/product/controller/product_controller.dart';
import 'package:mobile_app/views/product/widgets/product_form.dart';

class ProductView extends StatefulWidget {
  static const routeName = '/product';

  final IProductsProvider provider;

  const ProductView({
    this.provider = const ProductsProvider(),
    super.key,
  });

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final _formKey = GlobalKey<FormState>();
  final controller = ProductController();

  @override
  void didChangeDependencies() {
    controller.init(context).then((_) => setState(() {}));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
        actions: [
          Visibility(
            visible: controller.product is Product,
            child: IconButton(
              tooltip: 'Edit',
              onPressed: () => setState(controller.onEnterEditingMode),
              icon: const Icon(CupertinoIcons.pencil_ellipsis_rectangle),
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: ProductForm(
            formKey: _formKey,
            controller: controller,
            provider: widget.provider,
          ),
        ),
      ),
    );
  }
}
