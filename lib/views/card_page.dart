import 'package:e_commerce/constants/themes.dart';
import 'package:e_commerce/controllers/coupon_controller.dart';
import 'package:e_commerce/controllers/itembag_controller.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/widgets/big_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class CardPage extends ConsumerWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // providers
    final selectedListProvider = ref.watch(itemBagProvider);
    final summaryProvider = ref.watch(priceCalcProvider);
    final couponProv = ref.watch(couponProvider);

    // build UI
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            couponProv.available = false;
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        backgroundColor: kSecondaryColor,
        iconTheme: const IconThemeData(color: kWhiteColor),
        title: const Text(
          'Card Page',
          style: TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Badge(
                label: Text(selectedListProvider.length.toString()),
                child: const Icon(Icons.local_mall),
              ))
        ],
      ),

      // body
      body: Column(
        children: [
          // products section
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(20),
                child: ListView.builder(
                    itemCount: selectedListProvider.length,
                    itemBuilder: (context, index) {
                      return ProductCardWidget2(
                        product: selectedListProvider[index],
                      );
                    }),
              )),

          // price section
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Have a coupon code? enter here'),

                    const Gap(5),
                    // coupon textfield
                    const CouponWidget(),

                    const Gap(10),
                    // Delivery Fee
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery Fee :',
                          style: AppTheme.kCardTitle,
                        ),
                        Text(
                          'Free',
                          style: AppTheme.kCardTitle,
                        ),
                      ],
                    ),

                    // discount
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Discount :',
                          style: AppTheme.kCardTitle,
                        ),
                        Text(
                          couponProv.available ? '10%' : 'No discount',
                          style: AppTheme.kCardTitle,
                        ),
                      ],
                    ),

                    // divider
                    const Divider(),

                    // total
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total :',
                          style:
                              AppTheme.kBigTitle.copyWith(color: kPrimaryColor),
                        ),
                        Text(
                          couponProv.available
                              ? '\$ ${summaryProvider * 0.9}'
                              : '\$ ${summaryProvider}',
                          style:
                              AppTheme.kBigTitle.copyWith(color: kPrimaryColor),
                        )
                      ],
                    ),

                    const Gap(30),
                    // Order
                    BigButton(
                      onPressed: () {},
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class ProductCardWidget2 extends StatelessWidget {
  ProductCardWidget2({super.key, required this.product});

  ProductModel product;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.only(bottom: 10),
      width: size.width,
      height: size.height * 0.12,
      decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: kBlackColor.withOpacity(0.1),
              blurRadius: 2,
              spreadRadius: 2,
              offset: const Offset(0, 2),
            )
          ]),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                child: Image.asset(product.imgUrl),
              )),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  Text(
                    product.title,
                    style: AppTheme.kCardTitle,
                  ),

                  // desc
                  Text(
                    product.shortDescription,
                    style: AppTheme.kBodyText,
                  ),

                  // price x qty
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price}',
                        style: AppTheme.kCardTitle,
                      ),
                      Text('x ${product.qty}')
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CouponWidget extends ConsumerWidget {
  const CouponWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //providers
    final couponProv = ref.watch(couponProvider);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kPrimaryColor),
      ),
      child: Row(
        children: [
          // textfield
          Flexible(
              child: TextField(
            maxLength: 6,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
                hintText: 'DE4EBA', border: InputBorder.none, counterText: ''),
            onChanged: (value) {
              //couponProv.checkAvailable(value);
              ref.read(couponProvider).checkAvailable(value);
              // print(couponProv.available);
            },
          )),

          // available check
          Row(
            children: [
              Text(
                'Available',
                style: TextStyle(
                    color: couponProv.available == true
                        ? kPrimaryColor
                        : Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Icon(
                Icons.check_circle_outline_outlined,
                color:
                    couponProv.available == true ? kPrimaryColor : Colors.grey,
              )
            ],
          )
        ],
      ),
    );
  }
}
