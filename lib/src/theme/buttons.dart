import 'package:audiobook/src/extensions/size_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'apptheme.dart';

class Btn extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final bool isLoading;
  const Btn({
    super.key,
    this.onTap,
    required this.title,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.a,
        vertical: 8.a,
      ),
      decoration: BoxDecoration(
        borderRadius: 9.a.circular,
        color: theme.mainBlue,
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if(isLoading)
            Padding(
              padding: 8.a.right,
              child: const CupertinoActivityIndicator(
                color: Colors.white,
              ),
            ),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 15.a,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      )
    ),
  );
}
