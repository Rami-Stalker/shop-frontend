import 'package:get/get.dart';
import 'package:shop_app/src/modules/admin/controllers/admin_controller.dart';
import 'package:shop_app/src/modules/admin/widgets/admin_categories.dart';
import 'package:shop_app/src/routes/app_pages.dart';
import 'package:shop_app/src/themes/app_decorations.dart';

import '../../../controller/user_controller.dart';
import '../../../core/widgets/big_text.dart';
import '../../../core/widgets/icon_text_widget.dart';
import '../../../core/widgets/no_data_page.dart';
import '../../../core/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../../../models/product_model.dart';
import '../../../public/constants.dart';
import '../../../services/socket/socket_io_service.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/sizer_custom/sizer.dart';
import '../widgets/build_shimmer_products.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ProductsView extends StatefulWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  late IO.Socket _socket;
  void navigateToAddProduct() {
    Get.toNamed(Routes.ADMIN_ADD_PRODUCT);
  }

  void navigateToSearchView() {
    Get.toNamed(Routes.SEARCH);
  }

  _connectSocket() {
    _socket.connect();
    _socket.onConnect((data) => print('Connection established'));
    _socket.onConnectError((data) => print('Connect Error: $data'));
    _socket.onDisconnect((data) => print('Socket.IO server disconnected'));
    _socket.on('message', (data) {
      print('message');
    });
  }

  @override
  void initState() {
    super.initState();
    //Important: If your server is running on localhost and you are testing your app on Android then replace http://localhost:3000 with http://10.0.2.2:3000
    // _socket = IO.io(
    //   'http://192.168.1.110:3000',
    //   IO.OptionBuilder().setTransports(['websocket']).build(),
    // );
    // _connectSocket();
    connectAndListen();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: GetBuilder<AdminController>(builder: (adminC) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: Dimensions.height45,
                bottom: Dimensions.height15,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ramy App',
                    style: TextStyle(
                      color: colorPrimary,
                      fontSize: Dimensions.font20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  GestureDetector(
                    onTap: navigateToSearchView,
                    child: Center(
                      child: Container(
                        width: Dimensions.height45,
                        height: Dimensions.height45,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                          color: colorPrimary,
                        ),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: Dimensions.iconSize24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const AdminCategories(),
            SizedBox(
              height: Dimensions.height15,
            ),
            FutureBuilder<List<ProductModel>>(
                future: Get.find<AdminController>().fetchAllProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data?.length ?? 0,
                              itemBuilder: (context, index) {
                                var product = snapshot.data![index];
                                double totalRating = 0;
                                double avgRating = 0;
                                for (int i = 0;
                                    i < product.rating!.length;
                                    i++) {
                                  totalRating += product.rating![i].rating;
                                }
                                if (totalRating != 0) {
                                  avgRating =
                                      totalRating / product.rating!.length;
                                }
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                      Routes.EDIT_PRODUCT,
                                      arguments: {
                                        'product': product,
                                      },
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: Dimensions.width20,
                                      right: Dimensions.width20,
                                      bottom: Dimensions.height10,
                                    ),
                                    child: Row(
                                      children: [
                                        //image section
                                        Container(
                                          width: Dimensions.listViewImgSize,
                                          height: Dimensions.listViewImgSize,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              Dimensions.radius20,
                                            ),
                                            color: Colors.white38,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                product.images[0],
                                              ),
                                            ),
                                          ),
                                        ),
                                        //text container
                                        Expanded(
                                          child: Container(
                                            decoration: AppDecoration.product(
                                              context,
                                              Dimensions.radius15,
                                            ).decoration,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: Dimensions.width10,
                                                right: Dimensions.width10,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      BigText(
                                                        text: product.name,
                                                      ),
                                                      avgRating != 0.0
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                  Dimensions
                                                                      .width10,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      colorStar,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          Dimensions
                                                                              .radius15),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      blurRadius:
                                                                          1,
                                                                      offset:
                                                                          const Offset(
                                                                        0,
                                                                        2,
                                                                      ),
                                                                      color:
                                                                          mCM,
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .black,
                                                                      size: 20,
                                                                    ),
                                                                    Text(
                                                                      avgRating
                                                                          .toString(),
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : Container(),
                                                    ],
                                                  ),
                                                  avgRating == 0.0
                                                      ? SizedBox(
                                                          height: Dimensions
                                                              .height10,
                                                        )
                                                      : Container(),
                                                  SmallText(
                                                    maxline: 1,
                                                    color: Colors.grey[600],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    text: product.description,
                                                  ),
                                                  SizedBox(
                                                    height: Dimensions.height10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      IconAndTextWidget(
                                                        icon:
                                                            Icons.circle_sharp,
                                                        text: 'Normal',
                                                        iconColor: colorMedium,
                                                      ),
                                                      IconAndTextWidget(
                                                        icon: Icons.location_on,
                                                        text: '1.7KM',
                                                        iconColor: colorPrimary,
                                                      ),
                                                      IconAndTextWidget(
                                                        icon: Icons
                                                            .access_time_rounded,
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
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.none) {
                    return const Expanded(
                      child: NoDataPage(
                        text: "Not found products yet",
                        imgPath: Constants.EMPTY_ASSET,
                      ),
                    );
                  }
                  return BuildShimmerProducts();
                }),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddProduct,
        tooltip: 'Add a Product',
        backgroundColor: colorPrimary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
