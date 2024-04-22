import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/feature/admin/screen/add_product_screen.dart';
import 'package:amazon_clone/feature/admin/services/admin_services.dart';
import 'package:amazon_clone/model/products.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<ProductModel>? products;
  final AdminServices adminServices = AdminServices();
  List<ProductModel> Essentials = [];
  List<ProductModel> Mobiles = [];
  List<ProductModel> Appliances = [];
  List<ProductModel> Fashion = [];
  List<ProductModel> Books = [];
  @override
  void initState() {
    super.initState();
    fetchAllProduct();
  }

  fetchAllProduct() async {
    products = await adminServices.fetchAllData(context);
    setState(() {});

    partitionCategoryWiseData();
  }

  partitionCategoryWiseData() {
    if (products != null) {
      for (int i = 0; i < products!.length; i++) {
        if (products![i].category == "Mobiles") {
          Mobiles.add(products![i]);
        } else if (products![i].category == "Essentials") {
          Essentials.add(products![i]);
        } else if (products![i].category == "Appliances") {
          Appliances.add(products![i]);
        } else if (products![i].category == "Books") {
          Books.add(products![i]);
        } else {
          Fashion.add(products![i]);
        }
      }
      setState(() {});
    } else {
      print("null");
    }
  }

  void deleteProduct(ProductModel product, int index) {
    adminServices.deleteProduct(
        context: context,
        product: product,
        onSucess: () {
          // products!.removeAt(index);
          products!.remove(product);
          setState(() {});
        });
  }

  void navigateToAddScreen() {
    Navigator.pushNamed(context, AddProduct.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Total Added Items : ${products!.length}"
                      .text
                      .bold
                      .size(19)
                      .make()
                      .px16(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Colors.black45,
                    thickness: 0.2,
                  ).px12(),
                  const SizedBox(
                    height: 10,
                  ),
                  if (Mobiles.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Mobiles"
                                .text
                                .bold
                                .size(24)
                                // .color(GlobalVariables.mainColor)
                                .color(Color.fromARGB(255, 4, 83, 148))
                                .make(),
                            "Total Items : ${Mobiles.length}".text.bold.make(),
                          ],
                        ).px20(),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 215,
                          margin: const EdgeInsets.only(left: 10),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Mobiles.length,
                              itemBuilder: ((context, index) {
                                return Container(
                                  width: 180,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade100,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.maxFinite,
                                          height: 135,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      Mobiles[index].images[0]),
                                                  fit: BoxFit.cover)),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Mobiles[index]
                                            .name
                                            .text
                                            .ellipsis
                                            .size(18)
                                            .make()
                                            .px4(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            "\$${Mobiles[index].price}"
                                                .text
                                                .bold
                                                .size(16)
                                                .make(),
                                            GestureDetector(
                                                onTap: () {
                                                  deleteProduct(
                                                      Mobiles[index], index);
                                                  setState(() {});
                                                },
                                                child: const Icon(
                                                    Icons.delete_outline))
                                          ],
                                        ).px4(),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  if (Essentials.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Essentials"
                                .text
                                .bold
                                .size(24)
                                // .color(GlobalVariables.mainColor)
                                .color(Color.fromARGB(255, 4, 83, 148))
                                .make(),
                            "Total Items : ${Essentials.length}"
                                .text
                                .bold
                                .make(),
                          ],
                        ).px20(),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 215,
                          margin: const EdgeInsets.only(left: 10),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Essentials.length,
                              itemBuilder: ((context, index) {
                                return Container(
                                  width: 180,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade100,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.maxFinite,
                                          height: 135,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      Essentials[index]
                                                          .images[0]),
                                                  fit: BoxFit.cover)),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Essentials[index]
                                            .name
                                            .text
                                            .ellipsis
                                            .size(18)
                                            .make()
                                            .px4(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            "\$${Essentials[index].price}"
                                                .text
                                                .bold
                                                .size(16)
                                                .make(),
                                            GestureDetector(
                                                onTap: () {
                                                  deleteProduct(
                                                      Essentials[index], index);
                                                  setState(() {});
                                                },
                                                child: const Icon(
                                                    Icons.delete_outline))
                                          ],
                                        ).px4(),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  if (Appliances.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Appliances"
                                .text
                                .bold
                                .size(24)
                                // .color(GlobalVariables.mainColor)
                                .color(Color.fromARGB(255, 4, 83, 148))
                                .make(),
                            "Total Items : ${Appliances.length}"
                                .text
                                .bold
                                .make(),
                          ],
                        ).px20(),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 215,
                          margin: const EdgeInsets.only(left: 10),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Appliances.length,
                              itemBuilder: ((context, index) {
                                return Container(
                                  width: 180,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade100,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.maxFinite,
                                          height: 135,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      Appliances[index]
                                                          .images[0]),
                                                  fit: BoxFit.cover)),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Appliances[index]
                                            .name
                                            .text
                                            .ellipsis
                                            .size(18)
                                            .make()
                                            .px4(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            "\$${Appliances[index].price}"
                                                .text
                                                .bold
                                                .size(16)
                                                .make(),
                                            GestureDetector(
                                                onTap: () {
                                                  deleteProduct(
                                                      Appliances[index], index);
                                                  setState(() {});
                                                },
                                                child: const Icon(
                                                    Icons.delete_outline))
                                          ],
                                        ).px4(),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  if (Fashion.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Fashions"
                                .text
                                .bold
                                .size(24)
                                // .color(GlobalVariables.mainColor)
                                .color(Color.fromARGB(255, 4, 83, 148))
                                .make(),
                            "Total Items : ${Fashion.length}".text.bold.make(),
                          ],
                        ).px16(),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 215,
                          margin: const EdgeInsets.only(left: 10),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Fashion.length,
                              itemBuilder: ((context, index) {
                                return Container(
                                  width: 180,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade100,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.maxFinite,
                                          height: 135,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      Fashion[index].images[0]),
                                                  fit: BoxFit.cover)),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Fashion[index]
                                            .name
                                            .text
                                            .ellipsis
                                            .size(18)
                                            .make()
                                            .px4(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            "\$${Fashion[index].price}"
                                                .text
                                                .bold
                                                .size(16)
                                                .make(),
                                            GestureDetector(
                                                onTap: () {
                                                  deleteProduct(
                                                      Fashion[index], index);
                                                  setState(() {});
                                                },
                                                child: const Icon(
                                                    Icons.delete_outline))
                                          ],
                                        ).px4(),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  if (Books.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Books"
                                .text
                                .bold
                                .size(24)
                                // .color(GlobalVariables.mainColor)
                                .color(Color.fromARGB(255, 4, 83, 148))
                                .make(),
                            "Total Items : ${Books.length}".text.bold.make(),
                          ],
                        ).px16(),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 215,
                          margin: const EdgeInsets.only(left: 10),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Books.length,
                              itemBuilder: ((context, index) {
                                return Container(
                                  width: 180,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade100,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.maxFinite,
                                          height: 135,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      Books[index].images[0]),
                                                  fit: BoxFit.cover)),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Books[index]
                                            .name
                                            .text
                                            .ellipsis
                                            .size(18)
                                            .make()
                                            .px4(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            "\$${Books[index].price}"
                                                .text
                                                .bold
                                                .size(16)
                                                .make(),
                                            GestureDetector(
                                                onTap: () {
                                                  deleteProduct(
                                                      Books[index], index);
                                                  setState(() {});
                                                },
                                                child: const Icon(
                                                    Icons.delete_outline))
                                          ],
                                        ).px4(),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: navigateToAddScreen,
              tooltip: "Add a product",
              backgroundColor: const Color.fromARGB(255, 4, 83, 148),
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
