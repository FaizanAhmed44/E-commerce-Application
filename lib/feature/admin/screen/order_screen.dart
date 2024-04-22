import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constant/global_var.dart';
import 'package:amazon_clone/feature/admin/services/admin_services.dart';
import 'package:amazon_clone/feature/order_detail/screen/order_detail_screen.dart';
import 'package:amazon_clone/model/order.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderScreen extends StatefulWidget {
  static const String routeName = '/order-screen-admin';
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<OrderModel>? orders;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllTheOrders();
  }

  void fetchAllTheOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Total Orders : ${orders!.length}"
                  .text
                  .size(20)
                  .bold
                  .make()
                  .px16(),
              const SizedBox(
                height: 14,
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: orders!.length,
                    itemBuilder: ((context, index) {
                      final orderData = orders![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, OrderDetailScreen.routeName,
                              arguments: orderData);
                        },
                        child: Container(
                          height: 210,
                          width: 190,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                )
                              ],
                              borderRadius: BorderRadius.circular(12)),
                          // padding: const EdgeInsets.symmetric(horizontal: 5),
                          margin: const EdgeInsets.only(
                              left: 10, bottom: 10, right: 10),
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.maxFinite,
                                  height: 145,
                                  decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          orders![index].products[0].images[0]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                // productsList![index]
                                //     .name
                                orders![index]
                                    .products[0]
                                    .name
                                    .text
                                    .ellipsis
                                    .fontWeight(FontWeight.w500)
                                    .make()
                                    .px2(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // "\$${productsList![index].price}"
                                    "\$${orders![index].totalPrice}"
                                        .text
                                        .size(17.6)
                                        .bold
                                        .make(),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: GlobalVariables.secondaryColor,
                                          size: 18,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        // productsList![index]
                                        //     .rating![0]
                                        //     .rating
                                        "${orders![index].products[0].rating![0].rating}"
                                            .text
                                            .size(14)
                                            .make()
                                            .pOnly(top: 2, right: 2),
                                      ],
                                    )
                                  ],
                                ).px4(),
                              ],
                            ),
                          ),
                        ),
                      );
                    })),

                // GridView.builder(
                //   itemCount: orders!.length,
                //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 2),
                //   itemBuilder: (context, index) {
                //     final orderData = orders![index];
                //     return GestureDetector(
                //       onTap: () {
                //         Navigator.pushNamed(
                //             context, OrderDetailScreen.routeName,
                //             arguments: orderData);
                //       },
                //       child: SizedBox(
                //         height: 140,
                //         child: SingleProduct(
                //             image: orderData.products[0].images[0]),
                //       ),
                //     );
                //   },
                // ),
              ),
            ],
          );
  }
}
