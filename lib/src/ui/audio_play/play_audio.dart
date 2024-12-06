import 'package:audiobook/src/extensions/size_extensions.dart';
import 'package:audiobook/src/ui/home/home.dart';
import 'package:audiobook/src/ui/widgets/screen_widget.dart';
import 'package:flutter/material.dart';

class AudioPage extends StatelessWidget {
  final AudioModel data;
  const AudioPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: 'Audio',

      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.network(
                width: 500.w,
                height: 600.w,
                data.image,
                fit: BoxFit.cover,
              ),
            ),
          ),


        ],
      ),
    );
  }
}
