import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constant/global_var.dart';
import 'package:amazon_clone/feature/home/services/home_services.dart';
import 'package:amazon_clone/feature/product/screen/product_detail_screen.dart';
import 'package:amazon_clone/model/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryDealScreen extends StatefulWidget {
  static const String routeName = "/category-deals";
  final String category;
  const CategoryDealScreen({super.key, required this.category});

  @override
  State<CategoryDealScreen> createState() => _CategoryDealScreenState();
}

class _CategoryDealScreenState extends State<CategoryDealScreen> {
  List<ProductModel>? productsList;
  final HomeService homeService = HomeService();

  @override
  void initState() {
    super.initState();
    fetchAllCategoryData();
  }

  void fetchAllCategoryData() async {
    productsList = await homeService.fetchCategoryProducts(
      context: context,
      category: widget.category,
    );
    print("length is ${productsList!.length}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
              // decoration: const BoxDecoration(
              //   gradient: GlobalVariables.appBarGradient,
              // ),
              ),
          title: Row(
            children: [
              const SizedBox(
                width: 39,
              ),
              Text(
                widget.category,
                style: const TextStyle(
                    // color: GlobalVariables.mainColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ).pOnly(left: 40, top: 6),
        ),
      ),
      body: productsList == null
          ? const Loader()
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: productsList!.length,
              itemBuilder: ((context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductDetailScreen.routeName,
                        arguments: productsList![index]);
                  },
                  child: Container(
                    height: 210,
                    width: 190,

                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 1,
                            spreadRadius: 1,
                          )
                        ],
                        borderRadius: BorderRadius.circular(14)),
                    // padding: const EdgeInsets.symmetric(horizontal: 5),
                    margin: const EdgeInsets.only(
                        left: 10, bottom: 10, right: 10, top: 2.6),
                    child: Container(
                      color: Colors.white,
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
                                  image: NetworkImage(
                                      productsList![index].images[0]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 12,
                              top: 5,
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.shade200,
                                child: Icon(
                                  Icons.favorite_outline,
                                  color: Colors.blue.shade300,
                                ),
                              ),
                            )
                          ]),
                          const SizedBox(
                            height: 3,
                          ),
                          // productsList![index]
                          //     .name
                          productsList![index]
                              .name
                              .text
                              .ellipsis
                              .fontWeight(FontWeight.w500)
                              .make()
                              .px2(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // "\$${productsList![index].price}"
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
                                  // productsList![index]
                                  //     .rating![0]
                                  //     .rating

                                  productsList![index].rating!.isEmpty
                                      ? "0"
                                          .text
                                          .size(14)
                                          .make()
                                          .pOnly(top: 2, right: 2)
                                      : "${productsList![index].rating![0].rating}"
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
    );
  }
}
