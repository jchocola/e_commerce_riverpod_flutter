import 'package:e_commerce/constants/themes.dart';
import 'package:e_commerce/controllers/itembag_controller.dart';
import 'package:e_commerce/views/card_page.dart';

import 'package:e_commerce/views/home_content.dart';
import 'package:e_commerce/views/likes/like_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

// current page index provider
final currentIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //providers
    final currentIndex = ref.watch(currentIndexProvider);
    final itemBag = ref.watch(itemBagProvider);

    // build UI
    return Scaffold(
      // appbar
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const CardPage()));
                  },
                  icon: const Icon(Icons.local_mall)),
            ),
          )
        ],
      ),

      // drawer
      drawer: Drawer(),

      // body
      body: pageList[currentIndex],

      // bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) =>
            ref.read(currentIndexProvider.notifier).update((state) => value),
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: kSecondaryColor,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              activeIcon: Icon(Icons.home_filled)),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: 'Favourite',
              activeIcon: Icon(Icons.favorite)),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined),
              label: 'Location',
              activeIcon: Icon(Icons.location_on)),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_on_outlined),
              label: 'Notification',
              activeIcon: Icon(Icons.notifications_on)),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
              activeIcon: Icon(Icons.person)),
        ],
      ),
    );
  }
}

final List pageList = [
  HomeContent(), // home content

  LikeContent(), // 
  Container(
    child: Center(
      child: Text('Location'),
    ),
  ),
  Container(
    child: Center(
      child: Text('Notification'),
    ),
  ),
  Container(
    child: Center(
      child: Text('Person'),
    ),
  ),
];
