import 'package:amazon_clone/constant/global_var.dart';
import 'package:amazon_clone/feature/address/screens/address_screen.dart';
import 'package:amazon_clone/feature/address/services/address_services.dart';
import 'package:amazon_clone/feature/order_detail/screen/success_payment.dart';
import 'package:amazon_clone/model/products.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderReview extends StatefulWidget {
  final String address;
  static const String routeName = "/cart-review";
  const OrderReview({super.key, required this.address});

  @override
  State<OrderReview> createState() => _OrderReviewState();
}

class _OrderReviewState extends State<OrderReview> {
  final AddressServices addressServices = AddressServices();
  double sum = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    findTotalAmount();
    super.initState();
  }

  void findTotalAmount() {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    sum = 0.0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
  }

  void onSucess() {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    sum = 0.0;

    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();

    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: widget.address);
    }

    addressServices.placeOrder(
      context: context,
      address: widget.address,
      totalPrice: sum,
    );
  }

  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(),
          title: const Row(
            children: [
              SizedBox(
                width: 39,
              ),
              Text(
                "Order Review",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ).pOnly(left: 40, top: 6),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        width: double.maxFinite,
        height: 70,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        )),
        child: GestureDetector(
          onTap: () {
            onSucess();
            Navigator.pushNamed(context, SucessPayment.routeName);
          },
          child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(255, 4, 83, 148),
            ),
            child: "Checkout \$${sum + 6}"
                .text
                .color(Colors.white)
                .bold
                .size(18)
                .make()
                .centered(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                itemCount: productCart.length,
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  final productCart =
                      context.watch<UserProvider>().user.cart[index];
                  final product = ProductModel.fromMap(productCart['product']);
                  return Container(
                    width: double.maxFinite,
                    height: 90,
                    margin:
                        const EdgeInsets.only(bottom: 10, left: 15, right: 15),
                    // color: Colors.black,
                    child: Container(
                      child: Row(
                        children: [
                          Image.network(
                            product.images[0],
                            fit: BoxFit.contain,
                            height: 90,
                            width: 120,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: 220,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: product.name.text
                                    .maxLines(2)
                                    .ellipsis
                                    .size(14)
                                    .make(),
                              ),
                              Container(
                                width: 220,
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5),
                                child: Text('\$${product.price}',
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14),
                                    maxLines: 2),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                })),
            Container(
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26, width: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      decoration: const InputDecoration(
                          hintText: "Have a promo code? Enter here",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12, width: 0.4),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: GestureDetector(
                        onTap: () {},
                        child: "Apply"
                            .text
                            .color(GlobalVariables.mainColor)
                            .make()
                            .centered()),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26, width: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Subtotal".text.size(15).make(),
                      "\$$sum".text.size(15).make(),
                    ],
                  ).px(6),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Shipping Fee".text.size(15).make(),
                      "\$0.0".text.size(15).make(),
                    ],
                  ).px(6),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Tax Fee".text.size(15).make(),
                      "\$6.0".text.size(15).make(),
                    ],
                  ).px(6),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Order Total".text.size(15).bold.make(),
                      "\$${sum + 6}".text.size(15).bold.make(),
                    ],
                  ).px(6),
                  const SizedBox(
                    height: 14,
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 0.3,
                  ).px(4),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Payment Method".text.bold.size(18).make(),
                      GestureDetector(
                        onTap: () {},
                        child: "Change"
                            .text
                            .color(Color.fromARGB(255, 11, 100, 173))
                            .bold
                            .make()
                            .centered(),
                      )
                    ],
                  ).px(6),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 35,
                        height: 40,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://logowik.com/content/uploads/images/153_visa.jpg'))),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      "Visa Card"
                          .text
                          .fontWeight(FontWeight.w500)
                          .size(15)
                          .make(),
                    ],
                  ).px(26),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Shipping Address".text.bold.size(18).make(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AddressScreen.routeName);
                        },
                        child: "Change"
                            .text
                            .color(const Color.fromARGB(255, 11, 100, 173))
                            .bold
                            .make()
                            .centered(),
                      )
                    ],
                  ).px(6),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Home".text.fontWeight(FontWeight.w500).make(),
                          widget.address.text
                              .color(Colors.grey.shade500)
                              .maxLines(2)
                              .ellipsis
                              .make()
                        ],
                      ),
                    ],
                  ).pOnly(left: 26, right: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
