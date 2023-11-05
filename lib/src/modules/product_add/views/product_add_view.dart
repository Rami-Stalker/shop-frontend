import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';
import 'package:shop_app/src/themes/app_colors.dart';
import '../../../core/dialogs/dialog_loading.dart';
import '../controllers/product_add_controller.dart';
import '../../../utils/sizer_custom/sizer.dart';

import '../../../public/components.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/custom_button.dart';
import 'package:get/get.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../core/picker/picker.dart';

class ProductAddView extends StatefulWidget {
  const ProductAddView({Key? key}) : super(key: key);

  @override
  State<ProductAddView> createState() => _ProductAddViewState();
}

class _ProductAddViewState extends State<ProductAddView> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  String category = 'Drinks';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

  List<String> productCategories = [
    'Drinks',
    'Breakfast',
    'Wraps',
    'Brunch',
    'Burgers',
    'FrenchToast',
    'Sides',
    'ToastedPaninis'
  ];

  void addProduct(ProductAddController addProductController) {
    String productName = _productNameController.text.trim();
    String description = _descriptionController.text.trim();
    String price = _priceController.text.trim();
    String discount = _discountController.text.trim();
    String quantity = _quantityController.text.trim();
    String time = _timeController.text.trim();

    List<File> imageFile = images;

    if (imageFile.isEmpty) {
      Components.showSnackBar(
        'Type in product image',
        title: 'Image',
      );
    } else if (productName.isEmpty) {
      Components.showSnackBar(
        'Type in product name',
        title: 'Name',
      );
    } else if (description.isEmpty) {
      Components.showSnackBar(
        'Type in product description',
        title: 'Description',
      );
    } else if (price.isEmpty) {
      Components.showSnackBar(
        'Type in product price',
        title: 'Price',
      );
    } else if (quantity.isEmpty) {
      Components.showSnackBar(
        'Type in product quantity',
        title: 'Quantity',
      );
    } else {
      addProductController.addProduct(
        name: productName,
        description: description,
        price: int.parse(price),
        discount: int.parse(discount),
        quantity: int.parse(quantity),
        category: category,
        images: images,
        time: time,
      );
      _productNameController.text = '';
      _descriptionController.text = '';
      _priceController.text = '';
      _discountController.text = '';
      _quantityController.text = '';
      _timeController.text = '';
    }
  }

  void selectImages() async {
    var res = await pickImagesFromGallery();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Components.customAppBar(
        context,
        "Add Product",
      ),
      body: GetBuilder<ProductAddController>(builder: (addProductController) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _addProductFormKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.sp),
                  images.isNotEmpty
                      ? CarouselSlider(
                          items: images.map(
                            (i) {
                              return Builder(
                                builder: (BuildContext context) => Image.file(
                                  i,
                                  fit: BoxFit.cover,
                                  height: 200.sp,
                                ),
                              );
                            },
                          ).toList(),
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: 200.sp,
                          ),
                        )
                      : GestureDetector(
                          onTap: selectImages,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(10.sp),
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            child: Container(
                              width: double.infinity,
                              height: 150.sp,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.folder_open,
                                    size: 40.sp,
                                  ),
                                  SizedBox(height: 15.sp),
                                  Text(
                                    'Select Product Images',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  SizedBox(height: 20.sp),
                  AppText('Product Name'),
                  SizedBox(height: 10.sp),
                  AppTextField(
                    textController: _productNameController,
                    hintText: 'Product Name',
                    icon: Icons.person,
                  ),
                  SizedBox(height: 20.sp),
                  AppText('Product Description'),
                  SizedBox(
                    height: 10.sp,
                  ),
                  AppTextField(
                    textController: _descriptionController,
                    hintText: 'Product Description',
                    icon: Icons.description,
                    maxLines: 3,
                  ),
                  SizedBox(height: 20.sp),
                  AppText('Product Price'),
                  SizedBox(height: 10.sp),
                  AppTextField(
                    keyboardType: TextInputType.number,
                    textController: _priceController,
                    hintText: 'Product Price',
                    icon: Icons.money,
                  ),
                  SizedBox(height: 20.sp),
                  AppText('Product Discount'),
                  SizedBox(height: 10.sp),
                  AppTextField(
                    keyboardType: TextInputType.number,
                    textController: _discountController,
                    hintText: 'Product Discount',
                    icon: Icons.money,
                  ),
                  SizedBox(height: 20.sp),
                  AppText('Product Quantity'),
                  SizedBox(
                    height: 10.sp,
                  ),
                  AppTextField(
                    keyboardType: TextInputType.number,
                    textController: _quantityController,
                    hintText: 'Product Quantity',
                    icon: Icons.production_quantity_limits,
                  ),
                  SizedBox(height: 20.sp),
                  AppText('Product Time'),
                  SizedBox(
                    height: 10.sp,
                  ),
                  AppTextField(
                    keyboardType: TextInputType.number,
                    textController: _timeController,
                    hintText: 'Product Time',
                    icon: Icons.access_time_rounded,
                  ),
                  SizedBox(height: 10.sp),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(category),
                        DropdownButton(
                          borderRadius: BorderRadius.circular(
                            10.sp,
                          ),
                          dropdownColor: colorPrimary,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          iconSize: 24.sp,
                          elevation: 4,
                          underline: Container(
                            height: 0,
                          ),
                          // style: subTitleStyle,
                          items: productCategories.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: AppText(item),
                            );
                          }).toList(),
                          onChanged: (String? newVal) {
                            setState(() {
                              category = newVal!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.sp),
                  CustomButton(
                    buttomText: 'Add Meal',
                    onPressed: () {
                      showDialogLoading(context);
                      addProduct(addProductController);
                    },
                  ),
                  SizedBox(height: 10.sp),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
