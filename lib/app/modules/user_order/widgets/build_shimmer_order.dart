import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/dimensions.dart';

class BuildShimmerOrder extends StatelessWidget {
  const BuildShimmerOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 20.0,
                  color: Colors.white,
                ),
                SizedBox(height: Dimensions.height10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: Dimensions.height20 * 4,
                          width: Dimensions.height20 * 4,
                          margin:
                              EdgeInsets.only(right: Dimensions.width10 / 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.radius15 / 2),
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          height: Dimensions.height20 * 4,
                          width: Dimensions.height20 * 4,
                          margin:
                              EdgeInsets.only(right: Dimensions.width10 / 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.radius15 / 2),
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          height: Dimensions.height20 * 4,
                          width: Dimensions.height20 * 4,
                          margin:
                              EdgeInsets.only(right: Dimensions.width10 / 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.radius15 / 2),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height20 * 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 60,
                            height: 20.0,
                            color: Colors.white,
                          ),
                          SizedBox(height: Dimensions.height10),
                          Container(
                            width: 40,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radius15 / 3),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}