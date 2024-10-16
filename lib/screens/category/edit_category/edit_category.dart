// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:admin/constants/constants.dart';
import 'package:admin/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:admin/widgets/custom_textform_field/custom_textform_filed.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:admin/app_provider/app_provider.dart';
import 'package:admin/models/models/category_model/category_model.dart';
import 'package:admin/widgets/text/top_heading.dart';

class EditCategory extends StatefulWidget {
  final CategoryModel categoryModel;
  final int index;

  const EditCategory(
      {Key? key, required this.categoryModel, required this.index})
      : super(key: key);

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  @override
  void initState() {
    super.initState();
    name.text = widget.categoryModel.name;
  }

  Uint8List? image;
  TextEditingController name = TextEditingController();
  bool isUploading = false;

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: const CustomAppBar(
        name: 'Edit Category',
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
                const TopHeading(title: "Category Details"),
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
                          'Updating the category image and its name. Please wait a moment; this might take a bit of time',
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
                                      ? widget.categoryModel.image.isEmpty
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
                                                  widget.categoryModel.image),
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
                                child: CustomTextFormField(
                                  name: name,
                                  labelname: 'Category Name',
                                )),
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
                                  if (name.text.isNotEmpty) {
                                    setState(() {
                                      isUploading = true;
                                    });

                                    try {
                                      await appProvider.updateCategoryList(
                                        widget.index,
                                        name.text,
                                        image,
                                      );
                                      showMessage('Updated Successfully');
                                      Navigator.of(context).pop();
                                    } catch (error) {
                                      showMessage(
                                          'Failed to update category: $error');
                                    } finally {
                                      setState(() {
                                        isUploading = false;
                                      });
                                    }
                                  } else {
                                    showMessage(
                                        'Please fill the category name');
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
                                  : const Text('Update Category'),
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
