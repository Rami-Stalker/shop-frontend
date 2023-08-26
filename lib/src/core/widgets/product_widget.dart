import 'package:flutter/material.dart';

import '../../models/product_model.dart';
import '../../utils/sizer_custom/sizer.dart';

import '../../themes/app_colors.dart';
import '../../themes/app_decorations.dart';
import 'icon_text_widget.dart';

class ProductWidget extends StatelessWidget {
  final VoidCallback onTap;
  final ProductModel product;
  final int index;
  const ProductWidget({
    Key? key,
    required this.onTap,
    required this.product,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    double avgRating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }
    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Dimensions.width10,
          vertical: 3.sp,
        ),
        child: Row(
          children: [
            Container(
              width: 100.sp,
              height: 100.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  Dimensions.radius15,
                ),
                color: index.isEven
                    ? const Color(0xFF69c5df)
                    : const Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    product.images[0],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.height10,
                ),
                decoration: AppDecoration.product(
                  context,
                  Dimensions.radius15,
                ).decoration,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.sp,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            product.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Spacer(),
                          avgRating != 0.0
                              ? Container(
                                  padding: EdgeInsets.all(
                                    5.sp,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colorStar,
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.radius15,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: colorBlack,
                                        size: 20,
                                      ),
                                      Text(
                                        avgRating.toString(),
                                        style: TextStyle(
                                          color: colorBlack,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      Text(
                        product.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconAndTextWidget(
                            icon: Icons.circle_sharp,
                            text: 'Normal',
                            iconColor: colorMedium,
                          ),
                          IconAndTextWidget(
                            icon: Icons.location_on,
                            text: '1.7KM',
                            iconColor: colorPrimary,
                          ),
                          IconAndTextWidget(
                            icon: Icons.access_time_rounded,
                            text: '23min',
                            iconColor: colorHigh,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
