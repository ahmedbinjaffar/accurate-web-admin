// ignore_for_file: library_private_types_in_public_api

import 'package:admin/app_provider/app_provider.dart';
import 'package:admin/models/models/category_model/category_model.dart';
import 'package:admin/models/models/product_model/product_model.dart';
import 'package:admin/screens/product/edit_product/edit_product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/colors.dart';
import '../../../constants/constants.dart';
import '../../../constants/routes.dart';
import '../../../widgets/custom_delete_dialog/custom%20dialog.dart';

class SingleProductView extends StatefulWidget {
  const SingleProductView({
    Key? key,
    required this.singleProduct,
    required this.index,
  }) : super(key: key);

  final ProductModel singleProduct;
  final int index;

  @override
  _SingleProductViewState createState() => _SingleProductViewState();
}

class _SingleProductViewState extends State<SingleProductView> {
  bool isLoading = false;
  CategoryModel? _selectedCategory;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appProvider = Provider.of<AppProvider>(context, listen: false);
      if (appProvider.getCategoriesList.isNotEmpty) {
        setState(() {
          _selectedCategory = appProvider.getCategoriesList.firstWhere(
            (category) => category.id == widget.singleProduct.categoryid,
            orElse: () => CategoryModel(id: '', name: 'Unknown', image: ''),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 250,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppClr.whiteColor,
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(188, 13, 72, 161),
            spreadRadius: 0.5,
            blurRadius: 2,
            offset: Offset(2, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: AppClr.primaryColor),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                width: 80,
                height: 80,
                imageUrl: widget.singleProduct.image,
                progressIndicatorBuilder: (context, url, progress) =>
                    Shimmer.fromColors(
                  baseColor: Colors.grey[400]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(height: 10),
              Text(
                widget.singleProduct.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                _selectedCategory?.name ?? 'Category not found',
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => _confirmDelete(context),
                    child: const Icon(
                      Icons.delete,
                      color: AppClr.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      Routes.instance.push(
                        widget: EditProduct(
                          productModel: widget.singleProduct,
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
            ],
          ),
          if (isLoading)
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppClr.primaryColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDeleteDialog(onConfirm: () async {
          setState(() {
            isLoading = true;
          });

          Navigator.of(context).pop();
          await appProvider.deleteProductFromFirebase(widget.singleProduct);
          showMessage('Deleted Successfully');
          setState(() {
            isLoading = false;
          });
        });
      },
    );
  }
}
