import 'package:e_commerce/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AdBannerWidget extends StatelessWidget {
  const AdBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.23,
      decoration: BoxDecoration(
          color: kPrimaryColor, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          // info
          Expanded(
              child: Container(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Apple Store',
                  style: AppTheme.kBigTitle,
                ),
                const Gap(8),
                Text(
                  'Find the Apple product and accessories you\'re looking for',
                  style: AppTheme.kBodyText.copyWith(color: kWhiteColor),
                ),
                const Gap(5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: kWhiteColor , foregroundColor: kSecondaryColor),
                  onPressed: () {}, child: const Text('Shop new year'))
              ],
            ),
          )),

          // image
          Image.asset('assets/general/landing.png')
        ],
      ),
    );
  }
}
