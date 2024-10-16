// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:typed_data';

import 'package:admin/app_provider/app_provider.dart';
import 'package:admin/constants/constants.dart';
import 'package:admin/constants/routes.dart';
import 'package:admin/screens/category/categories_view.dart';
import 'package:admin/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:admin/widgets/custom_textform_field/custom_textform_filed.dart';
import 'package:admin/widgets/text/top_heading.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  Uint8List? image;
  TextEditingController name = TextEditingController();
  bool isUploading = false;

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: const CustomAppBar(
        name: 'Add Category',
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
                const TopHeading(
                  title: "Category Details",
                ),
                const SizedBox(height: 20),
                addCategoryCard(context, appProvider),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card addCategoryCard(BuildContext context, AppProvider appProvider) {
    return Card(
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
              'Adding the category image and its name. Please wait a moment; this might take a bit of time',
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
                  child: CustomTextFormField(
                    name: name,
                    labelname: 'Category Name',
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
                      if (image != null && name.text.isNotEmpty) {
                        setState(() {
                          isUploading = true;
                        });

                        await Future.delayed(const Duration(seconds: 5));

                        try {
                          appProvider.addCategory(
                            image!,
                            name.text,
                          );
                          showMessage('Added Successfully');
                          Navigator.of(context).pop();
                          Routes.instance.push(
                              widget: const CategoriesView(), context: context);
                        } catch (error) {
                          showMessage('Failed to add category: $error');
                        } finally {
                          setState(() {
                            isUploading = false;
                          });
                        }
                      } else {
                        showMessage(
                            'Please fill all fields and select an image');
                      }
                    }
                  },
                  child: isUploading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Add Category'),
                ),
              ],
            ),
          ],
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
