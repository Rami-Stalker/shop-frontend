import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import '../controllers/add_product_controller.dart';
import '../../../utils/sizer_custom/sizer.dart';

import '../../../public/components.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/big_text.dart';
import '../../../core/widgets/custom_button.dart';
import 'package:get/get.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../core/picker/picker.dart';
import '../../../themes/app_colors.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({Key? key}) : super(key: key);

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  AddProductController addProductController = Get.find<AddProductController>();

  String category = 'Mobiles';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  void addProduct(AddProductController addProductController) {
    String productName = addProductController.productNameC.text.trim();
    String description = addProductController.descriptionC.text.trim();
    String price = addProductController.priceC.text.trim();
    String quantity = addProductController.quantityC.text.trim();
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
        name: addProductController.productNameC.text,
        description: addProductController.descriptionC.text,
        price: int.parse(addProductController.priceC.text),
        quantity: int.parse(addProductController.quantityC.text),
        category: category,
        images: images,
      );
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
      appBar: Components.appAppBar(context, "Add Product"),
      body: GetBuilder<AddProductController>(builder: (addProductController) {
        return Column(
          children: [
            Container(
              color: colorPrimary,
              width: double.maxFinite,
              height: 100.sp,
              padding: EdgeInsets.only(
                top: Dimensions.height45,
                left: Dimensions.width20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    onTap: () => Get.back(),
                    icon: Icons.arrow_back_ios,
                    backgroundColor: colorMedium,
                  ),
                  BigText(text: 'Add Product'),
                  Container(
                    width: Dimensions.height45,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: _addProductFormKey,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: Dimensions.width10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Dimensions.height15),
                        images.isNotEmpty
                            ? CarouselSlider(
                                items: images.map(
                                  (i) {
                                    return Builder(
                                      builder: (BuildContext context) =>
                                          Image.file(
                                        i,
                                        fit: BoxFit.cover,
                                        height: 200,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.folder_open,
                                          size: 40.sp,
                                        ),
                                        SizedBox(height: Dimensions.height15),
                                        Text(
                                          'Select Product Images',
                                          style: TextStyle(
                                            fontSize: Dimensions.font16 - 1,
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(height: Dimensions.height20),
                        BigText(
                          text: 'Product Name',
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        AppTextField(
                          textController: addProductController.productNameC,
                          hintText: 'Product Name',
                          icon: Icons.person,
                        ),
                        SizedBox(height: Dimensions.height20),
                        BigText(
                          text: 'Product Description',
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        AppTextField(
                          textController: addProductController.descriptionC,
                          hintText: 'Product Description',
                          icon: Icons.description,
                          maxLines: 3,
                        ),
                        SizedBox(height: Dimensions.height20),
                        BigText(
                          text: 'Product Price',
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        AppTextField(
                          keyboardType: TextInputType.number,
                          textController: addProductController.priceC,
                          hintText: 'Product Price',
                          icon: Icons.money,
                        ),
                        SizedBox(height: Dimensions.height20),
                        BigText(
                          text: 'Product Quantity',
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        AppTextField(
                          keyboardType: TextInputType.number,
                          textController: addProductController.quantityC,
                          hintText: 'Product Quantity',
                          icon: Icons.production_quantity_limits,
                        ),
                        SizedBox(height: Dimensions.height10),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BigText(text: category),
                              DropdownButton(
                                borderRadius: BorderRadius.circular(
                                  10.sp,
                                ),
                                dropdownColor: Colors.blueGrey,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.grey,
                                ),
                                iconSize: Dimensions.iconSize24,
                                elevation: 4,
                                underline: Container(
                                  height: 0,
                                ),
                                // style: subTitleStyle,
                                items: productCategories.map((String item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
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
                        SizedBox(height: Dimensions.height10),
                        CustomButton(
                          buttomText: 'Add Product',
                          onPressed: () => addProduct(addProductController),
                        ),
                        SizedBox(height: Dimensions.height10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
