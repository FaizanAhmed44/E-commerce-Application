import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/constant/global_var.dart';
import 'package:amazon_clone/model/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchProduct extends StatelessWidget {
  final ProductModel product;
  const SearchProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;

    for (int i = 0; i < product.rating!.length; i++) {
      totalRating = product.rating![i].rating;
    }
    double avgRating = 0;
    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
    }
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.contain,
                height: 135,
                width: 130,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 220,
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(product.name,
                          style: const TextStyle(fontSize: 18), maxLines: 2),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 70,
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text('\$${product.price}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                              maxLines: 2),
                        ),
                        Container(
                          width: 120,
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Stars(rating: avgRating),
                        ),
                      ],
                    ),
                    Container(
                      width: 220,
                      padding: const EdgeInsets.only(bottom: 5),
                      child: const Text(
                        'Eligible For FREE Shipping',
                        style: TextStyle(fontSize: 13),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 220,
                      // padding: const EdgeInsets.only(left: 10, top: 5),
                      child: const Text('In Stock',
                          style: TextStyle(
                              color: GlobalVariables.mainColor, fontSize: 15),
                          maxLines: 2),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ).px12();
  }
}
