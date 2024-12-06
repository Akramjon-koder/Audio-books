
import 'package:audiobook/src/extensions/size_extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../theme/apptheme.dart';

class BackAppbar extends StatelessWidget {
  final Widget? backWidget;
  final List<Widget>? tools;
  final Function? onBack;
  final String title;
  const BackAppbar({
    super.key,
    this.backWidget,
    this.tools,
    this.onBack,
    this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60.a,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(
          bottom: 7.a,
          left: 5.a,
          right: 5.a,
        ),
        decoration: BoxDecoration(
          color: theme.blue,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20.a),
            bottomLeft: Radius.circular(20.a),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (onBack != null) {
                    onBack!();
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: backWidget ??
                      Container(
                        width: 32.a,
                        height: 32.a,
                        margin: EdgeInsets.only(
                          left: 10.a,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.a),
                            color: Colors.white.withOpacity(0.2)),
                        child: FaIcon(
                          FontAwesomeIcons.arrowLeft,
                          color: Colors.white,
                          size: 24.a,
                        ),
                      ),
                ),
              ),
            ),
            Text(
              title,
              style: theme.textStyle.copyWith(
                fontSize: 20.a,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: tools ?? [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
