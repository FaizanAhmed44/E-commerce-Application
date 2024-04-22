import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/feature/admin/services/admin_services.dart';
import 'package:amazon_clone/feature/search/screen/search_screen.dart';
import 'package:amazon_clone/model/order.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderDetailScreen extends StatefulWidget {
  static const String routeName = '/order-detail';
  final OrderModel order;
  const OrderDetailScreen({super.key, required this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int currentStep = 0;
  final AdminServices adminServices = AdminServices();

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  // !!! ONLY FOR ADMIN !!!
  void changeOrderStatus(int status) {
    adminServices.changeOrderStatus(
      context: context,
      order: widget.order,
      status: status + 1,
      onSucess: () {
        setState(() {
          currentStep += 1;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                // gradient: GlobalVariables.appBarGradient,
                ),
          ),
          title: const Text(
            "Track Order",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
          ).pOnly(left: 88, top: 9),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < widget.order.products.length; i++)
                    Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            // color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                  widget.order.products[i].images[0]),
                              fit: BoxFit.cover,
                            ),
                          ),
                          // child: Image.network(
                          //   widget.order.products[i].images[0],
                          //   fit: BoxFit.cover,
                          //   width: 70,
                          //   height: 70,
                          // ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.order.products[i].name.text.bold
                                .maxLines(2)
                                .overflow(TextOverflow.ellipsis)
                                .size(16.2)
                                .make(),
                            "Qty: ${widget.order.quantity[i]} "
                                .text
                                .size(13)
                                .color(Colors.grey.shade500)
                                .make(),
                            "\$${widget.order.products[i].price} "
                                .text
                                .size(15)
                                .fontWeight(FontWeight.w500)
                                .make(),
                          ],
                        )),
                      ],
                    ).pOnly(bottom: 10),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 0.1,
            ),
            const SizedBox(
              height: 10,
            ),
            "Order Details".text.bold.size(21).make(),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              // height: 70,
              padding: const EdgeInsets.all(8),
              // decoration: BoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Order Date: ".text.color(Colors.grey.shade600).make(),
                      DateFormat()
                          .format(DateTime.fromMillisecondsSinceEpoch(
                              widget.order.orderedAt))
                          .text
                          .make()
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Order Status: ".text.color(Colors.grey.shade600).make(),
                      widget.order.status.text.make()
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total Amount: ".text.color(Colors.grey.shade600).make(),
                      '\$${widget.order.totalPrice}'.text.make()
                    ],
                  ),
                  // "Order Status:           ${widget.order.status}".text.make(),
                  // "Total Amount:          \$${widget.order.totalPrice}"
                  //     .text
                  //     .make(),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 0.1,
            ),
            const SizedBox(
              height: 10,
            ),
            "Tracking".text.bold.size(22).make().px4(),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: ((context, details) {
                    if (user.type == 'admin') {
                      return CustomButton(
                          color: const Color.fromARGB(255, 4, 83, 148),
                          text: "Done",
                          onTap: () => changeOrderStatus(details.currentStep));
                    }
                    return const SizedBox(); // with this nothing is show below the content
                  }),
                  steps: [
                    Step(
                      title: "Pending".text.make(),
                      content: "Your order is yet to be delivered.".text.make(),
                      isActive: currentStep > 0,
                      state: currentStep > 0
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: "Completed".text.make(),
                      content:
                          "Your order has been delivered, you are yet to sign."
                              .text
                              .make(),
                      isActive: currentStep > 1,
                      state: currentStep > 1
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: "Received".text.make(),
                      content:
                          "Your order has been delivered and signed by you."
                              .text
                              .make(),
                      isActive: currentStep > 2,
                      state: currentStep > 2
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: "Delivered".text.make(),
                      content:
                          "Your order has been delivered and signed by you."
                              .text
                              .make(),
                      isActive: currentStep >= 3,
                      state: currentStep >= 3
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                  ]),
            )
          ],
        ).px12(),
      ),
    );
  }
}
