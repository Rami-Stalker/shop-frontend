import 'package:flutter/material.dart';
class BigText extends StatelessWidget {
  final String text;
  final TextOverflow overflow;
  const BigText({
    Key? key,
    required this.text,
    this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: 1,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
