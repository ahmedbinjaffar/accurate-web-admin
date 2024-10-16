import 'dart:typed_data';
import 'package:admin/app_provider/app_provider.dart';
import 'package:admin/constants/colors.dart';
import 'package:admin/constants/constants.dart';
import 'package:admin/constants/routes.dart';
import 'package:admin/models/models/category_model/category_model.dart';
import 'package:admin/screens/product/product_view.dart';
import 'package:admin/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:admin/widgets/custom_textform_field/custom_textform_filed.dart';
import 'package:admin/widgets/text/top_heading.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  Uint8List? image;
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController url = TextEditingController();
  CategoryModel? _selectedCategory;
  bool isUploading = false;

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: const CustomAppBar(
        name: 'Add Product',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                        'Adding the product image and its details. Please wait a moment; this might take a bit of time',
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
                                    ? IconButton(
                                        onPressed: takePicture,
                                        icon: const Icon(
                                          Icons.camera_alt,
                                          size: 50,
                                          color: Colors.grey,
                                        ),
                                      )
                                    : CircleAvatar(
                                        backgroundImage: MemoryImage(image!),
                                        radius: 50,
                                      ),
                                const SizedBox(height: 10),
                                TextButton(
                                  onPressed: takePicture,
                                  child: const Text('Upload Image'),
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
                                ),
                                const SizedBox(height: 20),
                                CustomTextFormField(
                                  name: url,
                                  labelname: 'URL',
                                ),
                                const SizedBox(height: 20),
                                DropdownButtonFormField<CategoryModel>(
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintText: 'Please Select Category',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: AppClr.primaryColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  value: _selectedCategory,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedCategory = value;
                                    });
                                  },
                                  items: appProvider.getCategoriesList
                                      .map((CategoryModel category) {
                                    return DropdownMenuItem<CategoryModel>(
                                      value: category,
                                      child: Text(category.name),
                                    );
                                  }).toList(),
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
                                if (image == null ||
                                    _selectedCategory == null ||
                                    name.text.isEmpty ||
                                    description.text.isEmpty ||
                                    price.text.isEmpty ||
                                    url.text.isEmpty) {
                                  showMessage('Please fill all information');
                                } else {
                                  setState(() {
                                    isUploading = true;
                                  });

                                  try {
                                    appProvider.addProduct(
                                      image!,
                                      name.text,
                                      _selectedCategory!.id,
                                      price.text,
                                      description.text,
                                      url.text,
                                    );
                                    showMessage('Product added successfully');
                                    Navigator.of(context).pop();
                                    Routes.instance.push(
                                        widget: const ProductView(),
                                        context: context);
                                  } catch (error) {
                                    showMessage(
                                        'Failed to add product: $error');
                                  } finally {
                                    setState(() {
                                      isUploading = false;
                                    });
                                  }
                                }
                              }
                            },
                            child: isUploading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text('Add Product'),
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
