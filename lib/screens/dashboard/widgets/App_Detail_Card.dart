// ignore_for_file: file_names

import 'package:admin/constants/colors.dart';
import 'package:flutter/material.dart';

class AppDetailCard extends StatelessWidget {
  const AppDetailCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.subtitle,
      required this.icon1,
      required this.color});

  final String title;
  final Icon icon;

  final Icon icon1;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53,
      margin: const EdgeInsets.only(top: defaultPadding),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: BorderRadius.circular(defaultPadding),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              //height: 10,
              //width: 20,
              child: Icon(
            icon.icon,
            size: 15,
            color: color,
          )),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            subtitle,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
