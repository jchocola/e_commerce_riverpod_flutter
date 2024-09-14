import 'package:e_commerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikedController extends ChangeNotifier {
  List<ProductModel> likedList = [];

  void addItem(ProductModel product) {
    likedList.add(product);
    notifyListeners();
  }

  void removeItem(int pid) {
    for (final product in likedList) {
      if (product.pid == pid) {
        likedList.remove(product);
        break;
      }
    }
    notifyListeners();
  }
}

final LikedChangeNotifierProvider = ChangeNotifierProvider((ref) {
  return LikedController();
});
