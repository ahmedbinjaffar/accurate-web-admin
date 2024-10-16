import 'package:admin/app_provider/app_provider.dart';
import 'package:admin/constants/constants.dart';
import 'package:admin/models/models/youtube_model/youtube_model.dart';
import 'package:admin/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:admin/widgets/custom_textform_field/custom_textform_filed.dart';
import 'package:admin/widgets/text/top_heading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditYoutube extends StatefulWidget {
  final YoutubeModel youtubeModel;
  final int index;

  const EditYoutube(
      {super.key, required this.youtubeModel, required this.index});

  @override
  State<EditYoutube> createState() => _EditYoutubeState();
}

class _EditYoutubeState extends State<EditYoutube> {
  TextEditingController name = TextEditingController();
  TextEditingController url = TextEditingController();
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    name.text = widget.youtubeModel.name;
    url.text = widget.youtubeModel.url;
  }

  // void showMessage(String message) {
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text(message)));
  // }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: const CustomAppBar(
        name: 'Edit Youtube',
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
                          'Updating the youtube details. Please wait a moment; this might take a bit of time',
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
                                  if (name.text.isNotEmpty ||
                                      url.text.isNotEmpty) {
                                    setState(() {
                                      isUploading = true;
                                    });

                                    YoutubeModel youtubeModel =
                                        widget.youtubeModel.copyWith(
                                      name: name.text.isEmpty
                                          ? widget.youtubeModel.name
                                          : name.text,
                                      url: url.text.isEmpty
                                          ? widget.youtubeModel.url
                                          : url.text,
                                    );

                                    try {
                                      appProvider.updateYoutubeList(
                                          widget.index, youtubeModel);
                                      showMessage('Updated Successfully');
                                      Navigator.of(context).pop();
                                    } catch (error) {
                                      showMessage(
                                          'Failed to update youtube: $error');
                                    } finally {
                                      setState(() {
                                        isUploading = false;
                                      });
                                    }
                                  } else {
                                    showMessage(
                                        'Please fill at least one field');
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
                                  : const Text('Update Youtube'),
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
