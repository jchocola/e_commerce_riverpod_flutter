import 'package:e_commerce/constants/themes.dart';
import 'package:e_commerce/controllers/product_controller.dart';
import 'package:e_commerce/views/product_detail_page.dart';
import 'package:e_commerce/widgets/ad_banner.dart';
import 'package:e_commerce/widgets/chip_widget.dart';
import 'package:e_commerce/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';

class HomeContent extends ConsumerWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productNotifierProvider);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            // ads banner section
            const AdBannerWidget(),

            const Gap(8),

            // chip section
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: const [
                  ChipWidget(chipLabel: 'All'),
                  ChipWidget(chipLabel: 'Computers'),
                  ChipWidget(chipLabel: 'Headsets'),
                  ChipWidget(chipLabel: 'Accessories'),
                  ChipWidget(chipLabel: 'Printing'),
                  ChipWidget(chipLabel: 'Camera'),
                ],
              ),
            ),

            // hot sale section
            const Gap(12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Hot Sales',
                  style: AppTheme.kHeadingOne,
                ),
                Text(
                  'See all',
                  style: AppTheme.kSeeAllText,
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.all(4),
              width: MediaQuery.of(context).size.width,
              height: 350,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) => ProductCardWidget(
                        productIndex: index,
                      )
                  //Container(height: 15, width: 15, color: Colors.red,)
                  ),
            ),

            // all products
            const Gap(12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Featured Products',
                  style: AppTheme.kHeadingOne,
                ),
                Text(
                  'See all',
                  style: AppTheme.kSeeAllText,
                )
              ],
            ),

            // products
            MasonryGridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetailContent(
                                      productIndex: index,
                                    )));
                      },
                      child: ProductCardWidget(productIndex: index));
                })
          ],
        ),
      ),
    );
  }
}
