import 'package:flutter/material.dart';
import 'package:idea_1/modules/checkout/presentation/view/cart_mobile_view.dart';
import 'package:idea_1/modules/home/presentation/view/home_screen_mobile_view.dart';
import 'package:idea_1/modules/wishlist/presentation/view/wishlist_mobile_view.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({Key? key}) : super(key: key);

  @override
  State<CustomBottomNav> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CustomBottomNav> {
  /// Controller to handle PageView and also handles initial page
  late PageController pageController;

  /// Controller to handle bottom nav bar and also handles initial page

  int maxCount = 5;

  int selectedIndex = 0;

  /// widget list
  final List<Widget> bottomBarPages = [
    const HomeScreenMobileView(),
    const WishListMobileView(),
    const CartMobileView()
  ];
  @override
  void initState() {
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: const <Widget>[
            HomeScreenMobileView(),
            WishListMobileView(),
            CartMobileView(),
          ],
        ),
        extendBody: true,
        bottomNavigationBar: WaterDropNavBar(
          iconSize: 30,
          bottomPadding: 8,
          waterDropColor: Colors.purple,
          backgroundColor: Colors.white,
          onItemSelected: (int index) {
            setState(() {
              selectedIndex = index;
            });
            pageController.animateToPage(selectedIndex,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutQuad);
          },
          selectedIndex: selectedIndex,
          barItems: <BarItem>[
            BarItem(
              filledIcon: Icons.home_sharp,
              outlinedIcon: Icons.home_outlined,
            ),
            BarItem(
                filledIcon: Icons.favorite_rounded,
                outlinedIcon: Icons.favorite_border_rounded),
            BarItem(
              filledIcon: Icons.shopping_bag,
              outlinedIcon: Icons.shopping_bag_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
