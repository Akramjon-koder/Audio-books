
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';

double _h = 1;
double _w = 1;
double _ar = 1;
double _ge = 1;

void setSizeExt(Size size){
  _h = size.height / 600;
  _w = size.width / 600;
  _ar = (_h + _w) / 2;
  _ar = sqrt(_h * _w);
}

extension ExtSize on num {
  double get h => this * _h;

  double get w => this * _w;

  double get a => this * _ar;

  double get g => this * _ge;

  double get min => this * (_h > _w ? _w : _h);

  double get max => this * (_h > _w ? _h : _w);
}

extension ExtUI on double {

  ///Sizedbox
  SizedBox get size => SizedBox(
    width: this,
    height: this,
  );

  SizedBox get width => SizedBox(width: this);

  SizedBox get height => SizedBox(height: this);

  ///Edge
  EdgeInsets get left => EdgeInsets.only(left: this);

  EdgeInsets get right => EdgeInsets.only(right: this);

  EdgeInsets get top => EdgeInsets.only(top: this);

  EdgeInsets get bottom => EdgeInsets.only(bottom: this);

  EdgeInsets get topLeft => EdgeInsets.only(
    top: this,
    left: this,
  );

  EdgeInsets get topRight => EdgeInsets.only(
    top: this,
    right: this,
  );

  EdgeInsets get bottomLeft => EdgeInsets.only(
    bottom: this,
    left: this,
  );

  EdgeInsets get bottomRight => EdgeInsets.only(
    bottom: this,
    right: this,
  );

  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: this);

  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: this);

  EdgeInsets get topLeftBottom => EdgeInsets.only(
    top: this,
    left: this,
    bottom: this,
  );

  EdgeInsets get leftTopRight => EdgeInsets.only(
    left: this,
    top: this,
    right: this,
  );

  EdgeInsets get bottomLeftTop => EdgeInsets.only(
    bottom: this,
    left: this,
    top: this,
  );

  EdgeInsets get rightBottomLeft => EdgeInsets.only(
    right: this,
    bottom: this,
    left: this,
  );

  EdgeInsets get all => EdgeInsets.all(this);

  ///radius
  BorderRadius get rTopLeft => BorderRadius.only(
    topLeft: Radius.circular(this),
  );

  BorderRadius get rTopRight => BorderRadius.only(
    topRight: Radius.circular(this),
  );

  BorderRadius get rBottomLeft => BorderRadius.only(
    bottomLeft: Radius.circular(this),
  );

  BorderRadius get rBottomRight => BorderRadius.only(
    bottomRight: Radius.circular(this),
  );

  BorderRadius get circular => BorderRadius.circular(this);

  Radius get circularRadius => Radius.circular(this);

}
