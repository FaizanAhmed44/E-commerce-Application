import 'package:amazon_clone/constant/global_var.dart';
import 'package:amazon_clone/feature/cart/services/cart_services.dart';
import 'package:amazon_clone/feature/product/services/product_detail_services.dart';
import 'package:amazon_clone/model/products.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
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

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = ProductModel.fromMap(productCart['product']);
    final quantity = productCart['quantity'];
    return Container(
      margin: EdgeInsets.all(10),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(product.name,
                          style: const TextStyle(fontSize: 18), maxLines: 2),
                    ),
                    Container(
                      width: 220,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text('\$${product.price}',
                          style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                          maxLines: 2),
                    ),
                    Container(
                      width: 220,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: const Text('Eligible For FREE Shipping',
                          style: TextStyle(fontSize: 15), maxLines: 2),
                    ),
                    Container(
                      width: 220,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: const Text('In Stock',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: GlobalVariables.mainColor,
                              fontSize: 15),
                          maxLines: 2),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 14, top: 10, right: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        onTap: () => decreaseQuantity(product),
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
                            borderRadius: BorderRadius.circular(0)),
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: Text(quantity.toString()),
                        ),
                      ),
                      InkWell(
                        onTap: () => increseQuantity(product),
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
  }
}
