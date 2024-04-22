import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constant/global_var.dart';
import 'package:amazon_clone/feature/product/screen/product_detail_screen.dart';
import 'package:amazon_clone/feature/product/services/product_detail_services.dart';
import 'package:amazon_clone/feature/search/services/search_services.dart';
import 'package:amazon_clone/model/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ProductModel>? product;
  final SearchService searchService = SearchService();
  final ProductDetailServices productDetailServices = ProductDetailServices();

  @override
  void initState() {
    super.initState();
    fetchProductData();
  }

  fetchProductData() async {
    product = await searchService.fetchSearchProducts(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void addToWishlist(ProductModel product) {
    productDetailServices.addToWishlist(context: context, product: product);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: const Text(
            "Search",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 19),
          ).pOnly(left: 92, top: 9),
        ),
      ),
      body: product == null
          ? const Loader()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      height: 48,
                      child: Material(
                        borderRadius: BorderRadius.circular(25),
                        elevation: 1,
                        child: TextFormField(
                          onFieldSubmitted: navigateToSearchScreen,
                          decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.only(left: 7),
                                child: Icon(
                                  CupertinoIcons.search,
                                  color: Colors.black54,
                                  size: 23,
                                ),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(bottom: 2),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.black12, width: 1),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.black12, width: 1),
                            ),
                            hintText: widget.searchQuery,
                            hintStyle: const TextStyle(
                                color: Colors.black38, fontSize: 19),
                          ),
                        ),
                      ),
                    )),
                  ],
                ).px16(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Result for '' ${widget.searchQuery} ''"
                        .text
                        .bold
                        .size(16)
                        .make(),
                    "${product!.length} item founds".text.bold.size(16).make(),
                  ],
                ).px20(),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: product!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, ProductDetailScreen.routeName,
                              arguments: product![index]);
                        },
                        child: Container(
                          height: 240,
                          width: 190,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black26, width: 0.3),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          margin: const EdgeInsets.only(
                              left: 10, bottom: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(children: [
                                Container(
                                  width: double.maxFinite,
                                  height: 145,
                                  decoration: BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          product![index].images[0]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 12,
                                  top: 5,
                                  child: GestureDetector(
                                    onTap: () => addToWishlist(product![index]),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey.shade200,
                                      child: const Icon(
                                        Icons.favorite_outline,
                                        color: GlobalVariables.mainColor,
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                              const SizedBox(
                                height: 5,
                              ),
                              product![index]
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
                                  "\$${product![index].price}"
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
                                      product![index].rating!.isEmpty
                                          ? "0"
                                              .text
                                              .size(14)
                                              .make()
                                              .pOnly(top: 2, right: 2)
                                          : product![index]
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
                      );
                    }),
                  ),
                ),
              ],
            ),
    );
  }
}
