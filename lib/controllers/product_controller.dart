import 'package:e_commerce/data/products.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:riverpod/riverpod.dart';

/*
  The State Notifier class , which provides the List of Product : 
  using to change : 
  - isSelected 
  - incrementQty
  - decrementQty

 */
class ProductNotifier extends StateNotifier<List<ProductModel>> {
  ProductNotifier() : super(productItems);

  // isSelected change state
  void isSeletedIem(int pid, int index) {
    state = [
      // get each product from list
      for (final product in state)

        // if product id equals the passed pid , the we change the isSelected property
        if (product.pid == pid)

          // change the value of isSelected field
          product.copyWith(isSelected: !state[index].isSelected)

        // else , nothing is changed , return the product
        else
          product,
    ];
  }

  void isLikedItem(int pid, int index) {
    state = [
      for (final product in state)
        if (product.pid == pid)
          product.copyWith(liked: !state[index].liked)
        else 
          product,
    ];
  }

  // increment qty
  void incrementQty(int pid) {
    state = [
      for (final product in state)
        if (product.pid == pid)
          product.copyWith(qty: product.qty + 1)
        else
          product,
    ];
  }

  //decrement qty
  void decrementQty(int pid) {
    state = [
      for (final product in state)
        if (product.pid == pid)
          product.copyWith(qty: product.qty - 1)
        else
          product,
    ];
  }
}

// The state notifier provider
final productNotifierProvider =
    StateNotifierProvider<ProductNotifier, List<ProductModel>>((ref) {
  return ProductNotifier();
});
