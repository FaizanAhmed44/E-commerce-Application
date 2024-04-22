import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/feature/account/services/account_services.dart';
import 'package:amazon_clone/feature/order_detail/screen/order_detail_screen.dart';
import 'package:amazon_clone/model/order.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Order extends StatefulWidget {
  static const String routeName = '/myOrder';
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  List<OrderModel>? order;
  final AccountService accountService = AccountService();

  @override
  void initState() {
    super.initState();
    fetchMyOrder();
  }

  void fetchMyOrder() async {
    order = await accountService.fetchMyOrder(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(),
          ),
          title: const Text(
            "My Order",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
          ).pOnly(left: 88, top: 9),
        ),
      ),
      body: order == null
          ? const Loader()
          : ListView.builder(
              itemCount: order!.length,
              itemBuilder: ((context, index) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 97,
                          width: 110,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 0.4,
                                spreadRadius: 0.4,
                                offset: Offset(0.1, 0.2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                image: NetworkImage(
                                    order![index].products[0].images[0]),
                                fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              order![index]
                                  .products[0]
                                  .name
                                  .text
                                  .ellipsis
                                  .maxLines(1)
                                  .fontWeight(FontWeight.w500)
                                  .size(17)
                                  .make(),
                              const SizedBox(
                                height: 2,
                              ),
                              "Total Items : ${order![index].products.length}"
                                  .text
                                  .color(Colors.grey.shade500)
                                  .size(15)
                                  .make(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  "\$${order![index].totalPrice}"
                                      .text
                                      .fontWeight(FontWeight.bold)
                                      .size(15)
                                      .make(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, OrderDetailScreen.routeName,
                                          arguments: order![index]);
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color.fromARGB(
                                            255, 4, 83, 148),
                                      ),
                                      child: "Track Order"
                                          .text
                                          .bold
                                          .color(Colors.white)
                                          .size(12)
                                          .make()
                                          .centered(),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 0.2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ).px20();
              })),
    );
  }
}
