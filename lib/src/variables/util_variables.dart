import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

bool isDark = true; // app theme is dark this value = true else value = false

String lan = 'uz';

abstract class DataKeys{
  static const String dark = 'dark_mode';
  static const String language = 'app_language';
  static const String downloadedBooks = 'downloaded_books';
  static const String lastPlayedBookId = 'last_played_book_id';
  static const String lastPlayedBookPosition = 'last_played_book_position';
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

const cycleModes = [
  LoopMode.off,
  LoopMode.all,
  LoopMode.one,
];