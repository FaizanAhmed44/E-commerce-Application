import 'package:amazon_clone/constant/global_var.dart';
import 'package:amazon_clone/feature/home/screens/category_deal_screen.dart';
import 'package:flutter/material.dart';

class TopCategory extends StatelessWidget {
  const TopCategory({super.key});

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDealScreen.routeName,
        arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 79,
      child: ListView.builder(
          itemCount: GlobalVariables.categoryImages.length,
          scrollDirection: Axis.horizontal,
          itemExtent: 80,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => navigateToCategoryPage(
                  context, GlobalVariables.categoryImages[index]['title']!),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        GlobalVariables.categoryImages[index]['image']!,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    GlobalVariables.categoryImages[index]['title']!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
