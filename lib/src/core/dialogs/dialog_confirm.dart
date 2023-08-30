import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import '../../themes/app_colors.dart';

class DialogConfirm extends StatefulWidget {
  final String title;
  final String subTitle;
  final Function handleConfirm;
  final double? height;

  const DialogConfirm({
    required this.handleConfirm,
    required this.subTitle,
    required this.title,
    this.height,
  });

  @override
  State<StatefulWidget> createState() => _DialogConfirmState();
}

class _DialogConfirmState extends State<DialogConfirm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.sp,
      height: widget.height ?? 180.sp,
      padding: EdgeInsets.symmetric(vertical: 16.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 6.sp),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            child: Text(
              widget.title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
            ),
          ),
          SizedBox(height: 6.sp),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 7.5.sp),
            child: Text(
              widget.subTitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10.5.sp),
            ),
          ),
          SizedBox(height: 4.sp),
          Divider(),
          GestureDetector(
            onTap: () {
              Get.back();
              widget.handleConfirm();
            },
            child: Container(
              color: Colors.transparent,
              width: 300.sp,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 5.sp),
              child: Text(
                'Đồng ý',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                  color: colorPrimary,
                ),
              ),
            ),
          ),
          Divider(color: Colors.grey),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              color: Colors.transparent,
              width: 300.sp,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 5.sp),
              child: Text(
                'Từ chối',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 10.5.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
