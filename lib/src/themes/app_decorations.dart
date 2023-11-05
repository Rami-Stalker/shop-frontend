import 'package:flutter/material.dart';
import 'app_colors.dart';

import '../utils/sizer_custom/sizer.dart';

class AppDecoration {
  final BoxDecoration decoration;
  AppDecoration({required this.decoration});
  factory AppDecoration.appbarIcon(context, radius) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return AppDecoration(
        decoration: BoxDecoration(
          color: colorDarkBranch,
          borderRadius: BorderRadius.circular(radius),
        ),
      );
    } else {
      return AppDecoration(
        decoration: BoxDecoration(
          color: mCL,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: Offset(1, 1),
              color: colorPrimary.withOpacity(0.3),
            ),
          ],
          borderRadius: BorderRadius.circular(radius),
        ),
      );
    }
  }

  factory AppDecoration.product(context, radius) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return AppDecoration(
        decoration: BoxDecoration(
          color: colorDarkBranch,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(radius),
            bottomRight: Radius.circular(radius),
          ),
        ),
      );
    } else {
      return AppDecoration(
        decoration: BoxDecoration(
          color: mCL,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(radius),
            bottomRight: Radius.circular(radius),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: Offset(1, 1),
              color: colorPrimary.withOpacity(0.3),
            ),
          ],
        ),
      );
    }
  }

  factory AppDecoration.productFavoriteCart(context, radius) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return AppDecoration(
        decoration: BoxDecoration(
          color: colorDarkBranch,
          borderRadius: BorderRadius.circular(
            radius,
          ),
        ),
      );
    } else {
      return AppDecoration(
        decoration: BoxDecoration(
          color: mCL,
          borderRadius: BorderRadius.circular(
            radius,
          ),
          boxShadow: [
              BoxShadow(
              blurRadius: 10,
              offset: Offset(1, 1),
              color: colorPrimary.withOpacity(0.3),
            ),
          ],
        ),
      );
    }
  }

  factory AppDecoration.textfeild(
    context,
    radius, {
    bool isLeft = false,
    bool isRight = false,
  }) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return AppDecoration(
        decoration: BoxDecoration(
          color: fCD,
          borderRadius: isLeft == false
              ? isRight == true
                  ? BorderRadius.only(
                      topRight: Radius.circular(radius),
                      bottomRight: Radius.circular(radius),
                    )
                  : BorderRadius.circular(radius)
              : BorderRadius.only(
                  topLeft: Radius.circular(radius),
                  bottomLeft: Radius.circular(radius),
                ),
        ),
      );
    } else {
      return AppDecoration(
        decoration: BoxDecoration(
          color: mCL,
          borderRadius: isLeft == false
              ? isRight == true
                  ? BorderRadius.only(
                      topRight: Radius.circular(radius),
                      bottomRight: Radius.circular(radius),
                    )
                  : BorderRadius.circular(radius)
              : BorderRadius.only(
                  topLeft: Radius.circular(radius),
                  bottomLeft: Radius.circular(radius),
                ),
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              offset: const Offset(0, 2),
              color: mCH,
            ),
          ],
        ),
      );
    }
  }
  
  factory AppDecoration.bottomNavigationBar(context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return AppDecoration(
        decoration: BoxDecoration(
          color: fCD,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45.sp),
            topRight: Radius.circular(45.sp),
          ),
        ),
      );
    } else {
      return AppDecoration(
        decoration: BoxDecoration(
          color: mCD,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45.sp),
            topRight: Radius.circular(45.sp),
          ),
        ),
      );
    }
  }
}
