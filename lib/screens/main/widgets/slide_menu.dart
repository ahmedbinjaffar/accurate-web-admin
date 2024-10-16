import 'package:admin/screens/banner/banner_view.dart';
import 'package:flutter/material.dart';
import 'package:admin/constants/asset_image.dart';
import 'package:admin/constants/colors.dart';
import 'package:admin/constants/routes.dart';
import 'package:admin/screens/calendar/calendar_view.dart';
import 'package:admin/screens/category/categories_view.dart';
import 'package:admin/screens/product/product_view.dart';
import 'package:admin/screens/youtube/youtube_view.dart';

class SlideMenu extends StatelessWidget {
  const SlideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(
                  AssetsImages.instance.logoImage,
                ),
              ),
            ),
            _buildDrawerListTile(
              context,
              title: 'Dashboard',
              icon: Icons.space_dashboard_outlined,
              onPressed: () {},
            ),
            _buildDrawerListTile(
              context,
              title: 'Categories',
              icon: Icons.category,
              onPressed: () => Routes.instance
                  .push(widget: const CategoriesView(), context: context),
            ),
            _buildDrawerListTile(
              context,
              title: 'Products',
              icon: Icons.production_quantity_limits_rounded,
              onPressed: () => Routes.instance
                  .push(widget: const ProductView(), context: context),
            ),
            _buildDrawerListTile(
              context,
              title: 'Catalog',
              icon: Icons.calendar_month,
              onPressed: () => Routes.instance
                  .push(widget: const CalendarView(), context: context),
            ),
            _buildDrawerListTile(
              context,
              title: 'YouTube',
              icon: Icons.youtube_searched_for,
              onPressed: () => Routes.instance
                  .push(widget: const YoutubeView(), context: context),
            ),
            _buildDrawerListTile(
              context,
              title: 'Banner',
              icon: Icons.image,
              onPressed: () => Routes.instance
                  .push(widget: const BannerView(), context: context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerListTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onPressed, // from dart:ui
  }) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 5),
      horizontalTitleGap: 10.0,
      onTap: onPressed,
      leading: Icon(icon, color: Colors.white54, size: 16),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }
}
