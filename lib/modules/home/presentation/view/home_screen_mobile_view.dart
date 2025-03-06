import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:idea_1/common/utils/loading_screen.dart';
import 'package:idea_1/modules/add_to_wallet/add_to_apple_wallet.dart';
import 'package:idea_1/modules/explore/presentation/view/explore_mobile_view.dart';
import 'package:idea_1/modules/gemini/presentation/widgets/gemini_chat_widget.dart';
import 'package:idea_1/modules/home/presentation/widgets/image_slider.dart';
import 'package:idea_1/modules/qr_code_scanner/qr_scanner_widget.dart';

class HomeScreenMobileView extends StatefulWidget {
  const HomeScreenMobileView({super.key});

  @override
  State<HomeScreenMobileView> createState() => _HomeScreenMobileViewState();
}

class _HomeScreenMobileViewState extends State<HomeScreenMobileView> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => SystemNavigator.pop(),
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 160,
                        child: Image.asset(
                          "assets/images/cartNew.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(0.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 56,
                      color: Colors.blueAccent,
                      child: const Center(
                        child: Text(
                          "SHOP WITH ME!!",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 250,
                        child: const ImageSliderForHomeScreen(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 250,
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                          // physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          // shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 250,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.green.shade200,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: 170,
                                    child:
                                        Image.asset("assets/images/cart.jpg"),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text("Item Name in Bold",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                        const Text("Item Descryption",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white)),
                                        RatingBar.builder(
                                          initialRating: 3,
                                          itemSize: 30,
                                          glow: true,
                                          glowColor: Colors.amber,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        const Text("Rs. 15000/-",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white)),
                                        const Text("Free Delivery for Mon",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white)),
                                        Center(
                                          child: SizedBox(
                                            width: 200,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.amber),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const LoadingScreenWidget()));
                                                  // ScaffoldMessenger.of(context)
                                                  //     .showSnackBar(
                                                  //   const SnackBar(
                                                  //     content: Text(
                                                  //         "Updates are comming soon.."),
                                                  //     backgroundColor:
                                                  //         Colors.red,
                                                  //   ),
                                                  // );
                                                },
                                                child: const Text(
                                                  "Add to Cart,",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 250,
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                          // physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          // shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 250,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.purple.shade200,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: 170,
                                    child:
                                        Image.asset("assets/images/cart.jpg"),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text("Item Name in Bold",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                        const Text("Item Descryption",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white)),
                                        RatingBar.builder(
                                          initialRating: 3,
                                          itemSize: 30,
                                          glow: true,
                                          glowColor: Colors.amber,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        const Text("Rs. 15000/-",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white)),
                                        const Text("Free Delivery for Mon",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white)),
                                        Center(
                                          child: SizedBox(
                                            width: 200,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.amber),
                                                onPressed: () {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          "Updates are comming soon.."),
                                                      backgroundColor:
                                                          Colors.red,
                                                    ),
                                                  );
                                                },
                                                child: const Text(
                                                  "Add to Cart,",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 250,
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                          // physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          // shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 250,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.pink.shade200,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: 170,
                                    child:
                                        Image.asset("assets/images/cart.jpg"),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text("It+em Name in Bold",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                        const Text("Item Descryption",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white)),
                                        RatingBar.builder(
                                          initialRating: 3,
                                          itemSize: 30,
                                          glow: true,
                                          glowColor: Colors.amber,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        const Text("Rs. 15000/-",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white)),
                                        const Text("Free Delivery for Mon",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white)),
                                        Center(
                                          child: SizedBox(
                                            width: 200,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.amber),
                                                onPressed: () {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          "Updates are comming soon.."),
                                                      backgroundColor:
                                                          Colors.red,
                                                    ),
                                                  );
                                                },
                                                child: const Text(
                                                  "Add to Cart,",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ExplorePageMobileView(),
                              ));
                        },
                        child: const Text(
                          "View More",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontFamily: "SourceSansPro",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const QRViewExample(),
                              ));
                        },
                        child: const Text(
                          "QR Scanner",
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 18,
                            fontFamily: "SourceSansPro",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const AddToGoogleWalletWidget(),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GeminiChatWidget(),
                              ));
                        },
                        child: const Text(
                          "Chat with Gemini",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                            fontFamily: "SourceSansPro",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
