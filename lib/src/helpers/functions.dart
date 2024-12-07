
import 'dart:math';

String getDate(DateTime date) {
  String dmy = date.day.toString().padLeft(2, '0');
  dmy += '.${date.month.toString().padLeft(2, '0')}.';
  dmy += date.year.toString();
  return dmy;
}

String getDMY(int day, month, year) {
  String dmy = day.toString().padLeft(2, '0');
  dmy += '.${month.toString().padLeft(2, '0')}.';
  dmy += year.toString();
  return dmy;
}

double timeToHour(String time){
  if(!time.contains(':')){
    return 0;
  }
  final mins = time.split(':');
  if(mins.length == 2){
    return (int.tryParse(mins.first) ?? 0) + (int.tryParse(mins.last) ?? 0) / 60;
  }else{
    return (int.tryParse(mins.first) ?? 0) + (int.tryParse(mins[1]) ?? 0) / 60 + (int.tryParse(mins.last) ?? 0) / 3600;
  }
}

String generateRNums(int length) => List.generate(
    length, (index) => Random().nextInt(10)).join('');

DateTime detTimeDateOfString(String date) {
  final list = date.split('.');
  if (list.length == 3) {
    return DateTime(
      int.parse(list[2]),
      int.parse(list[1]),
      int.parse(list[0]),
    );
  }
  return DateTime(2000);
}

String numberFormat(String numbers) {
  String value = '';
  int index = 0;
  final regexp = RegExp(r'\d');
  numbers.split('').reversed.forEach((element) {
    if (regexp.hasMatch(element)) {
      if (index == 3) {
        value = ' $value';
        index = 0;
      }
      value = '$element$value';
      index++;
    }
  });
  return value;
}

String priceFormat(int price) => '${numberFormat(price.toString())} so\'m';

String cut60(String txt) {
  if (txt.length > 60) {
    int size = 0;
    for (final word in txt.split(' ')) {
      size += word.length + 1;
      if (size > 59) {
        return '${txt.substring(0, size)}...';
      }
    }
  }
  return txt;
}

String setphoneNumberFormat(String numbers) {
  String result = '';
  int i = 0;
  numbers.split('').forEach((element) {
    if (i == 0) {
      result += '+';
    } else if (i == 3 || i == 5 || i == 8 || i == 10) {
      result += ' ';
    }
    result += element;
    i++;
  });
  return result;
}

String numToClock(int seconds) {
  return '${_counterFormat(seconds ~/ 60)}:${_counterFormat(seconds % 60)}';
}

String _counterFormat(int counter) {
  if (counter <= 9) {
    return "0$counter";
  } else {
    return counter.toString();
  }
}
