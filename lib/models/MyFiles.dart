// ignore_for_file: file_names

import 'package:admin/constants/colors.dart';
import 'package:admin/constants/routes.dart';
import 'package:admin/screens/banner/add_banner/add_banner.dart';
import 'package:admin/screens/calendar/add_calendar/add_calendar.dart';
import 'package:admin/screens/category/add_category/add_category.dart';
import 'package:admin/screens/product/add_product/add_product.dart';
import 'package:admin/screens/youtube/add_youtube/add_youtube.dart';
import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String title;
  final Color color;
  final void Function(BuildContext) onPressed;

  CloudStorageInfo(
      {required this.title, required this.color, required this.onPressed});
}

List demoMyFiels = [
  CloudStorageInfo(
      title: "Catgeory",
      color: primaryColor,
      onPressed: (context) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddCategory(),
            ));
      }),
  CloudStorageInfo(
    title: "Products",
    color: const Color(0xFFFFA113),
    onPressed: (context) {
      Routes.instance.push(widget: const AddProduct(), context: context);
    },
  ),
  CloudStorageInfo(
    title: "Catalog",
    color: const Color(0xFFA4CDFF),
    onPressed: (context) {
      Routes.instance.push(widget: const AddCalendar(), context: context);
    },
  ),
  CloudStorageInfo(
    title: "YouTube",
    color: const Color(0xFF007EE5),
    onPressed: (context) {
      Routes.instance.push(widget: const AddYoutube(), context: context);
    },
  ),
  CloudStorageInfo(
    title: "Banner",
    color: const Color(0xFFA4CDFF),
    onPressed: (context) {
      Routes.instance.push(widget: const AddBanner(), context: context);
    },
  ),
];
