import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/sizer_custom/sizer.dart';

class BuildShimmerProducts extends StatelessWidget {
  const BuildShimmerProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: Expanded(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                margin: EdgeInsets.only(
                  left: Dimensions.width20,
                  bottom: Dimensions.height10,
                ),
                child: Row(
                  children: [
                    Container(
                      width: Dimensions.listViewImgSize,
                      height: Dimensions.listViewImgSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Dimensions.radius20,
                        ),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 90,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(
                                Dimensions.radius20,
                              ),
                              bottomRight: Radius.circular(
                                Dimensions.radius20,
                              ),
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 20.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 70,
                                  height: 20.0,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 70,
                                      height: 20.0,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: 70,
                                      height: 20.0,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: 70,
                                      height: 20.0,
                                      color: Colors.white,
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
          },
        ),
      ),
    );
  }
}
