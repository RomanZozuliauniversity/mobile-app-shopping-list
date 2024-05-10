import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/components/buttons/custom_elevated_button.dart';
import 'package:mobile_app/components/inputs/custom_text_field.dart';
import 'package:mobile_app/models/product/product.dart';
import 'package:mobile_app/providers/products/interface/i_products_provider.dart';
import 'package:mobile_app/views/product/controller/product_controller.dart';

class ProductForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final ProductController controller;
  final IProductsProvider provider;

  const ProductForm({
    required this.formKey,
    required this.controller,
    required this.provider,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: controller.isEditingMode || controller.product is! Product,
            child: Text(
              controller.isEditingMode ? 'Editing product' : 'Creating product',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
              ),
            ),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: controller.imageUrlController,
            validator: controller.validateImageUrl,
            label: 'Image url',
            hint: 'Enter image url or left it empty for random image',
            readOnly:
                controller.product is Product && !controller.isEditingMode,
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: controller.titleController,
            validator: controller.validateTitle,
            textCapitalization: TextCapitalization.sentences,
            label: 'Title',
            hint: 'Enter product title',
            readOnly:
                controller.product is Product && !controller.isEditingMode,
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: controller.descriptionController,
            validator: controller.validateDescription,
            textCapitalization: TextCapitalization.sentences,
            minLines: 3,
            maxLines: 5,
            readOnly:
                controller.product is Product && !controller.isEditingMode,
            label: 'Description',
            hint: 'Enter product description',
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: controller.priceController,
            validator: controller.validatePrice,
            label: 'Price',
            hint: 'Product price',
            keyboardType: TextInputType.number,
            readOnly:
                controller.product is Product && !controller.isEditingMode,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          const SizedBox(height: 20),
          Visibility(
            visible: controller.isEditingMode || controller.product is! Product,
            child: CustomElevatedButton(
              label: 'Save',
              onPressed: () => controller.onSaveTap(
                formKey: formKey,
                context: context,
                provider: provider,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Visibility(
            visible: controller.product is Product,
            child: TextButton(
              onPressed: () => controller.onDeleteTap(
                context: context,
                provider: provider,
              ),
              child: Text('Delete product', style: TextStyle(fontSize: 14.sp)),
            ),
          ),
        ],
      ),
    );
  }
}
