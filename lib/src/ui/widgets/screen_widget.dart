import 'package:audiobook/src/theme/apptheme.dart';
import 'package:flutter/material.dart';

import 'app_bar.dart';

class Screen extends StatelessWidget {
  final Widget? child;
  final Widget? backWidget;
  final List<Widget>? tools;
  final Function? onBack;
  final String title;
  const Screen({
    super.key,
    this.child,
    this.backWidget,
    this.tools,
    this.onBack,
    this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.background,
      // appBar: AppBar(
      //   toolbarHeight: 0,
      //   systemOverlayStyle: SystemUiOverlayStyle(
      //     statusBarBrightness: Brightness.light,
      //     statusBarIconBrightness: Brightness.dark,
      //     statusBarColor: theme.blue.withOpacity(0.75),
      //   ),
      // ),
      body: Column(
        children: [
          BackAppbar(
            backWidget: backWidget,
            title: title,
            onBack: onBack,
            tools: tools,
          ),
          Expanded(child: child ?? const SizedBox()),
        ],
      ),
    );
  }
}
