import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final couponProvider = ChangeNotifierProvider((ref) {
  return CouponNotifier();
});

class CouponNotifier extends ChangeNotifier {
  final List<String> couponList = [
    'GDEGSG',
    '34HD1G',
    '69H8FD',
    '6D0GSD',
    '75HGD2',
    'HD5SQ1',
    '6RTFW4',
    '078FW2',
    'FHDA4W',
    'GA25YH',
    '53AFGH',
    '123456',
    '173422'
  ];
  bool available = false;

  void checkAvailable(String coupon) {
    if (couponList.contains(coupon)) {
      available = true;
      notifyListeners();
    } else {
      available = false;
      notifyListeners();
    }
  }
}
