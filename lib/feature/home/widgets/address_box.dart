import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 55,
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "Location".text.color(Colors.black54).size(15).make(),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Color(0xFF704F38),
                size: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Text(
                  "  ${user.address}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 4, top: 2),
                child: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Colors.black,
                  size: 20,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
