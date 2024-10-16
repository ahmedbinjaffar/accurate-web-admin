import 'package:admin/constants/constants.dart';
import 'package:admin/constants/routes.dart';
import 'package:admin/screens/category/edit_category/edit_category.dart';
import 'package:admin/widgets/custom_delete_dialog/custom%20dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin/app_provider/app_provider.dart';
import 'package:admin/constants/colors.dart';
import 'package:admin/models/models/category_model/category_model.dart';
import 'package:shimmer/shimmer.dart';

class SingleCategoryItem extends StatefulWidget {
  final CategoryModel singleCategory;
  final int index;

  const SingleCategoryItem({
    Key? key,
    required this.singleCategory,
    required this.index,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SingleCategoryItemState createState() => _SingleCategoryItemState();
}

class _SingleCategoryItemState extends State<SingleCategoryItem> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);

    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                color: AppClr.whiteColor,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: widget.singleCategory.image,
                  width: 160,
                  height: 160,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Shimmer.fromColors(
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 15,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _confirmDelete(context, appProvider),
                    child: const Icon(
                      Icons.delete,
                      color: AppClr.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Routes.instance.push(
                        widget: EditCategory(
                          categoryModel: widget.singleCategory,
                          index: widget.index,
                        ),
                        context: context,
                      );
                    },
                    child: const Icon(
                      Icons.edit,
                      color: AppClr.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            if (isLoading)
              Positioned.fill(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[400]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          widget.singleCategory.name,
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, AppProvider appProvider) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDeleteDialog(
          onConfirm: () async {
            setState(() {
              isLoading = true;
            });
            Navigator.of(context).pop();
            await appProvider.deleteCategoryFromFirebase(widget.singleCategory);
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
