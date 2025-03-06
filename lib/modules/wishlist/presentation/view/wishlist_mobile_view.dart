import 'package:flutter/material.dart';
import 'package:idea_1/common/utils/bottom_navigation_bar.dart';

class WishListMobileView extends StatefulWidget {
  const WishListMobileView({super.key});

  @override
  State<WishListMobileView> createState() => _WishListMobileViewState();
}

List<bool> isFavoriteList = List.generate(1000, (index) => false);

class _WishListMobileViewState extends State<WishListMobileView> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CustomBottomNav(),
            ));
      },
      canPop: false,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          title: const Text(
            "WISHLIST",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              itemCount: 5,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 15),
              itemBuilder: (context, index) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Stack(alignment: Alignment.center, children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage("assets/images/cart.jpg"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Name",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "\$69",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isFavoriteList[index] =
                                !isFavoriteList[index]; // Toggle favorite state
                          });
                        },
                        icon: isFavoriteList[index]
                            ? const Icon(
                                Icons.favorite_border,
                                size: 30,
                                color: Colors.yellow,
                              )
                            : const Icon(Icons.favorite,
                                color: Colors.yellow, size: 30),
                      ),
                    )
                  ]),
                );
              },
            )),
          ],
        ),
      )),
    );
  }
}
