import 'package:admin/constants/colors.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/widgets/dashboard_files.dart';
import 'package:admin/screens/dashboard/widgets/app_detail_list.dart';
import 'package:admin/models/models/product_model/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'widgets/header.dart';

class DashboardView extends StatelessWidget {
  final List<ProductModel> products;

  const DashboardView({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const Header(),
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      const DashboardFiles(),
                      const SizedBox(height: defaultPadding),
                      _recentlyAdded(context),
                      if (Responsive.isMobile(context))
                        const SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) const AppDetailList(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  const SizedBox(width: defaultPadding),
                if (!Responsive.isMobile(context))
                  const Expanded(
                    flex: 2,
                    child: AppDetailList(),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _recentlyAdded(BuildContext context) {
    // Get the 6 most recently added products
    final recentProducts =
        products.length > 7 ? products.sublist(0, 7) : products;

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: secondaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recently Added',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white),
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              horizontalMargin: 0,
              columnSpacing: defaultPadding,
              columns: const [
                DataColumn(label: Text('Index')),
                DataColumn(label: Text('Product Name')),
                DataColumn(label: Text('Price')),
              ],
              rows: List.generate(
                recentProducts.length,
                (index) => _recentProductData(recentProducts[index], index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _recentProductData(ProductModel product, int index) {
    return DataRow(
      cells: [
        DataCell(Text('${index + 1}')),
        DataCell(
          Row(
            children: [
              CachedNetworkImage(
                width: 30,
                height: 30,
                imageUrl: product.image,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Shimmer.fromColors(
                  baseColor: Colors.grey[400]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    width: 30,
                    height: 30,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(product.name),
              ),
            ],
          ),
        ),
        DataCell(Text('${product.price}')),
      ],
    );
  }
}
