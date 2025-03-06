import 'package:flutter/material.dart';
import 'package:idea_1/common/utils/bottom_navigation_bar.dart';

class CartMobileView extends StatelessWidget {
  const CartMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CustomBottomNav(),
          )),
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          title: const Text(
            "CART",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          surfaceTintColor: Colors.black,
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                height: MediaQuery.of(context).size.height * 0.552,
                color: Colors.black,
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        // color: Colors.white,
                        elevation: 5,
                        shadowColor: Colors.white,
                        child: ListTile(
                          iconColor: Colors.purple,
                          leading: const CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage("assets/images/cart.jpg"),
                          ),
                          title: const Text(
                            "Product 1",
                            style: TextStyle(fontSize: 18),
                          ),
                          subtitle: const Text(
                            "\$69",
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: IconButton(
                              icon: const Icon(Icons.delete), onPressed: () {}),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: 8),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Items (8):",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width < 300
                                ? 13
                                : 18,
                            fontWeight: FontWeight.w200),
                      ),
                      Text(
                        "₹1000",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width < 300
                                ? 13
                                : 18,
                            fontWeight: FontWeight.w200),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Taxes:",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width < 300
                                ? 13
                                : 18,
                            fontWeight: FontWeight.w200),
                      ),
                      Text(
                        "₹50",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width < 300
                                ? 13
                                : 18,
                            fontWeight: FontWeight.w200),
                      )
                    ],
                  ),
                  const Divider(
                    color: Color.fromRGBO(183, 184, 182, 1),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Amount:",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width < 300
                                ? 13
                                : 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "₹1050",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width < 300
                                ? 13
                                : 18,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          alignment: Alignment.center,
                          surfaceTintColor: Colors.purple,
                          backgroundColor: Colors.purple,
                          shadowColor: Colors.yellow,
                          elevation: 10),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Updates are comming soon.."),
                            backgroundColor: Colors.red,
                          ),
                        );
                      },
                      child: Text(
                        "PAY NOW",
                        style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.width < 300 ? 13 : 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
