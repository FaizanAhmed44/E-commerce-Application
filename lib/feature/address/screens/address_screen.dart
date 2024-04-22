import 'package:amazon_clone/common/widgets/custom_field.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/feature/address/services/address_services.dart';
import 'package:amazon_clone/feature/order_detail/screen/order_review.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address-page';
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaStreetController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController townCityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  String addressToBeUsed = "";
  final AddressServices addressServices = AddressServices();

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaStreetController.dispose();
    pincodeController.dispose();
    townCityController.dispose();
  }

  void onSucess() {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    double sum = 0.0;

    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();

    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }

    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalPrice: sum,
    );
  }

  void onPayPressed(String address) {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaStreetController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        townCityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text} ${areaStreetController.text} - ${pincodeController.text}, ${townCityController.text}';
      } else {
        throw Exception("Please Enter All the Values");
      }
    } else if (address.isNotEmpty) {
      addressToBeUsed = address;
    } else {
      ShowSnackBar(context, "Error! Enter a valid address");
    }
    print(addressToBeUsed);
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(19),
              topRight: Radius.circular(19),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                spreadRadius: 2,
              )
            ]),
        child: GestureDetector(
          onTap: () {
            onPayPressed(address);
            // onSucess();
            Navigator.pushNamed(context, OrderReview.routeName,
                arguments: addressToBeUsed);
          },
          child: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 4, 83, 148),
              borderRadius: BorderRadius.circular(25),
            ),
            child: "Continue to Payment"
                .text
                .fontWeight(FontWeight.w500)
                .color(Colors.white)
                .xl
                .make()
                .centered(),
          ),
        ),
      ),
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
                width: 44,
              ),
              Text(
                "Address",
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
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            if (address.isNotEmpty)
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Current Address".text.bold.size(18).make(),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Home".text.fontWeight(FontWeight.w500).make(),
                                address.text
                                    .color(Colors.grey.shade500)
                                    .maxLines(2)
                                    .ellipsis
                                    .make()
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "OR",
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                ],
              ).px12(),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "New Address".text.bold.size(18).make().px24(),
                const SizedBox(
                  height: 6,
                ),
                Form(
                  key: _addressFormKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 18,
                      ),
                      CustomTextField(
                              controller: flatBuildingController,
                              text: "Flat, House no, Building")
                          .px(18),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                              controller: areaStreetController,
                              text: "Area, Street")
                          .px(18),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                              controller: pincodeController, text: "Pincode")
                          .px(18),
                      const SizedBox(
                        height: 38,
                      ),
                      CustomTextField(
                              controller: townCityController, text: "Town/City")
                          .px(18),
                      const SizedBox(
                        height: 38,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // GooglePayButton(
            //   paymentConfiguration:
            //       PaymentConfiguration.fromJsonString(defaultGooglePay),
            //   paymentItems: _paymentItems,
            //   type: GooglePayButtonType.buy,
            //   margin: const EdgeInsets.only(top: 15.0),
            //   onPaymentResult: onGooglePayResult,
            //   loadingIndicator: const Center(
            //     child: CircularProgressIndicator(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
