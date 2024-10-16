import 'dart:typed_data';
import 'package:admin/constants/constants.dart';
import 'package:admin/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:admin/widgets/custom_textform_field/custom_textform_filed.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:admin/app_provider/app_provider.dart';
import 'package:admin/models/models/product_model/product_model.dart';
import 'package:admin/widgets/text/top_heading.dart';

class EditProduct extends StatefulWidget {
  final ProductModel productModel;
  final int index;

  const EditProduct({Key? key, required this.productModel, required this.index})
      : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  Uint8List? image;
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController url = TextEditingController();
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    name.text = widget.productModel.name;
    description.text = widget.productModel.description;
    price.text = widget.productModel.price.toString();
    url.text = widget.productModel.url;
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: const CustomAppBar(
        name: 'Edit Product',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const TopHeading(title: "Product Details"),
                const SizedBox(height: 20),
                Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Updating the product image and its details. Please wait a moment; this might take a bit of time',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.white24),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  image == null
                                      ? widget.productModel.image.isEmpty
                                          ? IconButton(
                                              onPressed: takePicture,
                                              icon: const Icon(
                                                Icons.camera_alt,
                                                size: 50,
                                                color: Colors.grey,
                                              ),
                                            )
                                          : CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  widget.productModel.image),
                                              radius: 50,
                                            )
                                      : CircleAvatar(
                                          backgroundImage: MemoryImage(image!),
                                          radius: 50,
                                        ),
                                  const SizedBox(height: 10),
                                  TextButton(
                                    onPressed: takePicture,
                                    child: const Text('Change Image'),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            const VerticalDivider(
                              color: Colors.grey,
                              thickness: 1,
                              width: 1,
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  CustomTextFormField(
                                    name: name,
                                    labelname: 'Product Name',
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextFormField(
                                    name: description,
                                    labelname: 'Description',
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextFormField(
                                    name: price,
                                    labelname: 'Price',
                                    //keyboardType: TextInputType.number,
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextFormField(
                                    name: url,
                                    labelname: 'URL',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            const SizedBox(width: 8.0),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isUploading) {
                                  if (name.text.isNotEmpty &&
                                      price.text.isNotEmpty) {
                                    setState(() {
                                      isUploading = true;
                                    });

                                    try {
                                      await appProvider.updateProductList(
                                        widget.index,
                                        name.text,
                                        description.text,
                                        price.text,
                                        url.text,
                                        image,
                                      );
                                      showMessage('Updated Successfully');
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context).pop();
                                    } catch (error) {
                                      showMessage(
                                          'Failed to update product: $error');
                                    } finally {
                                      setState(() {
                                        isUploading = false;
                                      });
                                    }
                                  } else {
                                    showMessage(
                                        'Please fill all required fields');
                                  }
                                }
                              },
                              child: isUploading || appProvider.isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Colors.white,
                                        ),
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text('Update Product'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void takePicture() async {
    XFile? value = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );
    if (value != null) {
      Uint8List imageBytes = await value.readAsBytes();
      setState(() {
        image = imageBytes;
      });
    }
  }
}
