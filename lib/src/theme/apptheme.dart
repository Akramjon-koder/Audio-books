import 'package:audiobook/src/extensions/size_extensions.dart';
import 'package:flutter/cupertino.dart';

import '../variables/util_variables.dart';

_ThemeApp? _appTheme;
_ThemeApp get theme {
  _appTheme ??= _ThemeApp();
  return _appTheme!;
}

void updateTheme() {
  _appTheme = _ThemeApp();
}

class _ThemeApp {
  Color background = isDark ? const Color(0xFF212121) : const Color(0xFFFFFFFF);
  Color text = isDark ? const Color(0xFFFFFFFF) : const Color(0xFF212121);
  Color secondary = isDark ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
  Color mapbg = isDark ? const Color(0xFF242f3e) : const Color(0xFFF7F8F9);
  Color grey = isDark ? const Color(0xFFABA5B0) : const Color(0xFF808080);
  Color numBackground =
      isDark ? const Color(0xFF29232E) : const Color(0xFFF9F9F9);
  Color dragDown = isDark ? const Color(0xF0444444) : const Color(0xFFF8F9F8);
  Color line = isDark ? const Color(0xFF655F6A) : const Color(0xFFE6E6E6);
  Color cardBackground =
      isDark ? const Color(0xFF332D38) : const Color(0xFFFFFFFF);
  Color card = isDark ? const Color(0xFF3D3742) : const Color(0xFFFFFFFF);
  Color yellow = isDark ? const Color(0xFFFFB200) : const Color(0xFFFDDB00);
  Color greyBG = isDark ? const Color(0xFF35383F) : const Color(0xFFF8F8FA);

  Color green = const Color(0xFF5CB800);
  Color orange = const Color(0xFFFFA800);
  Color greyYellow = const Color(0xFFC18905);
  Color mainBlue = const Color(0xFF1996F0);
  Color blue = const Color(0xFF06B6D4);
  Color lightRed = const Color(0xFFFF7272);
  Color red = const Color(0xFFF75555);
  Color container = const Color(0xFF303130);

  String fontFamily = "proximanova";

  TextStyle textStyle = TextStyle(
    color: isDark ? const Color(0xFFFFFFFF) : const Color(0xFF000000),
    fontFamily: "proximanova",
    decoration: TextDecoration.none,
    fontWeight: FontWeight.w400,
    overflow: TextOverflow.ellipsis,
  );

  ColorFilter colorFilter = ColorFilter.mode(
    isDark ? const Color(0xFFFFFFFF) : const Color(0xFF000000),
    BlendMode.srcIn,
  );

  ColorFilter greyFilter = ColorFilter.mode(
    isDark ? const Color(0xFFABA5B0) : const Color(0xFF7D7B77),
    BlendMode.srcIn,
  );

  BoxDecoration cardDecor = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: isDark ? const Color(0xFF655F6A) : const Color(0xFFFFFFFF),
      width: 1,
    ),
    color: isDark ? const Color(0xFF332D38) : const Color(0xFFFFFFFF),
  );

  BoxDecoration setDecor = BoxDecoration(
    borderRadius: BorderRadius.circular(8.a),
    border: Border.all(
      width: 1.a,
      color: isDark ? const Color(0xFF655F6A) : const Color(0xFFE6E6E6),
    ),
    color: isDark ? const Color(0xFF332D38) : const Color(0xFFFFFFFF),
  );

  BoxDecoration greyDecor = BoxDecoration(
    color: isDark ? const Color(0xFF35383F) : const Color(0xFFF8F8FA),
    border: Border.all(
      width: 1.a,
      color: isDark ? const Color(0xFF655F6A) : const Color(0xFFE6E6E6),
    ),
    borderRadius: 12.a.circular,
  );

}
