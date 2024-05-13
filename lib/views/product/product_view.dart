import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_app/models/product/product.dart';
import 'package:mobile_app/views/product/controller/product_controller.dart';
import 'package:mobile_app/views/product/widgets/product_form.dart';

class ProductView extends StatelessWidget {
  static const routeName = '/product';

  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      init: ProductController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Product'),
            actions: [
              Visibility(
                visible: controller.product is Product,
                child: IconButton(
                  tooltip: 'Edit',
                  onPressed: controller.onEnterEditingMode,
                  icon: const Icon(CupertinoIcons.pencil_ellipsis_rectangle),
                ),
              ),
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              child: ProductForm(controller: controller),
            ),
          ),
        );
      },
    );
  }
}
