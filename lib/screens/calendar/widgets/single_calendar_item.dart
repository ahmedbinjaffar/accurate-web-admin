import 'package:admin/app_provider/app_provider.dart';
import 'package:admin/constants/colors.dart';
import 'package:admin/constants/constants.dart';
import 'package:admin/models/models/calendar_model/calendar_model.dart';
import 'package:admin/widgets/custom_delete_dialog/custom%20dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SingleCalendarItem extends StatefulWidget {
  const SingleCalendarItem({
    super.key,
    required this.singleCalendar,
    required this.index,
  });

  final PricingModel singleCalendar;
  final int index;

  @override
  State<SingleCalendarItem> createState() => _SingleCalendarItemState();
}

class _SingleCalendarItemState extends State<SingleCalendarItem> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > 800;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(isLargeScreen ? 20.0 : 10.0),
          child: Container(
            height: isLargeScreen ? 200 : 150,
            width: isLargeScreen ? 440 : size.width * 0.9,
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
                imageUrl: widget.singleCalendar.image,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[400]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: isLargeScreen ? 200 : 150,
                    width: isLargeScreen ? 440 : size.width * 0.9,
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
        ),
        Positioned(
          right: isLargeScreen ? 20 : 10,
          top: isLargeScreen ? 23 : 13,
          child: Container(
            width: isLargeScreen ? 61 : 40,
            height: isLargeScreen ? 30 : 20,
            decoration: BoxDecoration(
              color: AppClr.whiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: GestureDetector(
              onTap: () => _confirmDelete(context, appProvider),
              child: Icon(
                Icons.delete,
                color: AppClr.primaryColor,
                size: isLargeScreen ? 20 : 14,
              ),
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
      BuildContext context, AppProvider appProvider) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return ConfirmDeleteDialog(
          onConfirm: () async {
            setState(() {
              isLoading = true;
            });
            Navigator.of(context).pop();
            await appProvider.deleteCalendarFromFirebase(widget.singleCalendar);
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
