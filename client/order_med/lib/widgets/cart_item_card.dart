import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_med/model/cart_item_model.dart';
import 'package:order_med/model/cart_model.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatefulWidget {
  CartItem item;
  int index;

  CartItemWidget({Key? key, required this.item, required this.index})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<CartItemWidget> createState() =>
      _CartItemWidgetState(item: item, index: index);
}

class _CartItemWidgetState extends State<CartItemWidget> {
  CartItem item;
  int index;

  _CartItemWidgetState({required this.item, required this.index});

  getImage() async {
    XFile? p = await ImagePicker().pickImage(source: ImageSource.gallery);
    item.prescription = (File(p!.path));
    item.isUploaded = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Cart.incrementQuantity(index);
                        setState(() {});
                        print("++");
                      },
                      icon: const Icon(
                        Icons.add_circle,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: Text('${item.quantity}'),
                    ),
                    IconButton(
                      onPressed: () {
                        Cart.decrementQuantity(index);
                        setState(() {});
                        print("--");
                      },
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                    ),
                  ],
                ),
                Text(
                  item.product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  ' (Avail. ${item.product.quantityAvailable})',
                ),
                Expanded(child: Container()),
                IconButton(
                    onPressed: () {
                      context.read<Cart>().remove(index);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))
              ],
            ),
            if (item.product.doesRequirePrescription && !item.isUploaded)
              Row(
                children: [
                  TextButton.icon(
                      onPressed: () {
                        getImage();
                      },
                      icon: const Icon(Icons.camera_alt_rounded),
                      label: const Text('Upload')),
                  Container(
                    padding: const EdgeInsets.all(1),
                    child: const Text('Prescription is required.'),
                  ),
                ],
              )
            else if (item.product.doesRequirePrescription && item.isUploaded)
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: FileImage(item.prescription!),
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
