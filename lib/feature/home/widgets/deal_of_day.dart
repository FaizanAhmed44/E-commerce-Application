import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constant/global_var.dart';
import 'package:amazon_clone/feature/home/services/home_services.dart';
import 'package:amazon_clone/feature/product/screen/product_detail_screen.dart';
import 'package:amazon_clone/model/products.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  List<ProductModel>? productsList;
  final HomeService homeService = HomeService();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    productsList = await homeService.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigatetoDetailScreen(ProductModel product) {
    Navigator.pushNamed(context, ProductDetailScreen.routeName,
        arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return productsList == null
        ? const Loader()
        : Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(
                  top: 7,
                  left: 15,
                ),
                child: const Text(
                  "Flash Sale",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                height: 600,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: double.maxFinite,
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: productsList!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      final product = productsList![index];
                      return GestureDetector(
                        onTap: () => navigatetoDetailScreen(product),
                        child: Container(
                          width: 190,
                          decoration: BoxDecoration(boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 0.5,
                            ),
                          ], borderRadius: BorderRadius.circular(8)),
                          margin: const EdgeInsets.only(
                              left: 5, bottom: 10, right: 5),
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.maxFinite,
                                  height: 135,
                                  decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: NetworkImage(product.images[0]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                productsList![index]
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
                                    "\$${productsList![index].price}"
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
                                        productsList![index].rating!.isEmpty
                                            ? "0"
                                                .text
                                                .size(14)
                                                .make()
                                                .pOnly(top: 2, right: 2)
                                            : productsList![index]
                                                .rating![0]
                                                .rating
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
                    }),
              ),
            ],
          );
  }
}
