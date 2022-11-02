import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:order_med/model/cart_item_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_med/model/cart_model.dart';
import 'package:provider/provider.dart';

class UploadPrescription extends StatefulWidget {
  final CartItem item;
  final int index;

  const UploadPrescription({Key? key, required this.item, required this.index})
      : super(key: key);

  @override
  State<UploadPrescription> createState() => _UploadPrescriptionState();
}

class _UploadPrescriptionState extends State<UploadPrescription> {
  getImage() async {
    XFile? img = await ImagePicker().pickImage(source: ImageSource.gallery);
    context.read<Cart>().uploadPrescription(widget.index, img);
  }

  @override
  Widget build(BuildContext context) {
    CartItem item = widget.item;
    bool doesPrescription = item.product.doesRequirePrescription;
    bool isUploaded = item.isUploaded;
    File? prescription = item.prescription;
    if (doesPrescription) {
      if (isUploaded) {
        return Row(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 4),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: (kIsWeb
                      ? NetworkImage(prescription!.path)
                      : FileImage(prescription!)) as ImageProvider,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Expanded(
                child: Text(
              'Prescription Uploaded',
              style: TextStyle(color: Colors.green),
            )),
            TextButton(
                onPressed: () {
                  context.read<Cart>().removePrescription(widget.index);
                },
                child: const Text(
                  "Remove",
                  style: TextStyle(color: Colors.red),
                ))
          ],
        );
      } else {
        return Container(
          padding: const EdgeInsets.only(left: 4),
          decoration: const BoxDecoration(color: Colors.red),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Prescription is required!',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
              TextButton.icon(
                  onPressed: () {
                    getImage();
                  },
                  icon: const Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                  label: const Text(
                    'Upload',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )),
            ],
          ),
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }
}
