import 'package:flutter/material.dart';
class SmallText extends StatelessWidget {
  final String text;
  final int? maxline;
  final TextOverflow? overflow;
  final Color? color;
  final double height;
  const SmallText({
    Key? key,
    required this.text,
    this.maxline,
    this.overflow,
    this.color = Colors.grey,
    this.height = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxline,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: color,
        height: height,
      )
    );
  }
}
