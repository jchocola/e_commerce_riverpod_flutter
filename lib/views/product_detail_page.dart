import 'package:e_commerce/constants/themes.dart';
import 'package:e_commerce/controllers/itembag_controller.dart';
import 'package:e_commerce/controllers/liked_controller.dart';
import 'package:e_commerce/controllers/product_controller.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/views/card_page.dart';
import 'package:e_commerce/widgets/big_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class ProductDetailContent extends ConsumerWidget {
  const ProductDetailContent({super.key, required this.productIndex});
  final int productIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //providers
    final itemBag = ref.watch(itemBagProvider);
    final productProvider = ref.watch(productNotifierProvider);
    final currentProduct = productProvider[productIndex];

    //final likedProvider = ref.watch(LikedChangeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhiteColor),
        backgroundColor: kSecondaryColor,
        // title
        title: SvgPicture.asset(
          'assets/general/store_brand_white.svg',
          width: 180,
          color: kWhiteColor,
        ),
        //actions
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Badge(
              label: Text(itemBag.length.toString()),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CardPage()));
                  },
                  icon: const Icon(Icons.local_mall)),
            ),
          )
        ],
        leading: IconButton(
            onPressed: () {
              // pop up
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
      ),

      // body
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // images
            //TODO: Make Scrollable currusel
            Image.asset(currentProduct.imgUrl),

            // info section
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title and like button , bag button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // title
                      Flexible(
                        child: Text(
                          currentProduct.title,
                          style: AppTheme.kBigTitle.copyWith(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      // like and bag button
                      Row(
                        children: [
                          //like button
                          IconButton(
                              onPressed: () {
                                ///
                                /// like logic
                                /// 
                                

                                // if the liked props is FALSE
                                ref
                                    .read(productNotifierProvider.notifier)
                                    .isLikedItem(
                                        currentProduct.pid, productIndex);
                                if (currentProduct.liked == false) {
                                  ref
                                      .read(
                                          LikedChangeNotifierProvider.notifier)
                                      .addItem(ProductModel(pid: currentProduct.pid, imgUrl: currentProduct.imgUrl, title: currentProduct.title, price: currentProduct.price, shortDescription: currentProduct.shortDescription, longDescription: currentProduct.longDescription, review: currentProduct.review, rating: currentProduct.rating));
                                } else {
                                 ref
                                      .read(
                                          LikedChangeNotifierProvider.notifier)
                                      .removeItem(currentProduct.pid); 
                                }

                                // //if(currentProduct.liked == true)
                                // //print(currentProduct.liked);
                                // print(ref
                                //     .read(LikedChangeNotifierProvider)
                                //     .likedList
                                //     .length);
                              },
                              icon: currentProduct.liked == true
                                  ? const Icon(
                                      Icons.favorite_rounded,
                                      color: kPrimaryColor,
                                    )
                                  : const Icon(
                                      Icons.favorite_outline_rounded,
                                      color: Colors.grey,
                                    )),


                          // add to bag 
                          IconButton(
                              onPressed: () {
                                // // CHANGE THE ISSELECTED
                             ref.read(productNotifierProvider.notifier).isSeletedIem(
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
                                // print(currentProduct.isSelected);
                              },
                              icon: currentProduct.isSelected == true
                                  ? const Icon(
                                      Icons.local_mall,
                                      color: kPrimaryColor,
                                    )
                                  : const Icon(
                                      Icons.local_mall_outlined,
                                      color: Colors.grey,
                                    ))
                        ],
                      )
                    ],
                  ),

                  // stars and review
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          RatingBar(
                              onRatingUpdate: (value) => null,
                              allowHalfRating: true,
                              minRating: 1,
                              maxRating: 5,
                              itemSize: 14,
                              initialRating: currentProduct.rating,
                              ratingWidget: RatingWidget(
                                full: const Icon(
                                  size: 10,
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                half: const Icon(
                                  size: 10,
                                  Icons.star_half_outlined,
                                  color: Colors.amber,
                                ),
                                empty: const Icon(
                                  size: 10,
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                              )),
                          const Gap(10),
                          Text('${currentProduct.review} reviews'),
                        ],
                      ),
                      const Text('403 solds'),
                    ],
                  ),

                  const Gap(10),
                  // long description
                  Text(
                    currentProduct.longDescription,
                    style: AppTheme.kBodyText.copyWith(color: kBlackColor),
                  ),
                  const Gap(20),
                  // price and quantity
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${currentProduct.price * currentProduct.qty}',
                        style: AppTheme.kCardTitle.copyWith(fontSize: 20),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                if (currentProduct.qty == 0) {
                                  return;
                                } else {
                                  ref
                                      .read(productNotifierProvider.notifier)
                                      .decrementQty(currentProduct.pid);
                                }
                              },
                              icon: Icon(Icons.do_not_disturb_on_outlined)),
                          Text(
                            currentProduct.qty.toString(),
                            style: AppTheme.kCardTitle,
                          ),
                          IconButton(
                              onPressed: () {
                                ref
                                    .read(productNotifierProvider.notifier)
                                    .incrementQty(currentProduct.pid);
                                print(currentProduct.qty);
                              },
                              icon: const Icon(Icons.add_circle_outline))
                        ],
                      ),
                    ],
                  ),

                  //add to bag button
                  BigButton(
                    onPressed: () {},
                    title: 'Buy now',
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
