import 'package:e_commerce/models/product_model.dart';
import 'package:riverpod/riverpod.dart';

// The list of selected products
List<ProductModel> itembag = [];

class ItemBagNotifier extends StateNotifier<List<ProductModel>> {
  ItemBagNotifier() : super(itembag);

  // add new item
  void addItem(ProductModel product) {
    state = [...state, product];
  }

  // remove the item
  void removeItem(int pid) {
    state = [
      for (final product in state)
        if (product.pid != pid) product,
    ];
  }
}

final itemBagProvider =
    StateNotifierProvider<ItemBagNotifier, List<ProductModel>>((ref) {
  return ItemBagNotifier();
});

//COUNTING SUM PART

final priceCalcProvider = StateProvider<double>((ref) {
  // selected items
  final itemBag = ref.watch(itemBagProvider);

  // counting the sum
  double sum = 0;

  for (final product in itemBag) {
    sum += product.price * product.price;
  }
  return sum;
});
