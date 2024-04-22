import 'package:amazon_clone/constant/global_var.dart';
import 'package:amazon_clone/feature/product/screen/product_detail_screen.dart';
import 'package:amazon_clone/feature/wishlist/services/wishlist_services.dart';
import 'package:amazon_clone/model/products.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class WishListScreen extends StatefulWidget {
  static const String routeName = '/whishlist';

  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final WishlistServices wishlistServices = WishlistServices();

  void removeFromWishlist(ProductModel product) {
    wishlistServices.removeToWishlist(context: context, product: product);
  }

  void navigatetoDetailScreen(ProductModel product) {
    Navigator.pushNamed(context, ProductDetailScreen.routeName,
        arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    final productWishlist = context.watch<UserProvider>().user.wishlist;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
              // decoration: const BoxDecoration(
              //   gradient: GlobalVariables.appBarGradient,
              // ),
              ),
          title: const Row(
            children: [
              SizedBox(
                width: 90,
              ),
              Text(
                "My Wishlist",
                style: TextStyle(
                    // color: GlobalVariables.mainColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ).pOnly(left: 40, top: 6),
        ),
      ),
      body: productWishlist.isEmpty
          ? Column(
              children: [
                const SizedBox(
                  height: 70,
                ),
                Image.asset(
                  "asset/images/2.jpg",
                  width: 400,
                  height: 400,
                  fit: BoxFit.cover,
                ),
                "Your wishlist is empty!".text.bold.size(24).make().centered(),
                const SizedBox(
                  height: 19,
                ),
                Container(
                  width: double.maxFinite,
                  height: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 4, 83, 148),
                  ),
                  child: "Explore"
                      .text
                      .bold
                      .color(Colors.white)
                      .size(16)
                      .make()
                      .centered(),
                )
              ],
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: productWishlist.length,
              shrinkWrap: true,
              itemBuilder: ((context, index) {
                final product =
                    ProductModel.fromMap(productWishlist[index]['product']);
                return GestureDetector(
                  onTap: () => navigatetoDetailScreen(product),
                  child: Container(
                    height: 210,
                    width: 190,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26, width: 0.33),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    margin:
                        const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(children: [
                          Container(
                            width: double.maxFinite,
                            height: 145,
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(product.images[0]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 12,
                            top: 5,
                            child: GestureDetector(
                              onTap: () => removeFromWishlist(product),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.shade200,
                                // backgroundColor: Colors.white70,
                                child: const Icon(
                                  Icons.favorite,
                                  color: Color.fromARGB(255, 4, 83, 148),
                                ),
                              ),
                            ),
                          )
                        ]),
                        const SizedBox(
                          height: 5,
                        ),
                        product.name.text
                            .fontWeight(FontWeight.w500)
                            .ellipsis
                            .make()
                            .px2(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "\$${product.price}".text.size(17.6).bold.make(),
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
                                product.rating!.isEmpty
                                    ? "0"
                                        .text
                                        .size(14)
                                        .make()
                                        .pOnly(top: 2, right: 2)
                                    : product.rating![0].rating.text
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
                );
              })),
    );
  }
}
