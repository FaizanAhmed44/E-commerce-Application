import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/feature/address/screens/address_screen.dart';
import 'package:amazon_clone/feature/cart/services/cart_services.dart';

import 'package:amazon_clone/feature/order_detail/screen/order_review.dart';
import 'package:amazon_clone/feature/product/services/product_detail_services.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../model/products.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  ProductDetailServices productDetailServices = ProductDetailServices();
  CartServices cartServices = CartServices();

  void increseQuantity(ProductModel product) {
    productDetailServices.addToCart(context: context, product: product);
    setState(() {});
  }

  void decreaseQuantity(ProductModel product) {
    cartServices.removeFromCart(context: context, product: product);
    setState(() {});
  }

  void navigateToAddressScreen() {
    Navigator.pushNamed(context, AddressScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(),
          title: const Text(
            "Cart",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 25),
          ).px(160),
        ),
      ),
      body: SingleChildScrollView(
        child: user.cart.isEmpty
            ? Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Image.network(
                      'https://img.freepik.com/premium-vector/shopping-cart-with-cross-mark-wireless-paymant-icon-shopping-bag-failure-paymant-sign-online-shopping-vector_662353-912.jpg'),
                  "Your cart is empty!".text.bold.size(24).make().centered(),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromARGB(255, 4, 83, 148),
                    ),
                    child: "Start shopping"
                        .text
                        .bold
                        .color(Colors.white)
                        .size(16)
                        .make()
                        .centered(),
                  )
                ],
              )
            : Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        "Subtotal : ",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "\$$sum",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ).px(20),
                  const SizedBox(
                    height: 7,
                  ),
                  CustomButton(
                    color: const Color.fromARGB(255, 4, 83, 148),
                    text: "Proceed to buy (${user.cart.length}) items",
                    onTap: () {
                      if (user.address.isEmpty) {
                        navigateToAddressScreen();
                      } else {
                        Navigator.pushNamed(context, OrderReview.routeName,
                            arguments: user.address);
                      }
                    },
                  ).px16(),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 2,
                    color: Colors.black12,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: user.cart.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(
                          decelerationRate: ScrollDecelerationRate.normal),
                      itemBuilder: (context, index) {
                        final productCart =
                            context.watch<UserProvider>().user.cart[index];
                        final product =
                            ProductModel.fromMap(productCart['product']);
                        final quantity = productCart['quantity'];
                        return Container(
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Image.network(
                                      product.images[0],
                                      fit: BoxFit.contain,
                                      height: 135,
                                      width: 160,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: 220,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(product.name,
                                              style:
                                                  const TextStyle(fontSize: 18),
                                              maxLines: 2),
                                        ),
                                        Container(
                                          width: 220,
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 5),
                                          child: Text('\$${product.price}',
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15),
                                              maxLines: 2),
                                        ),
                                        Container(
                                          width: 220,
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 5),
                                          child: const Text(
                                              'Eligible For FREE Shipping',
                                              style: TextStyle(fontSize: 15),
                                              maxLines: 2),
                                        ),
                                        Container(
                                          width: 220,
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 5),
                                          child: const Text('In Stock',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 4, 83, 148),
                                                  fontSize: 15),
                                              maxLines: 2),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 14, top: 10, right: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black12,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.black12,
                                      ),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () =>
                                                decreaseQuantity(product),
                                            child: Container(
                                              width: 35,
                                              height: 32,
                                              alignment: Alignment.center,
                                              child: const Icon(
                                                Icons.remove,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          DecoratedBox(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black12,
                                                  width: 1.5,
                                                ),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(0)),
                                            child: Container(
                                              width: 35,
                                              height: 32,
                                              alignment: Alignment.center,
                                              child: Text(quantity.toString()),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () =>
                                                increseQuantity(product),
                                            child: Container(
                                              width: 35,
                                              height: 32,
                                              alignment: Alignment.center,
                                              child: const Icon(
                                                Icons.add,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
      ),
    );
  }
}
