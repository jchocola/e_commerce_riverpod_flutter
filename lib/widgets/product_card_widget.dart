import 'package:e_commerce/constants/themes.dart';
import 'package:e_commerce/controllers/itembag_controller.dart';
import 'package:e_commerce/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ProductCardWidget extends ConsumerWidget {
  const ProductCardWidget({super.key, required this.productIndex});
  final int productIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productNotifierProvider);
    final readProducts = ref.read(productNotifierProvider.notifier);

    final currentProduct = product[productIndex];
    return Container(
      decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 6),
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 2),
          ]),
      margin: EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image
          Container(
            //height: 100,
            width: double.infinity,
            margin: EdgeInsets.all(12),
            color: kLightBackground,
            child: Image.asset(product[productIndex].imgUrl),
          ),
          const Gap(4),

          // info section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text(
                  currentProduct.title,
                  style: AppTheme.kCardTitle,
                  overflow: TextOverflow.ellipsis,
                ),

                //short desc
                Text(
                  currentProduct.shortDescription,
                  style: AppTheme.kBodyText,
                  overflow: TextOverflow.ellipsis,
                ),

                //price and
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$ ${currentProduct.price}',
                      style: AppTheme.kCardTitle,
                    ),
                    IconButton(
                        onPressed: () {
                          readProducts.isSeletedIem(
                              currentProduct.pid, productIndex);

                          if (currentProduct.isSelected == false) {
                            ref
                                .read(itemBagProvider.notifier)
                                .addItem(currentProduct);
                          } else {
                            ref
                                .read(itemBagProvider.notifier)
                                .removeItem(currentProduct.pid);
                          }
                        },
                        icon: Icon(
                          currentProduct.isSelected == false
                              ? Icons.local_mall_outlined
                              : Icons.local_mall,
                          size: 30,
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
