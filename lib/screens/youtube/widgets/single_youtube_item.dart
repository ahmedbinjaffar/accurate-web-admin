import 'package:admin/app_provider/app_provider.dart';
import 'package:admin/constants/colors.dart';
import 'package:admin/constants/constants.dart';
import 'package:admin/constants/routes.dart';
import 'package:admin/models/models/youtube_model/youtube_model.dart';
import 'package:admin/screens/youtube/edit_youtube/edit_youtube.dart';
import 'package:admin/widgets/custom_delete_dialog/custom%20dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SingleYoutubeItem extends StatefulWidget {
  const SingleYoutubeItem({
    super.key,
    required this.singleYoutube,
    required this.index,
    required this.containerWidth,
  });

  final YoutubeModel singleYoutube;
  final double containerWidth;
  final int index;

  @override
  State<SingleYoutubeItem> createState() => _SingleYoutubeItemState();
}

class _SingleYoutubeItemState extends State<SingleYoutubeItem> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > 800;

    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(isLargeScreen ? 20.0 : 10.0),
          height: isLargeScreen ? 210 : 150,
          width: widget.containerWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(188, 13, 72, 161),
                spreadRadius: 0.5,
                blurRadius: 2,
                offset: Offset(2, 2),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(9)),
            child: CachedNetworkImage(
              imageUrl: YoutubePlayer.getThumbnail(
                videoId: widget.singleYoutube.url,
              ),
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
        Positioned(
          right: isLargeScreen ? 21 : 11,
          top: isLargeScreen ? 23 : 13,
          child: Container(
            width: isLargeScreen ? 61 : 40,
            height: isLargeScreen ? 30 : 20,
            decoration: BoxDecoration(
              color: AppClr.whiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _confirmDelete(context, appProvider);
                  },
                  child: Icon(
                    Icons.delete,
                    color: AppClr.primaryColor,
                    size: isLargeScreen ? 20 : 14,
                  ),
                ),
                SizedBox(width: isLargeScreen ? 8 : 4),
                GestureDetector(
                  onTap: () {
                    Routes.instance.push(
                      widget: EditYoutube(
                        youtubeModel: widget.singleYoutube,
                        index: widget.index,
                      ),
                      context: context,
                    );
                  },
                  child: Icon(
                    Icons.edit,
                    color: AppClr.primaryColor,
                    size: isLargeScreen ? 20 : 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.7),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppClr.primaryColor,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    AppProvider appProvider,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDeleteDialog(
          onConfirm: () async {
            setState(() {
              isLoading = true;
            });
            Navigator.of(context).pop();
            await appProvider.deleteYoutubeFromFirebase(widget.singleYoutube);
            showMessage('Deleted Successfully');
            setState(() {
              isLoading = false;
            });
          },
        );
      },
    );
  }
}
