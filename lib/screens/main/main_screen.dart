import 'package:admin/app_provider/app_provider.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard_view.dart';
import 'package:admin/screens/main/widgets/slide_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final products = appProvider.getProducts;

    return Scaffold(
      key: context.read<MenuControllers>().scaffoldKey,
      drawer: const SlideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                child: SlideMenu(),
              ),
            Expanded(
              flex: 5,
              child: DashboardView(products: products),
            ),
          ],
        ),
      ),
    );
  }
}
