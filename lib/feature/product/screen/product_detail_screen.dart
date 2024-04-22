import 'package:amazon_clone/constant/global_var.dart';
import 'package:amazon_clone/feature/product/services/product_detail_services.dart';
import 'package:amazon_clone/feature/search/screen/search_screen.dart';
import 'package:amazon_clone/feature/wishlist/services/wishlist_services.dart';
import 'package:amazon_clone/model/products.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String routeName = '/product-detail';
  final ProductModel product;
  final String a;

  const ProductDetailScreen({super.key, required this.product, this.a = "7"});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailServices productDetailServices = ProductDetailServices();
  final WishlistServices wishlistServices = WishlistServices();

  double myRating = 0;
  double avgRating = 0;
  int indexOfpicture = 0;
  bool isTrue = false;
  @override
  void initState() {
    super.initState();
    double totalRating = 0;

    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating = widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void removeFromWishlist(ProductModel product) {
    wishlistServices.removeToWishlist(context: context, product: product);
  }

  void addToCart() {
    productDetailServices.addToCart(context: context, product: widget.product);
  }

  void addToWishlist() {
    productDetailServices.addToWishlist(
        context: context, product: widget.product);
  }

  void indexOfImage(int ind) {
    indexOfpicture = ind;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        width: double.maxFinite,
        height: 80,
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                spreadRadius: 3,
              )
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 13,
                ),
                "Total Price"
                    .text
                    .color(Color.fromARGB(255, 148, 147, 147))
                    .make(),
                const SizedBox(
                  height: 3,
                ),
                "\$${widget.product.price}"
                    .text
                    .color(Colors.red)
                    .bold
                    .size(20)
                    .make(),
              ],
            ),
            GestureDetector(
              onTap: addToCart,
              child: Container(
                width: 180,
                height: 50,
                decoration: BoxDecoration(
                    // color: GlobalVariables.mainColor,
                    color: const Color.fromARGB(255, 4, 83, 148),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.card_travel,
                      color: Colors.white,
                    ),
                    "Add to cart".text.color(Colors.white).make()
                  ],
                ).px32(),
              ),
            )
          ],
        ).px12(),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(),
          title: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              const Text(
                "Product Detail",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 83,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isTrue = !isTrue;
                  });
                  isTrue ? addToWishlist() : removeFromWishlist(widget.product);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    isTrue ? Icons.favorite : Icons.favorite_border,
                    color: isTrue
                        ? const Color.fromARGB(255, 4, 83, 148)
                        : Colors.black,
                  ),
                ),
              )
            ],
          ).pOnly(left: 40),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 370,
              width: double.maxFinite,
              color: Colors.limeAccent,
              child: Stack(
                children: [
                  Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                // "https://www.cnet.com/a/img/resize/dfd8b4f175537bda78f81eae02fa99a1a9a07aba/hub/2019/11/01/f0dcfa53-dc09-408d-bd78-a3a2e8db0c61/macbook-air-hgg-promo.jpg?auto=webp&fit=crop&height=675&width=1200",
                                widget.product.images[indexOfpicture]),
                            fit: BoxFit.cover)),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 19,
                    right: 19,
                    child: Container(
                      // height: 70,
                      // width: context.screenWidth / 1.2,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Wrap(
                        children: List.generate(widget.product.images.length,
                            (index) {
                          return GestureDetector(
                            onTap: () => indexOfImage(index),
                            child: Container(
                              width: 72,
                              height: 55,
                              margin: const EdgeInsets.only(
                                  right: 10, top: 6, left: 10, bottom: 7),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        widget.product.images[index]),
                                    fit: BoxFit.fill),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.product.id!),
                // Stars(rating: avgRating),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: GlobalVariables.secondaryColor,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    avgRating.toInt().text.make()
                  ],
                )
              ],
            ).pOnly(left: 15, right: 15, top: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                widget.product.name,
                style:
                    const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // CarouselSlider(
            //   items: widget.product.images.map((i) {
            //     return Builder(
            //       builder: (BuildContext context) => Image.network(
            //         i,
            //         fit: BoxFit.contain,
            //         height: 200,
            //       ),
            //     );
            //   }).toList(),
            //   options: CarouselOptions(
            //     viewportFraction: 1,
            //     height: 300,
            //   ),
            // ),
            // Container(
            //   color: Colors.black12,
            //   height: 5,
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //   child: RichText(
            //     text: TextSpan(
            //         text: 'Deal Price: ',
            //         style: const TextStyle(
            //           fontWeight: FontWeight.w600,
            //           color: Colors.black,
            //           fontSize: 16,
            //         ),
            //         children: [
            //           TextSpan(
            //             text: '\$${widget.product.price}',
            //             style: const TextStyle(
            //               fontWeight: FontWeight.w800,
            //               color: Colors.red,
            //               fontSize: 21,
            //             ),
            //           ),
            //         ]),
            //   ),
            // ),

            Container(
              color: Colors.black12,
              height: 2,
            ),

            const SizedBox(height: 9),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: "Product Details"
                  .text
                  .size(18)
                  .fontWeight(FontWeight.w500)
                  .make(),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(widget.product.description),
            ),
            Container(
              color: Colors.black12,
              height: 2,
            ),
            const SizedBox(
              height: 4,
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              child: Text(
                'Rate The Product',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
              ),
            ),
            RatingBar.builder(
              itemCount: 5,
              allowHalfRating: true,
              direction: Axis.horizontal,
              initialRating: myRating,
              minRating: 1,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: GlobalVariables.secondaryColor,
              ),
              onRatingUpdate: (rating) {
                productDetailServices.rateProduct(
                    context: context, product: widget.product, rating: rating);
              },
            ),
          ],
        ),
      ),
    );
  }
}
