import 'package:audiobook/src/extensions/size_extensions.dart';
import 'package:audiobook/src/theme/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home.dart';

class BookItem extends StatelessWidget {
  final LoadListner? loadController;
  final BookModel data;
  final Function() tapCallBack;
  const BookItem({
    super.key,
    required this.data,
    required this.tapCallBack,
    this.loadController,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapCallBack,
      child: Column(
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
      ),
    );
  }
}
