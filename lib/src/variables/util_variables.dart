import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

bool isDark = true; // app theme is dark this value = true else value = false

String lan = 'uz';

abstract class DataKeys{
  static const String dark = 'dark_mode';
  static const String language = 'app_language';
}

final ValueNotifier<double> bottom = ValueNotifier(0);

const Map<DioExceptionType,String> exeptionMessages = {
  DioExceptionType.unknown : 'Xatolik yuzberdi',
  DioExceptionType.badResponse : 'Notog\'ri qiymat yuborildi',
  DioExceptionType.cancel : 'Bekor qilindi',
  DioExceptionType.badCertificate : 'Ruxsat etilmagan',
  DioExceptionType.connectionError : 'Mobil internet mavjud emas',
  DioExceptionType.connectionTimeout : 'Server bilan bog\'lanib bo\'lmadi.',
  DioExceptionType.sendTimeout : 'Serverga malumot yuborib bo\'lmadi.',
  DioExceptionType.receiveTimeout : 'Serverdan jabob qaytmadi.'
};