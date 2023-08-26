
import 'package:flutter/material.dart';

import '../../../utils/sizer_custom/sizer.dart';

class ItemsWidget extends StatelessWidget {
  final String txt;
  final String account;
  const ItemsWidget({
    Key? key,
    required this.txt,
    required this.account,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    txt,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    account,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height10),
      ],
    );
  }
}
