import 'package:audiobook/src/extensions/size_extensions.dart';
import 'package:audiobook/src/theme/apptheme.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class BookItem extends StatelessWidget {
  final LoadListner? loadController;
  final AudioModel data;
  const BookItem({
    super.key,
    required this.data,
    this.loadController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        15.a.height,
        Expanded(
          child: Image.network(
            data.image,
            fit: BoxFit.cover,
          ),
        ),
        10.a.height,
        Text(
          data.title,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: theme.textStyle.copyWith(
            fontSize: 18.a,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
