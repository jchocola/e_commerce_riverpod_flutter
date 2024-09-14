import 'package:e_commerce/controllers/liked_controller.dart';
import 'package:e_commerce/views/card_page.dart';
import 'package:e_commerce/views/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikeContent extends ConsumerWidget {
  const LikeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // providers
    final likeProvider = ref.watch(LikedChangeNotifierProvider);

    // build UI
    // if like list empty
    if (likeProvider.likedList.isEmpty) {
      return Container(
          child: const Center(
        child: Text('Oops , the favourite list is empty'),
      ));
    }

    // else , have data

    else {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
            itemCount: likeProvider.likedList.length,
            itemBuilder: (context, index) {
              return ProductCardWidget2(
                  product: likeProvider.likedList[index]);
            }),
      );
    }
  }
}
