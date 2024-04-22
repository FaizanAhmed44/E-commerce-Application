import 'package:amazon_clone/constant/global_var.dart';
import 'package:amazon_clone/feature/home/widgets/carousel_image.dart';
import 'package:amazon_clone/feature/home/widgets/deal_of_day.dart';
import 'package:amazon_clone/feature/home/widgets/top_category.dart';
import 'package:amazon_clone/feature/search/screen/search_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, color: Colors.black),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Home".text.fontWeight(FontWeight.w500).make(),
                      user.address.isEmpty
                          ? "Add Address"
                              .text
                              .color(Colors.grey.shade500)
                              .maxLines(2)
                              .ellipsis
                              .make()
                          : user.address.text
                              .color(Colors.grey.shade500)
                              .maxLines(2)
                              .ellipsis
                              .make()
                    ],
                  ),
                ],
              ),
              const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 11, 112, 194),
                child: Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                ),
              ).pOnly(top: 5),
            ],
          ).pOnly(left: 20, right: 20, top: 10),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                height: 48,
                margin: const EdgeInsets.only(left: 15),
                child: Material(
                  borderRadius: BorderRadius.circular(28),
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
                          Radius.circular(28),
                        ),
                        borderSide: BorderSide(color: Colors.black12, width: 1),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(28),
                        ),
                        borderSide: BorderSide(color: Colors.black12, width: 1),
                      ),
                      hintText: "Search",
                      hintStyle:
                          const TextStyle(color: Colors.black38, fontSize: 19),
                    ),
                  ),
                ),
              )),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: const Icon(
                  Icons.mic,
                  color: GlobalVariables.mainColor,
                  size: 23,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          const CarouselImage().px16(),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Category"
                  .text
                  .bold
                  .size(24)
                  .color(const Color.fromARGB(255, 4, 83, 148))
                  .make(),
              "See All".text.size(15).make(),
            ],
          ).px20(),
          const SizedBox(
            height: 20,
          ),
          const TopCategory(),
          const SizedBox(
            height: 10,
          ),
          const DealOfDay(),
        ],
      ),
    ));
  }
}
