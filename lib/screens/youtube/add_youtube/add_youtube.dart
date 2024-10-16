import 'package:admin/app_provider/app_provider.dart';
import 'package:admin/constants/constants.dart';
import 'package:admin/constants/routes.dart';
import 'package:admin/screens/youtube/youtube_view.dart';
import 'package:admin/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:admin/widgets/custom_textform_field/custom_textform_filed.dart';
import 'package:admin/widgets/text/top_heading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddYoutube extends StatefulWidget {
  const AddYoutube({super.key});

  @override
  State<AddYoutube> createState() => _AddYoutubeState();
}

class _AddYoutubeState extends State<AddYoutube> {
  TextEditingController name = TextEditingController();
  TextEditingController url = TextEditingController();
  bool isUploading = false;

  // void showMessage(String message) {
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text(message)));
  // }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: const CustomAppBar(
        name: 'Add Youtube',
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
                const TopHeading(title: "Youtube Details"),
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
                          'Adding a new YouTube video. Please wait a moment; this might take a bit of time',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.white24),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 30),
                        CustomTextFormField(
                          name: name,
                          labelname: 'Youtube Name',
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          name: url,
                          labelname: 'Youtube URL',
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
                                      url.text.isNotEmpty) {
                                    setState(() {
                                      isUploading = true;
                                    });

                                    try {
                                      appProvider.addYoutube(
                                          name.text, url.text);
                                      showMessage('Added Successfully');
                                      Navigator.of(context).pop();
                                      Routes.instance.push(
                                          widget: const YoutubeView(),
                                          context: context);
                                    } catch (error) {
                                      showMessage(
                                          'Failed to add YouTube video: $error');
                                    } finally {
                                      setState(() {
                                        isUploading = false;
                                      });
                                    }
                                  } else {
                                    showMessage('Please fill both fields');
                                  }
                                }
                              },
                              child: isUploading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text('Add Youtube'),
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
}
