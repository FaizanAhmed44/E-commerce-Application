import 'dart:io';

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_field.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/feature/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

class AddProduct extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();

  String category = 'Mobiles';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productcategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.SellProduct(
        context: context,
        name: productNameController.text,
        description: descriptionController.text,
        quantity: double.parse(quantityController.text),
        price: double.parse(priceController.text),
        category: category,
        images: images,
      );
    }
  }

  void selectImages() async {
    var res = await pickImage();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          // flexibleSpace:/
          title: const Row(
            children: [
              SizedBox(
                width: 39,
              ),
              Text(
                "Add a Product",
                style: TextStyle(
                    // color: GlobalVariables.mainColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ).pOnly(left: 40, top: 6),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              images.isNotEmpty
                  ? CarouselSlider(
                      items: images.map((i) {
                        return Builder(
                          builder: (BuildContext context) => Image.file(
                            i,
                            fit: BoxFit.cover,
                            height: 200,
                          ),
                        );
                      }).toList(),
                      options: CarouselOptions(
                        viewportFraction: 1,
                        height: 200,
                      ),
                    )
                  : GestureDetector(
                      onTap: selectImages,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        dashPattern: const [10, 4],
                        strokeCap: StrokeCap.round,
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              "Select Product Image"
                                  .text
                                  .color(Colors.grey.shade400)
                                  .make(),
                            ],
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
                  controller: productNameController, text: "Product Name"),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: descriptionController,
                text: "Description",
                maxlines: 7,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(controller: priceController, text: "Price"),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(controller: quantityController, text: "Quantity"),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: DropdownButton(
                  value: category,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: productcategories.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? val) {
                    setState(() {
                      category = val!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                  color: const Color.fromARGB(255, 4, 83, 148),
                  text: "Sell",
                  onTap: sellProduct),
              const SizedBox(
                height: 20,
              ),
            ],
          ).px12(),
        ),
      ),
    );
  }
}
