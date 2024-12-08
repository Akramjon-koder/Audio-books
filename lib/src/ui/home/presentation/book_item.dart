import 'dart:io';

import 'package:audiobook/src/extensions/size_extensions.dart';
import 'package:audiobook/src/theme/apptheme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../home.dart';

class BookItem extends StatelessWidget {
  final BookModel data;
  final Function() tapCallBack;
  const BookItem({
    super.key,
    required this.data,
    required this.tapCallBack,
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
            child: Stack(
              children: [
                data.isLoaded ? Image.file(
                  File(data.image.toString()),
                  width: 300.w,
                  height: 500.w,
                  fit: BoxFit.cover,
                ) : CachedNetworkImage(
                  imageUrl: data.image,
                  width: 300.w,
                  height: 500.w,
                  fit: BoxFit.cover,
                ),
                if(data.progressNotifier != null)
                  Positioned(
                    top: 10.a,
                    right: 10.a,
                    child: ValueListenableBuilder(
                      valueListenable: data.progressNotifier!,
                      builder: (context, value, child){
                        if(value == 1){
                          return const SizedBox();
                        }

                        if(value != null && value < 0){
                          return GestureDetector(
                            onTap: () => context.read<BooksBloc>().add(DownloadTapEvent(data)),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: 3.a.circular,
                                color: theme.cardBackground.withOpacity(0.3),
                              ),
                              child: Padding(
                                padding: 5.a.all,
                                child: FaIcon(
                                  FontAwesomeIcons.download,
                                  color: theme.yellow,
                                ),
                              ),
                            ),
                          );
                        }
                        return SizedBox(
                          width: 40.a,
                          height: 40.a,
                          child: CircularProgressIndicator(
                            value: value,
                            color: theme.mainBlue,
                          ),
                        );
                      },
                    ),
                  ),
              ],
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
