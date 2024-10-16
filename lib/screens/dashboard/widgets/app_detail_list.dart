// ignore_for_file: prefer_const_constructors

import 'package:admin/app_provider/app_provider.dart';
import 'package:admin/screens/dashboard/widgets/App_Detail_Card.dart';
import 'package:admin/screens/dashboard/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';

class AppDetailList extends StatefulWidget {
  const AppDetailList({Key? key}) : super(key: key);

  @override
  State<AppDetailList> createState() => _AppDetailListState();
}

class _AppDetailListState extends State<AppDetailList> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'App Details',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Chart(),
          AppDetailCard(
            icon: const Icon(Icons.production_quantity_limits),
            icon1: const Icon(Icons.arrow_forward),
            title: 'Products',
            subtitle: appProvider.getProducts.length.toString(),
            color: primaryColor,
          ),
          AppDetailCard(
            icon: const Icon(Icons.category),
            icon1: const Icon(Icons.arrow_forward),
            title: 'Category',
            subtitle: appProvider.getCategoriesList.length.toString(),
            color: Colors.yellow,
          ),
          AppDetailCard(
            icon: const Icon(Icons.youtube_searched_for),
            icon1: const Icon(Icons.arrow_forward),
            title: 'YouTube',
            subtitle: appProvider.getYoutube.length.toString(),
            color: Colors.red,
          ),
          AppDetailCard(
            icon: const Icon(Icons.calendar_today),
            icon1: const Icon(Icons.arrow_forward),
            title: 'Catalog',
            subtitle: appProvider.getPricing.length.toString(),
            color: const Color.fromARGB(255, 128, 255, 251),
          ),
          AppDetailCard(
            icon: const Icon(Icons.image),
            icon1: const Icon(Icons.arrow_forward),
            title: 'Banner',
            subtitle: appProvider.getBanners.length.toString(),
            color: Color.fromARGB(255, 158, 15, 253),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchData() async {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    await appProvider.callBackFunction();
  }
}
