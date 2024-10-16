// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:admin/app_provider/app_provider.dart';
import 'package:admin/constants/colors.dart';
import 'package:admin/constants/constants.dart';
import 'package:admin/constants/routes.dart';
import 'package:admin/screens/calendar/calendar_view.dart';
import 'package:admin/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:admin/widgets/text/top_heading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddCalendar extends StatefulWidget {
  const AddCalendar({Key? key}) : super(key: key);

  @override
  State<AddCalendar> createState() => _AddCalendarState();
}

class _AddCalendarState extends State<AddCalendar> {
  Uint8List? image;
  bool isUploading = false;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: const CustomAppBar(
        name: 'Add Catalog',
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
                  title: "Catalog Details",
                ),
                const SizedBox(height: 20),
                _buildAddCalendarCard(context, appProvider),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddCalendarCard(BuildContext context, AppProvider appProvider) {
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
              'Adding the catalog image. Please wait a moment; this might take a bit of time',
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
                          ? CupertinoButton(
                              onPressed: takePicture,
                              child: Container(
                                height: 300,
                                width: 490,
                                decoration: BoxDecoration(
                                    color:
                                        AppClr.gradientcolor1.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.black, width: 1)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: AppClr.gradientcolor3
                                          .withOpacity(0.4),
                                      radius: 55,
                                      child: const Icon(
                                        Icons.add,
                                        size: 30,
                                        color: AppClr.gradientcolor2,
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          : CupertinoButton(
                              onPressed: takePicture,
                              child: Container(
                                height: 300,
                                width: 490,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: MemoryImage(image!)),
                                    color:
                                        AppClr.gradientcolor1.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.black, width: 1)),
                              )),
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
                      if (image != null) {
                        setState(() {
                          isUploading = true;
                        });

                        await Future.delayed(const Duration(seconds: 5));

                        try {
                          appProvider.addCalendar(
                            image!,
                          );
                          showMessage('Added Successfully');
                          Navigator.of(context).pop();
                          Routes.instance.push(
                              widget: const CalendarView(), context: context);
                        } catch (error) {
                          showMessage('Failed to add calendar: $error');
                        } finally {
                          setState(() {
                            isUploading = false;
                          });
                        }
                      } else {
                        showMessage('Please select an image');
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
                      : const Text('Add Calendar'),
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
